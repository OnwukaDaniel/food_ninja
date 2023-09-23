import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:food_ninja/globals/search_filter_type.dart';
import 'package:food_ninja/util/DatabaseRef.dart';
import '../models/menu_restaurant.dart';
import '../sharednotifiers/app.dart';

class FilterViewModel extends ChangeNotifier {
  List<MenuRestaurant> _menRestList = [];
  bool _isLoading = false;

  List<MenuRestaurant> get menRestList => _menRestList;
  bool get loading => _isLoading;

  _setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  getMenRestList(List<int> input) {
    _setLoading(true);
    String firstChild = "";
    List<MenuRestaurant> list = [];
    if (input.contains(SearchFilterType.RESTAURANT)) {
      firstChild = FirebaseConstants().RESTURANT_PATH;
    } else if (input.contains(SearchFilterType.MENU)) {
      firstChild = FirebaseConstants().FOOD_MENU_PATH;
    }
    var ref = FirebaseDatabase.instance.ref().child(firstChild);
    print("Got here 1 ***********************");
    ref.get().then((value) {
      if (value.exists) {
        for(DataSnapshot s in value.children){
          var data = MenuRestaurant.getMap(
              Map<String, dynamic>.from(s.value as Map<dynamic, dynamic>));
          print("Got here 2 ***********************");
          if (!list.contains(data)) list.add(data);
        }
        _menRestList = list;
        _setLoading(false);
      } else {
        print("Got here 3 ***********************");
        _setLoading(false);
      }
    }).catchError((e){
      print("Got here 4 ***********************");
      _setLoading(false);
    });
  }
}
