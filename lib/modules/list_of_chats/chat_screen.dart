import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat/chat_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ListOFChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(HomeCubit.get(context).users[index],index,context),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[200],
              ),
            ),
            itemCount: HomeCubit.get(context).users.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget buildChatItem(UserModel model,int index, context) => InkWell(
      onTap: () {
        navigateTo(ChatScreen(index), context);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(model.image),
              radius: 25.0,
            ),
            SizedBox(width: 15.0),
            Text(
              model.name,
              style: TextStyle(height: 1.4, fontWeight: FontWeight.w600,fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
