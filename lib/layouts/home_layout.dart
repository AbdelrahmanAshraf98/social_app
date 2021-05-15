import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is HomeNewPostState)
          navigateTo(NewPostScreen(), context);
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(color: Colors.deepPurple),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    IconBroken.Search,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    IconBroken.Notification,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {}),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Profile), label: 'Profile'),
            ],
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
// ConditionalBuilder(
// condition: HomeCubit.get(context).userModel != null,
// builder: (context) {
// var model = HomeCubit.get(context).userModel;
// print(model.isEmailVerified);
// return Column(
// children: [
// if (!model.isEmailVerified)
// Container(
// color: Colors.amber.withOpacity(0.6),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// child: Row(
// children: [
// Icon(Icons.info_outline),
// SizedBox(width: 10.0),
// Text('Please verify your email'),
// Spacer(),
// defaultTextButton(
// text: 'send',
// fn: () {
// FirebaseAuth.instance.currentUser
//     .sendEmailVerification()
//     .then((value) {
// showToast(msg: 'Check your email', color: Colors.green);
// })
//     .catchError((error) {});
// }),
// ],
// ),
// ),
// ),
// ],
// );
// },
// fallback: (context) => Center(
// child: CircularProgressIndicator(),
// ),
// ));
