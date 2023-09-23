class RestaurantData {
  String name = "loading";
  String location = "";
  String desc = "";
  String id = "";
  List<String> images = [];
  List<String> tags = [];

  RestaurantData({
    this.name = "",
    this.location = "",
    this.desc = "",
    this.id = "",
    this.images = const [],
    this.tags = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'desc': desc??"",
      'id': id??"",
      'images': images,
      'tags': tags,
    };
  }

  RestaurantData.getMap(Map<String, dynamic> map) {
    List<String> list = [];
    if (map["images"] != null) {
      for (String i in map["images"]) {
        list.add(i);
      }
    }
    List<String> tagList = [];
    for (String i in map["tags"]) {
      tagList.add(i);
    }

    name = map["name"];
    location = map["location"];
    desc = map["desc"]??"";
    id = map["id"]??"";
    images = list;
    tags = tagList;
  }
}
