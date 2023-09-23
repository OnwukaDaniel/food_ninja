import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_ninja/util/app_color.dart';

import '../reusable_widgets/ButtonCustom.dart';
import '../reusable_widgets/TextCustom.dart';
import '../screens/HomeActivity.dart';
import '../screens/home.dart';

class SuccessSignUp extends StatefulWidget {
  static const String id = "SuccessSignUp";

  const SuccessSignUp({Key? key}) : super(key: key);

  @override
  State<SuccessSignUp> createState() => _SuccessSignUpState();
}

class _SuccessSignUpState extends State<SuccessSignUp> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 15), () {
      Navigator.of(context).pushNamedAndRemoveUntil(HomeActivity.id, (route) => false);
    });

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/onboarding/success_logo.png",
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 20),
          TextCustom(
            text: "Congrats!",
            style: TextStyle(
              color: AppColor.lightGreen,
              fontSize: 35,
              fontWeight: FontWeight.w900,
              fontFamily: "Viga",
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Your Profile has been successfully set up.!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: "Viga",
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Wrap(
        children: [
          ButtonWidget(
            baseWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Try Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                isLoading == true
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator()),
                      )
                    : const SizedBox(),
              ],
            ),
            textPadding: const EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 15,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            radius: const Radius.circular(6),
            color: AppColor.appColor,
            onTap: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(HomeActivity.id, (route) =>
              false);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
