import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class AddCommentScreen extends StatelessWidget {
  int postIndex;
  AddCommentScreen(this.postIndex);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              txt: HomeCubit.get(context).posts[postIndex].name.split(' ')[0] +
                  '\'s post'),
          body: ConditionalBuilder(
            condition: state is !GetCommentLoadingState,
            builder: (context) => buildPostComments(
              context,
              HomeCubit.get(context).posts[postIndex],
              HomeCubit.get(context).postsID[postIndex],
              HomeCubit.get(context).comments,
              HomeCubit.get(context).postsLikes[postIndex],
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

Widget buildPostComments(context, PostModel model, String index,List<CommentModel>comments,int likes) {
  var commentController = TextEditingController();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //name and time bar
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
                    model.dateTime
                        .substring(0, 16)
                        .replaceRange(10, 11, ' at '),
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
        //separator
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),
        //post
        Text(
          model.text,
          style: TextStyle(),
        ),
        //post image
        if (model.postImage != null)
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
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
                      likes.toString(),
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              Expanded(
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
                      '${comments.length.toString()} comments',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        //separator
        Container(
          height: 1.0,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        //comments section
        Expanded(
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Column(
                children: [
                  if(index == 0)
                  SizedBox(height: 10.0,),
                  SizedBox(height: 5.0,),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                           comments[index].image),
                        radius: 25.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Container(
                          height: comments[index].comment.length > 22 ? null : 54,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${comments[index].name}  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Icon(Icons.more_horiz,size: 18.0,),
                                  ],
                                ),
                                Text(comments[index].comment),
                              ],
                            )
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '15m ago',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  )
                ],
              ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 0.0,
                  ),
              itemCount: HomeCubit.get(context).comments.length),
        ),
        //separator
        Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),
        //write comment
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          HomeCubit.get(context).userModel.image),
                      radius: 15.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a comment...',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if(commentController.text != '' )
                    HomeCubit.get(context).addComment(
                        postId: index,
                        comment: commentController.text,
                    );
                },
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Send,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Comment',
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
  );
}
