import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'News Feed',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
        body: ConditionalBuilder(
          condition: HomeCubit.get(context).userModel != null,
          builder: (context) {
            var model = HomeCubit.get(context).userModel;
            print(model.isEmailVerified);
            return Column(
              children: [
                if (!model.isEmailVerified)
                  Container(
                    color: Colors.amber.withOpacity(0.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(width: 10.0),
                          Text('Please verify your email'),
                          Spacer(),
                          defaultTextButton(
                              text: 'send',
                              fn: () {
                                FirebaseAuth.instance.currentUser
                                    .sendEmailVerification()
                                    .then((value) {
                                      showToast(msg: 'Check your email', color: Colors.green);
                                })
                                    .catchError((error) {});
                              }),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
