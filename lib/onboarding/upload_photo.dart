import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/onboarding/upload_photo2.dart';

import '../globals/onboarding_globals.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File file = File("");
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
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
                    alignment: Alignment.center,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/onboarding/gallery_icon.png",
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "From Gallery",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    pickFile();
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/onboarding/camera_icon.png",
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Take Photo",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      onBoardingImageFile = file;
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return const UploadPhoto2();
          }),
        );
      }
    } else {
      // User canceled the picker
    }
  }
}
