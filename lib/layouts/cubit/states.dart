abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class HomeGetUserSuccessState extends HomeStates{}

class HomeGetUserLoadingState extends HomeStates{}

class HomeGetUserErrorState extends HomeStates{
  final String error;
  HomeGetUserErrorState(this.error);
}

class HomeChangeBottomNavState extends HomeStates{}

class HomeNewPostState extends HomeStates{}

class ProfileImagePickedSuccessState extends HomeStates{}

class ProfileImagePickedErrorState extends HomeStates{}

class CoverImagePickedSuccessState extends HomeStates{}

class CoverImagePickedErrorState extends HomeStates{}

class PostImagePickedSuccessState extends HomeStates{}

class PostImagePickedErrorState extends HomeStates{}

class PostImageRemoveState extends HomeStates{}

class PostImageUploadSuccessState extends HomeStates{}

class PostImageUploadErrorState extends HomeStates{}

class PostImageUploadLoadingState extends HomeStates{}


class ProfileImageUploadSuccessState extends HomeStates{}

class ProfileImageUploadErrorState extends HomeStates{}

class ProfileImageUploadLoadingState extends HomeStates{}

class CoverImageUploadSuccessState extends HomeStates{}

class CoverImageUploadLoadingState extends HomeStates{}

class CoverImageUploadErrorState extends HomeStates{}

class UpdateUserErrorState extends HomeStates{}

class UpdateUserLoadingState extends HomeStates{}

class CreatePostLoadingState extends HomeStates{}

class CreatePostSuccessState extends HomeStates{}

class CreatePostErrorState extends HomeStates{}
