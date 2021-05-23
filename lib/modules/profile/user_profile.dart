import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class UserProfileScreen extends StatelessWidget {
  int index;
  UserProfileScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = HomeCubit.get(context).users[index];
        return Scaffold(
          appBar: defaultAppBar(
            txt: user.name.split(' ')[0].toString() + "'s Profile",
            context: context,
            actions: [
              IconButton(
                  icon: Icon(
                    IconBroken.More_Square,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {}),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                                    image: NetworkImage(user.cover),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(user.image),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      user.name,
                      style:
                          TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      user.bio,
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
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
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
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
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
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
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
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
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
                          child: true
                              ? MaterialButton(
                                  color: Colors.deepPurple,
                                  onPressed: () {},
                                  child: Text(
                                    'Follow'.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                )
                              : OutlinedButton(
                                  child: Text('Unfollow'.toUpperCase()),
                                  onPressed: () {},
                                ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        OutlinedButton(
                          child: Icon(
                            IconBroken.Chat,
                            size: 18.0,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    DefaultTabController(
                      initialIndex: 0,
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: TabBar(
                              tabs: [
                                Tab(text: 'Posts'),
                                Tab(text: 'Photos'),
                              ],
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.deepPurple,
                              indicator: BubbleTabIndicator(
                                indicatorHeight: 30.0,
                                indicatorColor: Colors.deepPurple,
                                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                              ),
                            ),
                          ),
                          Container(
                            height: double.maxFinite,
                            width: double.infinity,
                            child: TabBarView(
                              children: [
                                ListView.builder(
                                  itemCount: HomeCubit.get(context).posts.length,
                                  shrinkWrap: false,
                                  itemBuilder: (context, index) {
                                    if (HomeCubit.get(context)
                                            .posts[index]
                                            .userID ==
                                        user.userID)
                                      return buildPost(
                                          context,
                                          HomeCubit.get(context).posts[index],
                                          index);
                                    return SizedBox(
                                      height: 0.0,
                                    );
                                  },
                                  physics: NeverScrollableScrollPhysics(),
                                ),
                                Text(
                                  'photos',
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
