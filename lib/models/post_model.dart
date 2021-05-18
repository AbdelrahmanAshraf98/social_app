class PostModel {
  String userID;
  String postImage;
  String image;
  String name;
  String text;
  String dateTime;

  PostModel({
    this.userID,
    this.text,
    this.image,
    this.name,
    this.postImage,
    this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    postImage = json['postImage'];
    image = json['image'];
    userID = json['uId'];
    name = json['name'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'postImage': postImage,
      'uID': userID,
      'image': image,
      'name': name,
      'dateTime':dateTime,
    };
  }
}
