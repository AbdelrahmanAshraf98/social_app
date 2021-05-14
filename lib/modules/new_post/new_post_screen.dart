import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepPurple),
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: Center(
        child: Text('New Post'),
      ),
    );
  }
}
