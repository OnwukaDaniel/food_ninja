import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import "package:food_ninja/globals/app_constants.dart" as app_const;
import 'package:food_ninja/reusable_widgets/edit_text.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:food_ninja/util/snackbar.dart';
import 'package:food_ninja/util/util.dart';

import '../models/UserProfile.dart';
import '../reusable_widgets/ButtonCustom.dart';
import '../reusable_widgets/TextCustom.dart';
import 'email_verification.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  static const String id = "SignUp";

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var keepMeSignedIn = true;
  var emailMe = true;

  ValueNotifier<bool> isLoadingVn = ValueNotifier(false);

  @override
  void dispose() {
    isLoadingVn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Util.bgColor(context),
      body: Stack(
        children: [
          Positioned(
            child: Image.asset(
              "assets/onboarding/food_pattern.png",
              width: width,
              height: height / 2,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 55),
              Image.asset(
                "assets/onboarding/app_logo.png",
                width: 100,
                height: 100,
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
              const SizedBox(height: 33),
              TextCustom(
                text: "Sign Up For Free",
                style: TextStyle(
                  color: Util.txtColor(context),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 53),
              EditText(
                leadingSpace: 10,
                padding: const EdgeInsets.symmetric(vertical: 4),
                leading: Image.asset(
                  "assets/onboarding/profile_icon1.png",
                  width: 30,
                  height: 30,
                ),
                controller: usernameController,
                hint: "Username...",
                hintColor: Colors.grey,
                textInputType: TextInputType.name,
                borderRadius: BorderRadius.circular(15),
              ),
              const SizedBox(height: 10),
              EditText(
                leadingSpace: 10,
                padding: const EdgeInsets.symmetric(vertical: 4),
                leading: Image.asset(
                  "assets/onboarding/email_icon1.png",
                  width: 30,
                  height: 30,
                ),
                controller: emailController,
                hint: "Email",
                hintColor: Colors.grey,
                textInputType: TextInputType.emailAddress,
                borderRadius: BorderRadius.circular(15),
              ),
              const SizedBox(height: 10),
              EditText(
                hasTailIcon: true,
                padding: const EdgeInsets.symmetric(vertical: 4),
                hasPasswordText: true,
                tailIcon: Image.asset(
                  "assets/onboarding/eye_show.png",
                  width: 30,
                  height: 30,
                ),
                leadingSpace: 10,
                leading: Image.asset(
                  "assets/onboarding/password_icon1.png",
                  width: 30,
                  height: 30,
                ),
                controller: passwordController,
                hint: "Password",
                hintColor: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  StatefulBuilder(
                    builder: (_, void Function(void Function()) setState) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            keepMeSignedIn = !keepMeSignedIn;
                          });
                        },
                        child: Image.asset(
                          keepMeSignedIn == true
                              ? "assets/onboarding/check.png"
                              : "assets/onboarding/unchecked.png",
                          width: 30,
                          height: 30,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Keep Me Signed In",
                    style: TextStyle(
                      color: Util.txtColor(context),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  StatefulBuilder(
                    builder: (_, void Function(void Function()) setState) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            emailMe = !emailMe;
                          });
                        },
                        child: Image.asset(
                          emailMe == true
                              ? "assets/onboarding/check.png"
                              : "assets/onboarding/unchecked.png",
                          width: 30,
                          height: 30,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Email Me About Special Pricing",
                    style: TextStyle(
                      color: Util.txtColor(context),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  ButtonWidget(
                    textPadding: const EdgeInsets.symmetric(horizontal: 46),
                    color: AppColor.lightGreen,
                    radius: const Radius.circular(15),
                    baseWidget: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ValueListenableBuilder(
                        valueListenable: isLoadingVn,
                        builder: (_, bool value, Widget? child) {
                          if (value == false) {
                            return Text(
                              "Create Account",
                              style: TextStyle(
                                color: Util.txtColor(context),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "LibreFranklin",
                              ),
                            );
                          } else {
                            return Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 61,
                              ),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    onTap: () async {
                      var email = emailController.text.trim().toString();
                      var userName = usernameController.text.trim().toString();
                      var password = passwordController.text.trim().toString();
                      if (userName == "") {
                        return;
                      } else if (email == "") {
                        return;
                      } else if (password == "") {
                        return;
                      } else if (password.length < 6) {
                        return;
                      }
                      var date = DateTime.now().millisecondsSinceEpoch;

                      var p = UserProfile(
                        fullName: userName,
                        email: email,
                        joinedDate: date.toString(),
                      );

                      bool isValid = EmailValidator.validate(email);
                      if (isValid == true) {
                        isLoadingVn.value = true;
                        EmailOTP myAuth = EmailOTP();
                        myAuth.setConfig(
                            appEmail: app_const.appEmail,
                            appName: "${app_const.appName} Email OTP",
                            userEmail: email,
                            otpLength: 5,
                            otpType: OTPType.digitsOnly);
                        if (await myAuth.sendOTP() == true) {
                          isLoadingVn.value = false;
                          if (context.mounted) {
                            if (context.mounted) {
                              Snackbar.showToast('OTP sent.', context);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EmailVerification(
                                  userProfile: p,
                                  myAuth: myAuth,
                                  password: password,
                                  keepMeSignedIn: keepMeSignedIn,
                                  emailMe: emailMe,
                                ),
                              ),
                            );
                          }
                        } else {
                          isLoadingVn.value = false;
                          if (context.mounted) {
                            Snackbar.showToast(
                              'Oops, OTP send failed. Retry.',
                              context,
                            );
                          }
                        }
                      } else {
                        isLoadingVn.value = false;
                        if (context.mounted) {
                          Snackbar.showToast('Email not valid.', context);
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Login.id);
                },
                child: TextCustom(
                  text: "Already have an account?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColor.lightGreen,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
