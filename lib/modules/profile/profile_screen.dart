import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 140.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              image: NetworkImage(model.cover),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(model.image),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                model.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              Text(
                model.bio,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontSize: 14.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '105',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '256',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '10k',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '65',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      child: Text('Add Photos'),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  OutlinedButton(
                    child: Icon(IconBroken.Edit,size: 18.0,),
                    onPressed: () {
                      navigateTo(EditProfileScreen(), context);
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
