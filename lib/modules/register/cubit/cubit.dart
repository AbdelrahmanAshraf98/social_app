import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      createUser(name: name, email: email, uId: value.user.uid, phone: phone);
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  void createUser({
    @required String name,
    @required String email,
    @required String uId,
    @required String phone,
  }) {
    emit(CreateUserLoadingState());
    UserModel userModel = UserModel(
      email: email,
      name: name,
      phone: phone,
      userID: uId,
      isEmailVerified: false,
      cover: 'https://image.freepik.com/free-vector/gradient-starry-night-sky-with-falling-stars_23-2148266268.jpg',
      bio: 'Write your bio...',
      image: 'https://image.freepik.com/free-photo/excited-happy-couple-use-mobile-phone-playing-online-games-look-impressively-smartphone-device-being-obssessed-with-modern-technologies-dressed-fashionable-clothes-internet-addiction_273609-30936.jpg',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangeRegisterPasswordVisibilityState());
  }
  
}
