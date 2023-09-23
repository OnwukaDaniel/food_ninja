import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:food_ninja/sharednotifiers/app.dart';
import 'package:food_ninja/util/DatabaseRef.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final updateProfileRepo = Provider((_) => UpdateProfileEntryRepo());

class UpdateProfileEntryRepo {
  Future<FireResponse> getUserProfile() async {
    var fc = FirebaseConstants();
    var prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid") ?? "";
    if (uid.isEmpty) {
      return FireResponse(status: false, object: "Unregistered user");
    }
    try {
      var ref = FirebaseDatabase.instance.ref().child(fc.USERS_PATH).child(uid);
      var response = await ref.get();
      if (response.exists) {
        var data = UserProfile.getMap(
          Map<String, dynamic>.from(response.value as Map<dynamic, dynamic>),
        );
        _listenToUserProfile();
        return FireResponse(status: true, object: data);
      } else {
        return FireResponse(status: false, object: "User doesn't exist");
      }
    } catch (error) {
      return FireResponse(status: false, object: error.toString());
    }
  }

  _listenToUserProfile() async {
    var fc = FirebaseConstants();
    var prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid") ?? "";
    var ref = FirebaseDatabase.instance.ref().child(fc.USERS_PATH).child(uid);
    ref.onValue.listen((event) {
      var data = UserProfile.getMap(
        Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>,
        ),
      );
      userProfileVN.value = data;
    });
  }

  Future<FireResponse> updateProfileRepo(UserProfile p) async {
    var prefs = await SharedPreferences.getInstance();
    var profile = p;
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

  Future<FireResponse> uploadOnlyData(UserProfile profile, String uid) async {
    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid") ?? "";
    try {
      if (uid.isNotEmpty) {
        var fire = FirebaseConstants();
        DatabaseReference generalRef =
            FirebaseDatabase.instance.ref(fire.USERS_PATH).child(uid);
        await generalRef.set(profile.toMap());
        return FireResponse(status: true, object: "Uploaded");
      } else {
        return FireResponse(status: false, object: "Unregistered user");
      }
    } catch (error) {
      return FireResponse(status: false, object: error.toString());
    }
  }
}
