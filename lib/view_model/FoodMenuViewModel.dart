import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/FoodMenu.dart';
import '../models/RestaurantData.dart';
import '../util/DatabaseRef.dart';

class FoodMenuViewModel extends ChangeNotifier {
  bool _loading = false;
  List<FoodMenu> _foodMenuList = [];
  List<RestaurantData> _restaurantList = [];

  bool get loading => _loading;

  List<FoodMenu> get foodMenuList => _foodMenuList;
  List<RestaurantData> get restaurantList => _restaurantList;

  FoodMenuViewModel(){
    getRestaurants();
    setMenuList();
  }

  _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setMenuList() {
    _setLoading(true);
    var fConst = FirebaseConstants();
    var ref = FirebaseDatabase.instance.ref().child(fConst.FOOD_MENU_PATH);
    List<FoodMenu> list = [];
    ref.get().then((value) {
      if (value.exists) {
        for (DataSnapshot snap in value.children) {
          var data = FoodMenu.getMap(
              Map<String, dynamic>.from(snap.value as Map<dynamic, dynamic>));
          list.add(data);
        }
        _foodMenuList = list;
        _setLoading(false);
      }
    }).catchError((e) {
      _setLoading(false);
    });
  }

  setRestaurantList(List<String> raw) {
    var fConst = FirebaseConstants();
    List<RestaurantData> list = [];
    for (String i in raw) {
      var fConst = FirebaseConstants();
      var ref = FirebaseDatabase.instance
          .ref()
          .child(fConst.RESTURANT_DATA_PATH)
          .child(i);
      ref.get().then((value) {
        if (value.exists) {
          var data = RestaurantData.getMap(
              Map<String, dynamic>.from(value.value as Map<dynamic, dynamic>));
          if (!list.contains(data)) {
            list.add(data);
          }
          _restaurantList = list;
          _setLoading(false);
        }
      }).catchError((e) {
        _setLoading(false);
      });
    }
  }

  void getRestaurants() {
    _setLoading(true);
    var fConst = FirebaseConstants();
    var ref = FirebaseDatabase.instance.ref().child(fConst.RESTURANT_PATH);
    List<String> list = [];
    ref.get().then((value) {
      if (value.exists) {
        for (DataSnapshot snap in value.children) {
          if (!list.contains(snap.value.toString())) {
            list.add(snap.value.toString());
          }
        }
        setRestaurantList(list);
      } else {
        _setLoading(false);
      }
    }).catchError((e) {
      _setLoading(false);
    });
  }
}
