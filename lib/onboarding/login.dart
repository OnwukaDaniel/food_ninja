import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/onboarding/signup.dart';
import 'package:food_ninja/reusable_widgets/edit_text.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:food_ninja/util/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../reusable_widgets/ButtonCustom.dart';
import '../reusable_widgets/TextCustom.dart';
import '../screens/HomeActivity.dart';
import '../screens/home.dart';

class Login extends StatefulWidget {
  static const String id = "Login";

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      backgroundColor: Theme.of(context).backgroundColor,
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
                text: "Login to your account",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 53),
              EditText(
                controller: emailController,
                padding: const EdgeInsets.symmetric(vertical: 4),
                hint: "Email",
                hintColor: Colors.grey,
                textInputType: TextInputType.emailAddress,
                borderRadius: BorderRadius.circular(15),
              ),
              const SizedBox(height: 10),
              EditText(
                controller: passwordController,
                padding: const EdgeInsets.symmetric(vertical: 4),
                hint: "Password",
                hintColor: Colors.grey,
                textInputType: TextInputType.visiblePassword,
                borderRadius: BorderRadius.circular(15),
              ),
              const SizedBox(height: 35),
              TextCustom(
                text: "Or continue with",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SignUp.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.email,
                            color: AppColor.lightGreen,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Email",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/onboarding/google_icon.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Google",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Text(
                "Forgot password?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColor.lightGreen,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 35),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  ButtonWidget(
                    textPadding: const EdgeInsets.symmetric(horizontal: 46),
                    color: AppColor.lightGreen,
                    radius: const Radius.circular(15),
                    onTap: () {
                      var email = emailController.text.trim();
                      var password = passwordController.text.trim();
                      if (email == "" || password == "") {
                        return;
                      }
                      isLoadingVn.value = true;
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString("uid", value.user!.uid);

                        isLoadingVn.value = false;
                        if(mounted){
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              HomeActivity.id, (route) => false);
                        }
                      }).catchError((e){
                        isLoadingVn.value = false;
                        Snackbar.showToast(e.toString(), context);
                      });
                    },
                    baseWidget: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ValueListenableBuilder(
                        valueListenable: isLoadingVn,
                        builder: (_, bool value, Widget? child) {
                          if (value == false) {
                            return Text(
                              "Login",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
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
                                horizontal: 18,
                              ),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }
}
