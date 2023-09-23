import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/FoodMenu.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:food_ninja/sharednotifiers/app.dart';
import 'package:food_ninja/util/DatabaseRef.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final addToCartRepo = Provider((_) => AddToCartEntryRepo());

class AddToCartEntryRepo {

  Future<FireResponse> addToCart(FoodMenu f) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      var uid = prefs.getString("uid") ?? "";
      if (uid.isNotEmpty) {
        var fire = FirebaseConstants();
        var storageRef = FirebaseStorage.instance
            .ref()
            .child(fire.USERS_PATH)
            .child(uid)
            .child(fire.PROFILE_IMAGE_PATH);
        try {
          if (profile.imageFile.isNotEmpty) {
            await storageRef.putFile(File(profile.imageFile));
            var url = await storageRef.getDownloadURL();
            profile.image = url;
            var response = await uploadOnlyData(profile, uid);
            return response;
          } else {
            var response = await uploadOnlyData(profile, uid);
            return response;
          }
        } on FirebaseException catch (e) {
          return FireResponse(status: false, object: e.message);
        }
      } else {
        return FireResponse(status: false, object: "Unregistered user");
      }
    } catch (error) {
      return FireResponse(status: false, object: error.toString());
    }
  }
}
