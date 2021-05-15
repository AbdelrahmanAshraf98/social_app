class PostModel {
  String userID;
  String postID;
  String postImage;
  String text;
  String dateTime;

  PostModel({
    this.userID,
    this.postID,
    this.text,
    this.postImage,
    this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    postImage = json['postImage'];
    userID = json['uId'];
    postID = json['postId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'postImage': postImage,
      'uID': userID,
      'postID': postID,
      'dateTime':dateTime,
    };
  }
}
