import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:food_ninja/util/snackbar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/app_constants.dart';
import '../globals/onboarding_globals.dart';
import '../reusable_widgets/ButtonCustom.dart';
import '../reusable_widgets/TextCustom.dart';
import '../util/DatabaseRef.dart';
import 'SuccessSignUp.dart';

class SetUpLocation extends StatefulWidget {
  const SetUpLocation({
    Key? key,
  }) : super(key: key);

  @override
  State<SetUpLocation> createState() => _SetUpLocationState();
}

class _SetUpLocationState extends State<SetUpLocation> {
  ValueNotifier<bool> showDialogVN = ValueNotifier(false);
  bool isLoading = false;
  loc.Location location = loc.Location();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  var locationString = "Your location";

  @override
  void dispose() {
    showDialogVN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Stack(
            children: [
              Positioned(
                child: Image.asset(
                  "assets/onboarding/food_pattern.png",
                  width: width,
                  height: height / 4,
                  fit: BoxFit.cover,
                ),
              ),
              Wrap(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.orange100,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColor.red100,
                      ),
                    ),
                  ),
                ],
              ),
              SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Upload Your Profile\nPhoto.",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamily,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "This data will be displayed in your account profile for security.",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontFamily: fontFamily,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Image.asset(
                                "assets/onboarding/pin_logo.png",
                                width: 35,
                                height: 35,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                locationString,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: fontFamily,
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              getLocation();
                            },
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                "Set location",
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Wrap(
            children: [
              Column(
                children: [
                  ButtonWidget(
                    baseWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        isLoading == true
                            ? const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    textPadding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    radius: const Radius.circular(6),
                    color: AppColor.lightGreen,
                    onTap: () {
                      if (userPlaceMarks.isEmpty) {
                        Snackbar.showToast("Set location or skip.", context);
                      } else {
                        uploadData();
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      uploadData();
                    },
                    child: TextCustom(
                      text: "Skip",
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: showDialogVN,
          builder: (_, bool value, Widget? child) {
            if (value == true) {
              Timer(const Duration(seconds: 5), () {});
            }
            if (value == true) {
              return Material(
                color: Colors.black26,
                child: Container(
                  alignment: Alignment.center,
                  width: width / 2,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SpinKitFadingCube(color: AppColor.appColor, size: 30),
                      const Spacer(),
                      AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText(
                            'Saved',
                            textStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontFamily: fontFamily,
                            ),
                          ),
                          RotateAnimatedText(
                            'Preparing...',
                            textStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontFamily: fontFamily,
                            ),
                          ),
                          RotateAnimatedText(
                            'Set.',
                            textStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontFamily: fontFamily,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  Future<void> uploadData() async {
    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid") ?? "";
    if (uid.isEmpty) return;
    showDialogVN.value = true;
    if (context.mounted) {
      Snackbar.showToast("Uploading please wait...", context);
    }
    var fire = FirebaseConstants();
    DatabaseReference generalRef =
        FirebaseDatabase.instance.ref(fire.USERS_PATH).child(uid);
    var storageRef = FirebaseStorage.instance
        .ref()
        .child(fire.USERS_PATH)
        .child(uid)
        .child(fire.PROFILE_IMAGE_PATH);
    try {
      await storageRef.putFile(onBoardingImageFile).then((p0) async {
        onBoardingUserProfile.image = await storageRef.getDownloadURL();
        generalRef.set(onBoardingUserProfile.toMap()).then((value) {
          Snackbar.showToast("Uploaded...", context);
          showDialogVN.value = false;
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(context, SuccessSignUp.id, (_) {
              return false;
            });
          }
        }).catchError((error) {
          showDialogVN.value = false;
          Snackbar.showToast(error.toString(), context);
          return null;
        });
      }).catchError((error) {
        showDialogVN.value = false;
        Snackbar.showToast(error.toString(), context);
        return null;
      });
    } on FirebaseException catch (e) {
      showDialogVN.value = false;
      if (context.mounted) Snackbar.showToast(e.message!, context);
    }
  }

  Future<void> getLocation() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        if (mounted) {
          Snackbar.showToast("Grant permission", context);
        }
        return;
      }
      showDialogVN.value = true;
      _locationData = await location.getLocation();
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        _locationData.latitude!,
        _locationData.longitude!,
      );
      userPlaceMarks = placeMarks;
      showDialogVN.value = false;
      setState(() {
        locationString =
            "${placeMarks.first.locality}, ${placeMarks.first.administrativeArea}, ${placeMarks.first.country}";
      });
    } else {
      showDialogVN.value = true;
      _locationData = await location.getLocation();
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        _locationData.latitude!,
        _locationData.longitude!,
      );
      userPlaceMarks = placeMarks;
      showDialogVN.value = false;
      setState(() {
        locationString =
            "${placeMarks.first.locality}, ${placeMarks.first.administrativeArea}, ${placeMarks.first.country}";
      });
    }
  }
}
