import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).userModel;
        nameController.text = model.name;
        bioController.text = model.bio;
        phoneController.text = model.phone;
        return Scaffold(
            appBar:
                defaultAppBar(context: context, txt: 'Edit Profile', actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: TextButton(
                    onPressed: state is ProfileImageUploadLoadingState || state is CoverImageUploadLoadingState ? null : () {
                      HomeCubit.get(context).updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                    },
                    child: Text(
                      'Save Changes',
                      style: TextStyle(color: state is ProfileImageUploadLoadingState || state is CoverImageUploadLoadingState ? Colors.grey : Colors.blue),
                    )),
              ),
            ]),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is UpdateUserLoadingState)
                    LinearProgressIndicator(),
                  if(state is UpdateUserLoadingState)
                    SizedBox(height: 5.0,),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 140.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    image: DecorationImage(
                                      image: HomeCubit.get(context).coverImage == null
                                          ? NetworkImage(model.cover)
                                          : FileImage(HomeCubit.get(context).coverImage),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20.0,
                                  child: IconButton(
                                      icon: Icon(IconBroken.Camera),
                                      onPressed: () {
                                        HomeCubit.get(context).getCoverImage();
                                      }),
                                ),
                              ),
                              if(state is CoverImageUploadLoadingState)
                                Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Center(child: LinearProgressIndicator(),),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 64.0,
                          backgroundColor: Colors.white,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Align(
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: HomeCubit.get(context).profileImage == null
                                      ? NetworkImage(model.image)
                                      : FileImage(
                                          HomeCubit.get(context).profileImage),
                                ),
                                alignment: AlignmentDirectional.center,
                              ),
                              CircleAvatar(
                                radius: 20.0,
                                child: IconButton(
                                    icon: Icon(IconBroken.Camera),
                                    onPressed: () {
                                      HomeCubit.get(context).getProfileImage();
                                    }),
                              ),
                              if(state is ProfileImageUploadLoadingState)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Center(child: CircularProgressIndicator()),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    onValidation: (String value) {
                      if (value.isEmpty) return 'Name must not be empty';
                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    onValidation: (String value) {
                      if (value.isEmpty) return 'Bio must not be empty';
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    onValidation: (String value) {
                      if (value.isEmpty) return 'Phone must not be empty';
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ));
      },
    );
  }
}
