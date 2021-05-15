import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
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
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];
  List<String> titles = ['News Feeds', 'Chats', 'New Post', 'Users', 'Profile'];

  void changeBottomNav(int index) {
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
      showToast(msg: 'No Image Selected', color: Colors.amber.withOpacity(0.6));
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

  void removePostImage(){
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
      image:  profileImageUrl != '' ? profileImageUrl : userModel.image,
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
}){
    emit(CreatePostLoadingState());
    PostModel post = PostModel(
      userID: uId,
      text: text,
      dateTime: dateTime,
      postImage: postImageUrl != '' ? postImageUrl : null,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(post.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }


}
