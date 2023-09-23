import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:food_ninja/onboarding/set_up_location.dart';
import 'package:food_ninja/util/app_color.dart';

import '../globals/onboarding_globals.dart';
import '../reusable_widgets/ButtonCustom.dart';
import '../reusable_widgets/edit_text.dart';


class UploadPhoto2 extends StatefulWidget {
  const UploadPhoto2({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadPhoto2> createState() => _UploadPhoto2State();
}

class _UploadPhoto2State extends State<UploadPhoto2> {
  ValueNotifier<bool> showDialogVN = ValueNotifier(false);
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
                  children: [Wrap(
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
                    const SizedBox(height: 20),
                    Text(
                      "Upload Your Profile\nPhoto.",
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
                    GestureDetector(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.file(
                          onBoardingImageFile,
                          width: width,
                          height: 300,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___){
                            return const SizedBox();
                          },
                        ),
                      ),
                      onTap:() {
                        pickFile();
                      },
                    ),
                    const SizedBox(height: 20),
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
                  showDialogVN.value = true;
                },
              )
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: showDialogVN,
          builder: (_, bool value, Widget? child) {
            if (value == true){
              Timer(const Duration(seconds: 2), () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const SetUpLocation();
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
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            RotateAnimatedText('Saved'),
                            RotateAnimatedText('Preparing...'),
                            RotateAnimatedText('Set.'),
                          ],
                        ),
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

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        onBoardingImageFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }
}
