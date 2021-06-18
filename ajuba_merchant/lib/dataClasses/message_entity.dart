/// message : "SUCCESS"

class Message {
  String? message;

  static Message? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
		Message messageEntityBean = Message();
    messageEntityBean.message = map['message'];
    return messageEntityBean;
  }

  Map toJson() => {
    "message": message,
  };
}