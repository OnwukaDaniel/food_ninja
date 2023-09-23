import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/FoodMenu.dart';
import 'package:food_ninja/util/DatabaseRef.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getMenuListRepo = Provider((_) => GetMenuListEntryRepo());

class GetMenuListEntryRepo {
  Future<FireResponse> getMenuList() async {
    try {
      var fConst = FirebaseConstants();
      var ref = FirebaseDatabase.instance.ref().child(fConst.FOOD_MENU_PATH);
      List<FoodMenu> list = [];
      var response = await ref.get();
      if (response.exists) {
        for (DataSnapshot snap in response.children) {
          var data = FoodMenu.getMap(
            Map<String, dynamic>.from(snap.value as Map<dynamic, dynamic>),
          );
          list.add(data);
        }
        return FireResponse(status: true, object: list);
      } else {
        return FireResponse(status: false, object: "No Food data");
      }
    } catch (error) {
      return FireResponse(status: false, object: error.toString());
    }
  }
}
