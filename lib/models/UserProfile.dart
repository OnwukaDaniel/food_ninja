class UserProfile {
  String uid = "?loading";
  String fullName = "";
  String email = "";
  String address = "";
  String phone = "";
  String image = "";
  String imageFile = "";
  String joinedDate = "";
  bool isCustomer = true;

  UserProfile({
        this.fullName = "",
      this.address = "",
      this.phone = "",
      this.email = "",
    this.uid = "",
    this.imageFile = "",
      this.isCustomer = true,
      this.image = "",
      this.joinedDate = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'address': address,
      'phone': phone,
      'image': image,
      'joinedDate': joinedDate,
      'isCustomer': isCustomer,
    };
  }

  UserProfile.getMap(Map<String, dynamic> map) {
    fullName = map["fullName"];
    address = map["address"];
    phone = map["phone"];
    email = map["email"];
    uid = map["uid"];
    image = map["image"];
    joinedDate = map["joinedDate"];
    isCustomer = map["isCustomer"];
  }
}
