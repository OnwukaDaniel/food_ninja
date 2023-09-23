import 'package:food_ninja/models/FoodMenu.dart';
import 'package:food_ninja/models/RestaurantData.dart';

class MenuRestaurant {
  String uid = "?loading";
  String name = "";
  int price = 0;
  String restaurantUId = "";
  String currency = "";
  List<String> images = [];
  List<String> tags = [];
  String location = "";

  MenuRestaurant({
    this.uid = "",
    this.name = "",
    this.restaurantUId = "",
    this.currency = "",
    this.location = "",
    this.price = 0,
    this.images = const [],
    this.tags = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': name,
      'price': price,
      'location': location,
      'restaurantUId': restaurantUId,
      'currency': currency,
      'images': images,
      'tags': tags,
    };
  }

  MenuRestaurant.getMap(Map<String, dynamic> map) {
    List<String> list = [];
    for (String i in map["images"]) {
      list.add(i);
    }
    List<String> tagList = [];
    for (String i in map["tags"]) {
      tagList.add(i);
    }

    if (map["uid"] != null) uid = map["uid"];
    if (map["name"] != null) name = map["name"];
    if (map["restaurantUId"] != null) restaurantUId = map["restaurantUId"];
    if (map["currency"] != null) currency = map["currency"];
    if (map["location"] != null) location = map["location"];
    if (map["price"] != null) price = map["price"];
    images = list;
    tags = tagList;
  }

  menuResToRestaurantData(MenuRestaurant input) {
    return RestaurantData(
      name: input.name,
      location: input.location,
      images: input.images,
      tags: input.tags,
    );
  }

  menuResToMenuData(MenuRestaurant input) {
    return FoodMenu(
      name: input.name,
      uid: input.uid,
      restaurantUId: input.restaurantUId,
      currency: input.currency,
      price: input.price,
      images: input.images,
      tags: input.tags,
    );
  }
}
