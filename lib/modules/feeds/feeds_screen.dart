import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            itemBuilder: (context, index) => buildPost(context),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
          )
        ],
      ),
    );
  }
}

Widget buildPost(context) => Card(
      margin: EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/free-photo/caucasian-handsome-man-posing-with-arms-hip-smiling-isolated-purple-wall_1368-89876.jpg'),
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
                            'Abdelrahman Ashraf',
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
                        'January 21,2021 at 11:00 PM',
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
              'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
              style: TextStyle(),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6.0),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        height: 25.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          '#Software',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6.0),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        height: 25.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          '#Software_Development',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6.0),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        height: 25.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          '#Developer',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6.0),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        height: 25.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          '#Computer_Science',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6.0),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        height: 25.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          '#Software_Engineer',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6.0),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        height: 25.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          '#Hardware',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/programming-languages-tech-purple-background-with-code-elements-lines-light_272306-166.jpg?size=338&ext=jpg',
                  ),
                ),
              ),
            ),
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
                            '1200',
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
                            '150 Comments',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://image.freepik.com/free-photo/caucasian-handsome-man-posing-with-arms-hip-smiling-isolated-purple-wall_1368-89876.jpg'),
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
                  InkWell(
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
                          'Like',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
