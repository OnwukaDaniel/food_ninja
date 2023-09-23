import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/util/DatabaseRef.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getRestaurantsRepo = Provider((_) => GetRestaurantsEntryRepo());

class GetRestaurantsEntryRepo {
  Future<FireResponse> getRestaurants() async {
    try {
      var fConst = FirebaseConstants();
      var ref = FirebaseDatabase.instance.ref().child(fConst.RESTURANT_PATH);
      List<String> list = [];
      var response = await ref.get();
      if (response.exists) {
        for (DataSnapshot snap in response.children) {
          list.add(snap.value.toString());
        }
        return FireResponse(status: true, object: list);
      } else {
        return FireResponse(status: false, object: "No restaurant");
      }
    } catch (error) {
      return FireResponse(status: false, object: error.toString());
    }
  }
}
