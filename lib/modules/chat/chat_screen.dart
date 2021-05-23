import 'dart:async';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/modules/profile/user_profile.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:url_launcher/url_launcher.dart';


class ChatScreen extends StatelessWidget {
  int index;
  ChatScreen(this.index);

  var msgController = TextEditingController();
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context)
          .getMessages(receiverID: HomeCubit.get(context).users[index].userID);
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is GetMessagesSuccessState)
            Timer(
              Duration(milliseconds: 300),
              () => scrollController
                  .jumpTo(scrollController.position.maxScrollExtent),
            );
        },
        builder: (context, state) {
          var messages = HomeCubit.get(context).messages;
          DateTime labelDate = DateTime.parse(messages[0].dateTime);
          DateTime date = DateTime.parse(messages[0].dateTime);
          bool flag = true;
          return Scaffold(
            appBar: AppBar(
              elevation: 1.0,
              iconTheme: IconThemeData(color: Colors.deepPurple),
              titleSpacing: 0.0,
              title: InkWell(
                onTap: (){
                  navigateTo(UserProfileScreen(index), context);
                },
                child: Row(
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
                  ],
                ),
              ),
              actions: [
                IconButton(icon: Icon(IconBroken.Call), onPressed: () {
                  launch("tel://01033179558");
                }),
                PopupMenuButton(
                  icon: Icon(IconBroken.Info_Square),
                    itemBuilder: (context){
                  return [PopupMenuItem(child: Text('Clear Chat'),value: '2',)];
                }),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! GetMessagesLoadingState,
              builder: (context) => Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool sizedBox = false;
                          date = DateTime.parse(messages[index].dateTime);
                          if (labelDate.day < date.day || labelDate.month < date.month) {
                            flag = true;
                            labelDate = date;
                          } else
                            flag = false;

                            if (messages[index].senderID == uId)
                              return Column(
                                children: [
                                  if(index == 0)
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          DateFormat('d MMM y').format(date),
                                          style: TextStyle(color: Colors.black87),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.lightGreenAccent
                                            .withOpacity(0.3),
                                      ),
                                      margin: EdgeInsets.only(bottom: 10.0,top: 5.0),
                                    ),
                                  if(flag && index != 0)
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          DateFormat('d MMM y').format(date),
                                          style: TextStyle(color: Colors.black87),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.lightGreenAccent
                                            .withOpacity(0.3),
                                      ),
                                      margin: EdgeInsets.only(bottom: 10.0,top: 5.0),
                                    ),
                                  myBubble(
                                    messages[index].text,
                                    date,
                                    messages[index].image,
                                    context,
                                  ),
                                ],
                              );
                            return Column(
                              children: [
                                if(index == 0)
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        DateFormat('d MMM y').format(date),
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.lightGreenAccent
                                          .withOpacity(0.3),
                                    ),
                                    margin: EdgeInsets.only(bottom: 10.0,top: 5.0),
                                  ),
                                if(flag && index != 0)
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        DateFormat('d MMM y').format(date),
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.lightGreenAccent
                                          .withOpacity(0.3),
                                    ),
                                    margin: EdgeInsets.only(bottom: 10.0,top: 5.0),
                                  ),
                                bubble(
                                  messages[index].text,
                                  date,
                                  messages[index].image,
                                  context,
                                ),
                              ],
                            );

                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5.0,
                          ),
                          itemCount: HomeCubit.get(context).messages.length,
                        ),
                      ),
                    //message text field
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Colors.grey[300],
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            if (HomeCubit.get(context).chatImage != null)
                              Container(
                                child: Image(
                                  image: FileImage(
                                      HomeCubit.get(context).chatImage),
                                ),
                                height: 100,
                              ),
                            if (state is ChatImageUploadLoadingState)
                              LinearProgressIndicator(),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0),
                                    child: TextFormField(
                                      onTap: () => Timer(
                                        Duration(milliseconds: 300),
                                        () => scrollController.jumpTo(
                                            scrollController
                                                .position.maxScrollExtent),
                                      ),
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
                                  onPressed: () {
                                    HomeCubit.get(context).getChatImageGallery();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    IconBroken.Camera,
                                    color: Colors.deepPurple,
                                  ),
                                  onPressed: () {
                                    HomeCubit.get(context).getChatImageCamera();
                                  },
                                ),
                                Container(
                                  height: 50.0,
                                  color: state is ChatImageUploadLoadingState
                                      ? Colors.grey
                                      : Colors.deepPurple,
                                  child: MaterialButton(
                                    minWidth: 1.0,
                                    onPressed: state
                                            is ChatImageUploadLoadingState
                                        ? null
                                        : () {
                                            if (msgController.text != '' ||
                                                HomeCubit.get(context)
                                                        .chatImageUrl !=
                                                    null) {
                                              HomeCubit.get(context)
                                                  .sendMessage(
                                                text: msgController.text,
                                                dateTime:
                                                    DateTime.now().toString(),
                                                receiverID:
                                                    HomeCubit.get(context)
                                                        .users[index]
                                                        .userID,
                                                image: HomeCubit.get(context)
                                                    .chatImageUrl,
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

Widget bubble(String txt, DateTime time, String image, context) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          )),
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          if (image != null && image != '')
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Image(
                  image: NetworkImage(image),
                ),
              ),
            ),
          Text(
            txt,
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            (time.hour % 12 == 0 ? '12' : (time.hour % 12).toString()) +
                ':' +
                (time.minute < 10
                    ? ('0' + time.minute.toString())
                    : (time.minute.toString())) +
                (time.hour > 12 ? ' pm' : ' am'),
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    ),
  );
}

Widget myBubble(String txt, DateTime time, String image, context) {
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          )),
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          if (image != null && image != '')
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Image(
                  image: NetworkImage(image),
                ),
              ),
            ),
          Text(
            txt,
            style: TextStyle(fontSize: 15.0,),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            (time.hour % 12 == 0 ? '12' : (time.hour % 12).toString()) +
                ':' +
                (time.minute < 10
                    ? ('0' + time.minute.toString())
                    : (time.minute.toString())) +
                (time.hour > 12 ? ' pm' : ' am'),
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    ),
  );
}
