import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/backend/controllers/updateProfileController.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:food_ninja/reusable_widgets/ButtonCustom.dart';
import 'package:food_ninja/reusable_widgets/edit_text.dart';
import 'package:food_ninja/sharednotifiers/app.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:food_ninja/util/dialogs.dart';
import 'package:food_ninja/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProfile extends HookConsumerWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    ValueNotifier<File> imageVn = ValueNotifier(File(""));
    getUserProfile(ref, fullNameController, phoneController);
    return Scaffold(
      backgroundColor: Util.bgColor(context),
      appBar: AppBar(
        backgroundColor: Util.bgColor(context),
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Util.txtColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 16),
          Center(
            child: Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  width: 150,
                  height: 150,
                  child: ValueListenableBuilder(
                    valueListenable: userProfileVN,
                    builder: (_, UserProfile profile, Widget? child) {
                      return ValueListenableBuilder(
                        valueListenable: imageVn,
                        builder: (_, File file, __) {
                          if (file.path.isNotEmpty) {
                            return Image.file(file, fit: BoxFit.cover);
                          }
                          if (profile.image.isNotEmpty) {
                            return Image.network(
                              profile.image,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return const Icon(Icons.person, color: Colors.grey);
                          }
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: IconButton(
                    onPressed: () => pickFile(context, imageVn, ref),
                    icon: Image.asset(
                      "assets/home/edit.png",
                      width: 30,
                      height: 40,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "   Full Name",
            style: TextStyle(color: Util.txtColor(context)),
          ),
          EditText(
            controller: fullNameController,
            hint: "Full name",
            borderWidth: 4,
            padding: const EdgeInsets.symmetric(vertical: 4),
            borderColor: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 16),
          Text(
            "   Phone",
            style: TextStyle(color: Util.txtColor(context)),
          ),
          EditText(
            controller: phoneController,
            hint: "070 ********",
            borderWidth: 4,
            padding: const EdgeInsets.symmetric(vertical: 4),
            borderColor: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
              backgroundColor: MaterialStateProperty.all(AppColor.appColor),
            ),
            onPressed: () {
              var fullName = fullNameController.text.trim();
              var phone = phoneController.text.trim();
              updateProfile(context, fullName, phone, ref);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 32),
          Text(
            "Become a seller today",
            style: TextStyle(color: Util.txtColor(context)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.amber),
            ),
            onPressed: () {},
            child: const Text(
              "Become a Seller",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  getUserProfile(
    WidgetRef ref,
    TextEditingController fullNameController,
    TextEditingController phoneController,
  ) async {
    var response = await ref.watch(updateProfileController).getProfile();
    if (response.status) {
      userProfileVN.value = response.object as UserProfile;
      phoneController.text = userProfileVN.value.phone;
      fullNameController.text = userProfileVN.value.fullName;
    }
  }

  updateProfile(
    BuildContext context,
    String fullName,
    String phone,
    WidgetRef ref,
  ) async {
    if (fullName.isEmpty) {
      CustomDialog.dialog(context, "Full name can't be empty", success: false);
      return;
    }
    if (phone.isEmpty) {
      CustomDialog.dialog(context, "Phone can't be empty", success: false);
      return;
    }
    var pro = userProfileVN.value;
    pro.fullName = fullName;
    pro.phone = phone;
    var diaCtx = CustomDialog.progressDialog(context);
    var response = await ref.watch(updateProfileController).updateProfile(pro);
    if (diaCtx.mounted) Navigator.pop(diaCtx);
    if (context.mounted) {
      CustomDialog.modalDialog(context, response.object!.toString());
    }
  }

  Future<void> pickFile(
    BuildContext pickerContext,
    ValueNotifier<File> imageVn,
    WidgetRef ref,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      if (pickerContext.mounted) {
        showDialog(
          context: pickerContext,
          builder: (BuildContext imageContext) {
            return AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Util.cardColor(pickerContext),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Wrap(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(file, width: 250, height: 250),
                          ),
                          ButtonCustom(
                            textPadding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            padding: const EdgeInsets.all(12),
                            text: "Save",
                            radius: const Radius.circular(12),
                            color: AppColor.appColor,
                            style: const TextStyle(color: Colors.white),
                            onTap: () {
                              var profile = userProfileVN.value;
                              profile.imageFile = file.path;
                              imageVn.value = file;
                              Navigator.pop(imageContext);
                              uploadData(file, pickerContext, ref);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    } else {
      print("Canceled by user ****************************");
    }
  }

  Future<void> uploadData(
    File file,
    BuildContext context,
    WidgetRef ref,
  ) async {
    var diaCtx = CustomDialog.progressDialog(context);
    var pro = userProfileVN.value;
    pro.imageFile = file.path;
    var response = await ref.watch(updateProfileController).updateProfile(pro);
    if (diaCtx.mounted) Navigator.pop(diaCtx);
    if (context.mounted) {
      CustomDialog.modalDialog(context, response.object!.toString());
    }
  }
}
