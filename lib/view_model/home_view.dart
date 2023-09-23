import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/UserProfile.dart';
import '../sharednotifiers/app.dart';
import '../sharednotifiers/home.dart';
import '../util/DatabaseRef.dart';

class HomeViewViewModel extends ChangeNotifier {
  UserProfile _userProfile = UserProfile();

  UserProfile get userProfile => _userProfile;

  HomeViewViewModel(){
    getUserProfile();
  }

  getUserProfile() async {
    var fConst = FirebaseConstants();
    var prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("uid");
    if(uid == null){
      errorMsgUserprofileVN.value = "User not signed in";
      return;
    }
    var ref =
        FirebaseDatabase.instance.ref().child(fConst.USERS_PATH).child(uid);
    ref.get().then((value) {
      if (value.exists) {
        userProfileVN.value = UserProfile.getMap(
            Map<String, dynamic>.from(value.value as Map<dynamic, dynamic>));
      } else {
        errorMsgUserprofileVN.value = "User doesn't exist";
      }
    }).catchError((e) {
      errorMsgUserprofileVN.value = "Unable ot fetch user details";
    }).onError((error, stackTrace) {
      errorMsgUserprofileVN.value = "Error occurred";
    });
    _userProfile = userProfile;
    notifyListeners();
  }
}
