import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ninja/util/util.dart';
import '../reusable_widgets/TextCustom.dart';
import 'app_color.dart';

class CustomDialog {
  static dialog(BuildContext context, String message,
      {bool success = true, double textSize = 25, Function()? func}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Material(
                color: Util.cardColor(context),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      success == true
                          ? Image.asset(
                              "asset/onboarding/success_ripple.png",
                              width: 100,
                              height: 100,
                            )
                          : const SizedBox(),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          textAlign: TextAlign.center,
                          message,
                          style: TextStyle(
                            fontSize: textSize,
                            color: Util.txtColor(context),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          if (func != null) {
                            Navigator.pop(context);
                            func();
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCustom(
                              padding: const EdgeInsets.all(12),
                              text: "Ok",
                              style: TextStyle(
                                fontSize: 22,
                                color: Util.txtColor(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static BuildContext progressDialog(BuildContext context,
      {String message = "Please wait..."}) {
    BuildContext ctx = context;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        ctx = context;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Material(
                color: Util.cardColor(context),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      SpinKitDualRing(color: AppColor.appColor, size: 50),
                      const SizedBox(height: 32),
                      TextCustom(
                        text: message,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        style: TextStyle(
                          fontSize: 16,
                          color: Util.txtColor(context),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    return ctx;
  }

  static modalDialog(BuildContext context, String message,
      {bool success = true, double textSize = 18}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 3), () {
          if(context.mounted) Navigator.pop(context);
        });
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            runAlignment: WrapAlignment.start,
            children: [
              Material(
                color: AppColor.appColor,
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        textAlign: TextAlign.center,
                        message,
                        style: TextStyle(
                          fontSize: textSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
