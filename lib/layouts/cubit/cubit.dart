import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/list_of_chats/chat_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  void getUserData() {
    emit(HomeGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      emit(HomeGetUserErrorState(error));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ListOFChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];
  List<String> titles = ['News Feeds', 'Chats', 'New Post', 'Users', 'Profile'];

  void changeBottomNav(int index) {
    if(index == 1)
      getAllUsers();
    if (index == 2)
      emit(HomeNewPostState());
    else {
      currentIndex = index;
      emit(HomeChangeBottomNavState());
    }
  }

  var picker = ImagePicker();

  String profileImageUrl = '';
  void uploadProfileImage() {
    emit(ProfileImageUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(ProfileImageUploadSuccessState());
        profileImageUrl = value;
        print(value);
      }).catchError((onError) {
        emit(ProfileImageUploadErrorState());
      });
    }).catchError((error) {
      emit(ProfileImageUploadErrorState());
    });
  }

  String coverImageUrl = '';
  void uploadCoverImage() {
    emit(CoverImageUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(CoverImageUploadSuccessState());
        coverImageUrl = value;
        print(value);
      }).catchError((onError) {
        emit(CoverImageUploadErrorState());
      });
    }).catchError((error) {
      emit(CoverImageUploadErrorState());
    });
  }

  String postImageUrl = '';
  void uploadPostImage() {
    emit(PostImageUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(PostImageUploadSuccessState());
        postImageUrl = value;
        print(value);
      }).catchError((onError) {
        emit(PostImageUploadErrorState());
      });
    }).catchError((error) {
      emit(PostImageUploadErrorState());
    });
  }

  File profileImage;
  Future<void> getProfileImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(ProfileImagePickedSuccessState());
      uploadProfileImage();
    } else {
      emit(ProfileImagePickedErrorState());
      showToast(msg: 'No Image Selected', color: Colors.grey.withOpacity(0.6));
    }
  }

  File coverImage;
  Future<void> getCoverImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(CoverImagePickedSuccessState());
      uploadCoverImage();
    } else {
      emit(CoverImagePickedErrorState());
      showToast(msg: 'No Image Selected', color: Colors.amber.withOpacity(0.6));
    }
  }

  File postImage;
  Future<void> getPostImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(PostImagePickedSuccessState());
      uploadPostImage();
    } else {
      emit(PostImagePickedErrorState());
      showToast(msg: 'No Image Selected', color: Colors.amber.withOpacity(0.6));
    }
  }

  void removePostImage() {
    postImage = null;
    emit(PostImageRemoveState());
  }

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(UpdateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel.email,
      userID: userModel.userID,
      cover: coverImageUrl != '' ? coverImageUrl : userModel.cover,
      image: profileImageUrl != '' ? profileImageUrl : userModel.image,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserErrorState());
    });
  }

  void createNewPost({
    @required String text,
    @required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    print(userModel.image);
    PostModel post = PostModel(
      image: userModel.image,
      name: userModel.name,
      userID: uId,
      text: text,
      dateTime: dateTime,
      postImage: postImageUrl != '' ? postImageUrl : null,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(post.toMap())
        .then((value) {
      removePostImage();
      emit(CreatePostSuccessState());
      getPosts();
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsID = [];
  List<int> postsLikes = [];
  List<int> postsComments = [];

  void getPosts() {
    emit(HomeGetPostsLoadingState());
    posts = [];
    postsID = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          postsLikes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postsID.add(element.id);
        });
        //TODO:get comments number for each post
        // element.reference.collection('comments').get().then((value) {
        //   postsComments.add(value.docs.length);
        // });
      });
      emit(HomeGetPostsSuccessState());
    }).catchError((error) {
      emit(HomeGetPostsErrorState(error.toString()));
    });
  }

  void likePost({String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uId)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  CommentModel comment;
  List<CommentModel> comments = [];

  void getComment({String postId}) {
    comments = [];
    emit(GetCommentLoadingState());
    FirebaseFirestore.instance.collection('posts').doc(postId).get().then((value) {
      value.reference.collection('comments').get().then((value) {
        value.docs.forEach((element) {
          comments.add(CommentModel.fromJson(element.data()));
        });
        emit(GetCommentSuccessState());
      });
    }).catchError((error){
      emit(GetCommentErrorState());
    });
  }

  void addComment({String postId, String comment}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc()
        .set({
      'comment': comment,
      'time': DateTime.now(),
      'image': userModel.image,
      'name': userModel.name
    }).then((value) {
      emit(CommentSuccessState());
      getComment(postId: postId);
    }).catchError((error) {
      emit(CommentErrorState());
    });
  }

  List<UserModel> users=[];

  void getAllUsers(){
    users=[];
    emit(HomeGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element){
        if(element.data()['uID'] != userModel.userID)
          users.add(UserModel.fromJson(element.data()));
      });
    }).then((value) {
      emit(HomeGetAllUsersSuccessState());
    }).catchError((error){
      emit(HomeGetAllUsersErrorState(error));
    });
  }

  void sendMessage({
  @required String text,
  @required String dateTime,
  @required String receiverID,
}){
    MessageModel model = MessageModel(text, receiverID, userModel.userID, dateTime);
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel.userID)
    .collection('chats')
    .doc(receiverID)
    .collection('messages')
    .add(model.toMap()).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(userModel.userID)
        .collection('messages')
        .add(model.toMap()).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({@required String receiverID}){
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel.userID)
    .collection('chats')
    .doc(receiverID)
    .collection('messages')
    .orderBy('dateTime')
    .snapshots()
    .listen((event) {
      messages = [];
      event.docs.forEach((element) {
          messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
    });
  }
}
