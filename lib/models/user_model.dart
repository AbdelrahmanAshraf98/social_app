class UserModel {
  String name;
  String email;
  String phone;
  String userID;
  String bio;
  String image;
  String cover;
  bool isEmailVerified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.userID,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userID = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uID': userID,
      'image':image,
      'bio':bio,
      'cover':cover,
      'isEmailVerified' : isEmailVerified,
    };
  }
}
