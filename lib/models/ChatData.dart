class ChatData {
  String uid = "?loading";
  String message = "";
  String time = "";
  List<String> uids = [];

  ChatData({
    this.message = "",
    this.uid = "",
    this.time = "",
    this.uids = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'message': message,
      'time': time,
      'uids': uids,
    };
  }

  ChatData.getMap(Map<String, dynamic> map) {
    List<String> uIDList = [];
    for (String i in map["uids"]) {
      uIDList.add(i);
    }
    uid = map["uid"];
    message = map["message"];
    time = map["time"];
    uids = uIDList;
  }
}