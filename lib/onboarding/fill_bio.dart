import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:food_ninja/onboarding/upload_photo.dart';
import 'package:food_ninja/util/app_color.dart';

import '../globals/onboarding_globals.dart';
import '../reusable_widgets/ButtonCustom.dart';
import '../reusable_widgets/edit_text.dart';

class FillBio extends StatefulWidget {
  static const String id = "FillBio";
  final bool keepMeSignedIn;
  final bool emailMe;

  const FillBio({
    Key? key,
    this.keepMeSignedIn = true,
    this.emailMe = true,
  }) : super(key: key);

  @override
  State<FillBio> createState() => _FillBioState();
}

class _FillBioState extends State<FillBio> {
  ValueNotifier<bool> showDialogVN = ValueNotifier(false);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var userProfile = UserProfile();
  bool isLoading = false;

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
              SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Fill in your bio to get\nstarted.",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "LibreFranklin",
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "This data will be displayed in your account profile for security.",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                    const SizedBox(height: 20),
                    EditText(
                      controller: firstNameController,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      hint: "First Name",
                      hintColor: Colors.grey,
                      textInputType: TextInputType.name,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    const SizedBox(height: 10),
                    EditText(
                      controller: lastNameController,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      hint: "Last Name",
                      hintColor: Colors.grey,
                      textInputType: TextInputType.name,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    const SizedBox(height: 20),
                    EditText(
                      controller: phoneController,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      hint: "Mobile Number",
                      hintColor: Colors.grey,
                      textInputType: TextInputType.phone,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ],
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
                      "Next",
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
                  var firstName = firstNameController.text.trim().toString();
                  var lastName = lastNameController.text.trim().toString();
                  var phone = phoneController.text.trim().toString();
                  if (firstName.isEmpty || lastName.isEmpty || phone.isEmpty) {
                    return;
                  }
                  onBoardingUserProfile.fullName = "$firstName $lastName";
                  onBoardingUserProfile.phone = phone;
                  onBoardingUserProfile = userProfile;
                  showDialogVN.value = true;
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: showDialogVN,
          builder: (_, bool value, Widget? child) {
            if (value == true) {
              Timer(const Duration(seconds: 5), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return const UploadPhoto();
                    },
                  ),
                );
                showDialogVN.value = false;
              });
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
                      Image.asset(
                        "assets/onboarding/success_logo.png",
                        width: 30,
                        height: 30,
                      ),
                      const Spacer(),
                      AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText(
                            'Saved',
                            textStyle: TextStyle(
                              color:
                              Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                          RotateAnimatedText(
                            'Preparing...',
                            textStyle: TextStyle(
                              color:
                              Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                          RotateAnimatedText(
                            'Set.',
                            textStyle: TextStyle(
                              color:
                              Theme.of(context).textTheme.bodyText1!.color,
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
}
