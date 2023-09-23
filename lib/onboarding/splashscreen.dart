import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/util/app_color.dart';

import '../reusable_widgets/TextCustom.dart';
import '../screens/HomeActivity.dart';
import '../screens/home.dart';
import 'fill_bio.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String id = "SplashScreen";

  @override
  void initState() {
    Timer(
      const Duration(seconds: 3), () async {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.of(context).pushReplacementNamed(OnBoarding.id);
        } else {
          Navigator.of(context).pushReplacementNamed(HomeActivity.id);
        }
      });
    },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: Stack(
        children: [
          Positioned(
            child: Image.asset(
              "assets/onboarding/food_pattern.png",
              width: width,
              height: height / 2,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/onboarding/app_logo.png",
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 5),
                TextCustom(
                  text: "Food Ninga",
                  style: TextStyle(
                    color: AppColor.lightGreen,
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Viga",
                  ),
                ),
                const SizedBox(height: 10),
                TextCustom(
                  text: "Deliver favorite food",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .textTheme
                        .bodyText1!
                        .color,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
