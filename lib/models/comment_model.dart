import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String comment;
  String name;
  Timestamp time;
  String image;

  CommentModel(
    this.name,
    this.comment,
    this.image,
    this.time,
  );

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    time = json['time'];
    comment = json['comment'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'time': time,
      'comment': comment,
    };
  }
}
