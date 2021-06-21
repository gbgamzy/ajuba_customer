/// message : "SUCCESS"

class Message {
  String? message;

  static Message? fromMap(Map<String, dynamic> map) {

    Message messageBean = Message();
    messageBean.message = map['message'];
    return messageBean;
  }

  Map toJson() => {
    "message": message,
  };
}