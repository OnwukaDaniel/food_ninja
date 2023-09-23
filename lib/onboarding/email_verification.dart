import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:food_ninja/onboarding/fill_bio.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/onboarding_globals.dart';
import '../reusable_widgets/ButtonCustom.dart';
import '../reusable_widgets/TextCustom.dart';
import '../util/DatabaseRef.dart';
import '../util/snackbar.dart';

class EmailVerification extends StatefulWidget {
  final UserProfile userProfile;
  final EmailOTP myAuth;
  final String password;
  final bool keepMeSignedIn;
  final bool emailMe;

  const EmailVerification({
    Key? key,
    required this.userProfile,
    required this.myAuth,
    required this.password,
    required this.keepMeSignedIn,
    required this.emailMe,
  }) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  TextEditingController c5 = TextEditingController();
  TextEditingController c6 = TextEditingController();

  final FocusNode c1FocusNode = FocusNode();
  final FocusNode c2FocusNode = FocusNode();
  final FocusNode c3FocusNode = FocusNode();
  final FocusNode c4FocusNode = FocusNode();
  final FocusNode c5FocusNode = FocusNode();
  final FocusNode c6FocusNode = FocusNode();

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
          ListView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
              SafeArea(
                child: Wrap(
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
              ),
              const SizedBox(height: 20),
              Text(
                "Verify your email address.",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "LibreFranklin",
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Enter email OTP.",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 72.0, bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EditBox(
                      c2: c1,
                      focusNode: c1FocusNode,
                      focusNodeOther: c2FocusNode,
                    ),
                    const SizedBox(width: 12),
                    EditBox(
                      c2: c2,
                      focusNode: c2FocusNode,
                      focusNodeOther: c3FocusNode,
                    ),
                    const SizedBox(width: 12),
                    EditBox(
                      c2: c3,
                      focusNode: c3FocusNode,
                      focusNodeOther: c4FocusNode,
                    ),
                    const SizedBox(width: 12),
                    EditBox(
                      c2: c4,
                      focusNode: c4FocusNode,
                      focusNodeOther: c5FocusNode,
                    ),
                    const SizedBox(width: 12),
                    EditBox(
                      c2: c5,
                      focusNode: c5FocusNode,
                      focusNodeOther: c6FocusNode,
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  c1.clear();
                  c2.clear();
                  c3.clear();
                  c4.clear();
                  c5.clear();
                },
                child: const TextCustom(
                  alignment: Alignment.centerRight,
                  text: "Clear OTP",
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              ButtonWidget(
                baseWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Create account",
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
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  var otp =
                      c1.text + c2.text + c3.text + c4.text + c5.text + c6.text;
                  if (otp == "") {
                    return;
                  }

                  if (await widget.myAuth.verifyOTP(otp: otp) == true) {
                    if(context.mounted){
                      Snackbar.showToast('OTP is verified', context);
                    }
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: widget.userProfile.email,
                        password: widget.password,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        if(context.mounted){
                          Snackbar.showToast(
                            'The password provided is too weak.',
                            context,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } else if (e.code == 'email-already-in-use') {
                        if(context.mounted){
                          Snackbar.showToast(
                            'The account already exists for that email.',
                            context,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        if(context.mounted){
                          Snackbar.showToast('${e.message}.', context);
                        }
                        setState(() => isLoading = false);
                      }
                    } catch (e) {
                      if(context.mounted){
                        Snackbar.showToast(e.toString(), context);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) async {
                      var date = DateTime.now().millisecondsSinceEpoch;
                      if (user != null) {
                        var p = UserProfile(
                          image: "",
                          fullName: widget.userProfile.fullName,
                          email: widget.userProfile.email,
                          uid: user.uid,
                          phone: widget.userProfile.phone,
                          joinedDate: date.toString(),
                          isCustomer: widget.userProfile.isCustomer,
                          address: widget.userProfile.address,
                        );
                        onBoardingUserProfile = p;

                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString("uid", user.uid);

                        var fConst = FirebaseConstants();
                        var ref = FirebaseDatabase.instance
                            .ref(fConst.USERS_PATH)
                            .child(user.uid);
                        await ref.set(p.toMap()).then((value) {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (_) {
                            return FillBio(
                              keepMeSignedIn: widget.keepMeSignedIn,
                              emailMe: widget.emailMe,
                            );
                          }), (_) {
                            return false;
                          });
                          setState(() {
                            isLoading = false;
                          });
                        }).catchError((onError) {
                          setState(() {
                            isLoading = false;
                          });
                          Snackbar.showToast(onError.toString(), context);
                        });
                      }
                    });
                  } else {
                    if(context.mounted) {
                      Snackbar.showToast("Invalid OTP", context);
                    }
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EditBox extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode focusNodeOther;

  const EditBox(
      {Key? key,
      required this.c2,
      required this.focusNode,
      required this.focusNodeOther})
      : super(key: key);

  final TextEditingController c2;

  @override
  Widget build(BuildContext context) {
    c2.addListener(() {
      if (c2.text != "") {
        focusNodeOther.requestFocus();
      }
    });

    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        focusNode: focusNode,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        maxLength: 1,
        style: const TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
        //onChanged: (_) => FocusScope.of(context).nextFocus(),
        controller: c2,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
          counterStyle: TextStyle(fontSize: 0),
        ),
      ),
    );
  }
}
