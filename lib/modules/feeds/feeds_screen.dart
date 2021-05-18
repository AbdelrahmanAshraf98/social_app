import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/add_comment/add_comment.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).posts != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        height: 200.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/young-brunette-woman-wearing-purple-sweater-holding-cup-coffee_273609-22291.jpg'),
                      ),
                      Container(
                        height: 35.0,
                        color: Colors.deepPurple.withOpacity(.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Communicate with Friends',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  itemBuilder: (context, index) => buildPost(context,HomeCubit.get(context).posts[index],index),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: HomeCubit.get(context).posts.length,
                )
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}

Widget buildPost(context,PostModel model,int index) => Card(
      margin: EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(model.image),
                  radius: 25.0,
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.name,
                            style: TextStyle(
                                height: 1.4, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.deepPurple,
                            size: 15.0,
                          )
                        ],
                      ),
                      Text(
                        model.dateTime.substring(0,16).replaceRange(10, 11, ' at '),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15.0),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 18.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Text(
              model.text,
              style: TextStyle(),
            ),
            //#tags
            // Container(
            //   width: double.infinity,
            //   child: Wrap(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(end: 6.0),
            //         child: Container(
            //           height: 20.0,
            //           child: MaterialButton(
            //             height: 25.0,
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //             onPressed: () {},
            //             child: Text(
            //               '#Software',
            //               style: TextStyle(color: Colors.deepPurple),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(end: 6.0),
            //         child: Container(
            //           height: 20.0,
            //           child: MaterialButton(
            //             height: 25.0,
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //             onPressed: () {},
            //             child: Text(
            //               '#Software_Development',
            //               style: TextStyle(color: Colors.deepPurple),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(end: 6.0),
            //         child: Container(
            //           height: 20.0,
            //           child: MaterialButton(
            //             height: 25.0,
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //             onPressed: () {},
            //             child: Text(
            //               '#Developer',
            //               style: TextStyle(color: Colors.deepPurple),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(end: 6.0),
            //         child: Container(
            //           height: 20.0,
            //           child: MaterialButton(
            //             height: 25.0,
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //             onPressed: () {},
            //             child: Text(
            //               '#Computer_Science',
            //               style: TextStyle(color: Colors.deepPurple),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(end: 6.0),
            //         child: Container(
            //           height: 20.0,
            //           child: MaterialButton(
            //             height: 25.0,
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //             onPressed: () {},
            //             child: Text(
            //               '#Software_Engineer',
            //               style: TextStyle(color: Colors.deepPurple),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(end: 6.0),
            //         child: Container(
            //           height: 20.0,
            //           child: MaterialButton(
            //             height: 25.0,
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //             onPressed: () {},
            //             child: Text(
            //               '#Hardware',
            //               style: TextStyle(color: Colors.deepPurple),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //postimage
            if(model.postImage != null)
              Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 150.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(model.postImage),
                  ),
                ),
              ),
            ),
            //likes and comments
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            HomeCubit.get(context).postsLikes[index].toString(),
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '0 Comments',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            //separator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            //write comment - like button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(HomeCubit.get(context).userModel.image),
                          radius: 15.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: (){
                            HomeCubit.get(context).getComment(postId: HomeCubit.get(context).postsID[index]);
                            navigateTo(AddCommentScreen(index),context);
                          },
                          child: Text(
                            'Write a comment...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HomeCubit.get(context).likePost(postId: HomeCubit.get(context).postsID[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(color: Colors.grey),
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
    );
