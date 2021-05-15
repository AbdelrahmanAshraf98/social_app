import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(context: context, txt: 'Create Post', actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: TextButton(
                  onPressed: () {
                    HomeCubit.get(context).createNewPost(text:textController.text,dateTime: DateTime.now().toString() );
                  },
                  child: Text(
                    'POST',
                    style: TextStyle(color: Colors.blue),
                  )),
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                  SizedBox(height: 5.0,),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(HomeCubit.get(context).userModel.image),
                      radius: 25.0,
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HomeCubit.get(context).userModel.name,
                            style: TextStyle(
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'What is in your mind...',
                        border: InputBorder.none),
                  ),
                ),
                if(HomeCubit.get(context).postImage != null)
                  Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              image: FileImage(HomeCubit.get(context).postImage),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 20.0,
                          child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                HomeCubit.get(context).removePostImage();
                              }),
                        ),
                      ),
                      if(state is PostImageUploadLoadingState)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(child: LinearProgressIndicator(),),
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                            HomeCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
