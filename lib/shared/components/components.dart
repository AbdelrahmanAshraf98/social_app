import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/add_comment/add_comment.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

void showToast({@required String msg, @required Color color}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget defaultAppBar({
  @required BuildContext context,
  String txt,
  List<Widget> actions,
}) =>
    AppBar(
      titleSpacing: 5.0,
      leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2,color: Colors.deepPurple,),onPressed: (){
        Navigator.pop(context);
      },),
      title: Text(txt,style: TextStyle(color: Colors.deepPurple),),
      actions: actions,
    );

Widget defaultTextButton({
  @required String text,
  @required Function fn,
}) {
  return TextButton(
      onPressed: fn,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.w600,
        ),
      ));
}

Widget defaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required Function onValidation,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  bool isPassword = false,
  Function suffixFn,
}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      validator: onValidation,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixFn,
              )
            : null,
      ),
    );

Widget defaultMaterialButton({
  @required String text,
  @required Function fn,
  context,
}) =>
    Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).primaryColor,
        ),
        child: MaterialButton(
          onPressed: fn,
          child: Text(
            text.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ));

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
                  onTap: () {
                    HomeCubit.get(context).getComment(postId: HomeCubit.get(context).postsID[index]);
                    navigateTo(AddCommentScreen(index),context);
                  },
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
                        'Comments',
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
                child: InkWell(
                  onTap: (){
                    HomeCubit.get(context).getComment(postId: HomeCubit.get(context).postsID[index]);
                    navigateTo(AddCommentScreen(index),context);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(HomeCubit.get(context).userModel.image),
                        radius: 15.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Write a comment...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
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

navigateTo(Widget route, context){
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ));
}

navigateAndFinish(Widget route, context) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => route,
        ), (route) {
      return false;
    });


