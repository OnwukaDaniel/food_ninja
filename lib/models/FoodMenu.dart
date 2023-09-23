import 'dart:developer';

class FoodMenu {
  String uid = "?loading";
  String name = "";
  String desc = "";
  int price = 0;
  String quantityType = "";
  String restaurantUId = "";
  String currency = "";
  List<String> images = [];
  List<String> tags = [];

  FoodMenu({
    this.uid = "",
    this.name = "",
    this.desc = "",
    this.restaurantUId = "",
    this.quantityType = "",
    this.currency = "",
    this.price = 0,
    this.images = const [],
    this.tags = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'desc': desc??"",
      'quantityType': quantityType??"",
      'price': price,
      'restaurantUId': restaurantUId,
      'currency': currency,
      'images': images,
      'tags': tags,
    };
  }

  FoodMenu.getMap(Map<String, dynamic> map) {
    List<String> list = [];
    for (String i in map["images"]) {
      list.add(i);
    }
    List<String> tagList = [];
    for (String i in map["tags"]) {
      tagList.add(i);
    }

    uid = map["uid"];
    name = map["name"];
    desc = map["desc"]??"";
    quantityType = map["quantityType"]??"";
    restaurantUId = map["restaurantUId"];
    currency = map["currency"];
    price = map["price"];
    images = list;
    tags = tagList;
  }
}
