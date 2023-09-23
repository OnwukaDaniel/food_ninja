class FireResponse {
  bool status = false;
  Object? object;

  FireResponse({this.status = false, this.object});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["object"] = object;
    return data;
  }

  FireResponse.fromJson(Map<String, dynamic> map) {
    status = map["status"];
    object = map["object"];
  }
}
