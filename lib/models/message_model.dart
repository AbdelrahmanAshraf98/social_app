class MessageModel {
  String senderID;
  String receiverID;
  String text;
  String dateTime;
  String image;

  MessageModel(
    this.text,
    this.receiverID,
    this.senderID,
    this.dateTime,
      this.image,
  );

  MessageModel.fromJson(Map<String,dynamic>json){
    senderID = json['senderID'];
    receiverID = json['receiverID'];
    text = json['text'];
    dateTime = json['dateTime'];
    image = json['image'];
  }

  Map<String,dynamic> toMap(){
    return{
      'senderID' : senderID,
      'receiverID' : receiverID,
      'text' : text,
      'dateTime' : dateTime,
      'image':image,
    };
  }
}
