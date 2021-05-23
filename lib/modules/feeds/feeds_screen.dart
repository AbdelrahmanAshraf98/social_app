import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/modules/add_comment/add_comment.dart';
import 'package:social_app/shared/components/components.dart';


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

