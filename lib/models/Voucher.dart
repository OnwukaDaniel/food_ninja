class Voucher {
  String uid = "?loading";
  String description = "";
  String name = "";
  String code = "";

  Voucher({
    this.description = "",
    this.code = "",
    this.name = "",
    this.uid = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'description': description,
      'name': name,
      'code': code,
    };
  }

  Voucher.getMap(Map<String, dynamic> map) {
    description = map["description"];
    code = map["code"];
    name = map["name"];
    uid = map["uid"];
  }
}
