import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatScreen extends StatelessWidget {
  int index;
  ChatScreen(this.index);
  var msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context)
          .getMessages(receiverID: HomeCubit.get(context).users[index].userID);

      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.deepPurple),
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(HomeCubit.get(context).users[index].image),
                    radius: 20.0,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    HomeCubit.get(context).users[index].name,
                    style: TextStyle(
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        color: Colors.deepPurple),
                  ),
                  Spacer(),
                  IconButton(icon: Icon(IconBroken.Call), onPressed: (){}),
                  IconButton(icon: Icon(IconBroken.Info_Square), onPressed: (){}),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! GetMessagesLoadingState,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (HomeCubit.get(context).messages[index].senderID ==
                              uId)
                            return myBubble(
                                HomeCubit.get(context).messages[index].text,
                              HomeCubit.get(context).messages[index].dateTime,
                            );
                          return bubble(
                              HomeCubit.get(context).messages[index].text,
                              HomeCubit.get(context).messages[index].dateTime,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 15.0,
                        ),
                        itemCount: HomeCubit.get(context).messages.length,
                      ),
                    ),
                    //message text field
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Colors.grey[300],
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  controller: msgController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type a message'),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.attach_file,
                                color: Colors.deepPurple,
                              ),
                              onPressed: () {},
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.deepPurple,
                              child: MaterialButton(
                                minWidth: 1.0,
                                onPressed: () {
                                  if(msgController.text != '') {
                                    HomeCubit.get(context).sendMessage(
                                      text: msgController.text,
                                      dateTime: DateTime.now().toString(),
                                      receiverID: HomeCubit.get(context)
                                          .users[index]
                                          .userID,
                                    );
                                    msgController.clear();
                                  }
                                },
                                child: Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    });
  }
}

Widget bubble(String txt,String time) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        width: txt.length < 30 ?  txt.length.toDouble()*11: txt.length.toDouble()*5,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                txt,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            SizedBox(width: 5.0,),
            Text(time.substring(11,16)+" pm",style: TextStyle(fontSize:12.0),),
          ],
        ),

      ),
    );

Widget myBubble(String txt,String time) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
            )),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                txt,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            SizedBox(width: 5.0,),
            Text(time.substring(11,16)+" pm",style: TextStyle(fontSize:12.0),),
          ],
        ),
      ),
    );