import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/RestaurantData.dart';
import 'package:food_ninja/util/DatabaseRef.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getRestaurantsDataRepo = Provider((_) => GetRestaurantsDataEntryRepo());

class GetRestaurantsDataEntryRepo {
  Future<FireResponse> getRestaurantsData(String key) async {
    try {
      var fConst = FirebaseConstants();
      var ref = FirebaseDatabase.instance
          .ref()
          .child(fConst.RESTURANT_DATA_PATH)
          .child(key);
      var res = await ref.get();
      if (res.exists) {
        var data = RestaurantData.getMap(
          Map<String, dynamic>.from(res.value as Map<dynamic, dynamic>),
        );
        return FireResponse(status: true, object: data);
      } else {
        return FireResponse(status: false, object: "No data");
      }
    } catch (error) {
      return FireResponse(status: false, object: error.toString());
    }
  }
}
