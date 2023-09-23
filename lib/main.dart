import 'package:flutter/material.dart';
import 'package:food_ninja/onboarding/SuccessSignUp.dart';
import 'package:food_ninja/onboarding/fill_bio.dart';
import 'package:food_ninja/onboarding/login.dart';
import 'package:food_ninja/repo/ApiResponse.dart';
import 'package:food_ninja/screens/chat_list.dart';
import 'package:food_ninja/theme/apptheme.dart';
import 'package:food_ninja/view_model/home_view.dart';
import 'package:food_ninja/screens/HomeActivity.dart';
import 'package:food_ninja/screens/home.dart';
import 'package:food_ninja/sharednotifiers/app.dart';
import 'package:food_ninja/view_model/FoodMenuViewModel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/UserProfile.dart';
import 'onboarding/onboarding.dart';
import 'onboarding/signup.dart';
import 'onboarding/splashscreen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/search_result.dart';
import 'screens/search_screen.dart';
import 'view_model/filter_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? e = prefs.getBool('appTheme');
  if (e == true) {
    appTheme.value = AppTheme.darkTheme;
  } else {
    appTheme.value = AppTheme.lightTheme;
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /*ChangeNotifierProvider(create: (_) => FoodMenuViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewViewModel()),
        ChangeNotifierProvider(create: (_) => FilterViewModel()),*/
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appTheme,
      builder: (BuildContext context, ThemeData value, Widget? child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: value,
          home: const SplashScreen(),
          routes: {
            OnBoarding.id: (ctx) => const OnBoarding(),
            HomeActivity.id: (ctx) => const HomeActivity(),
            Home.id: (ctx) => const Home(),
            Login.id: (ctx) => const Login(),
            SignUp.id: (ctx) => const SignUp(),
            FillBio.id: (ctx) => const FillBio(),
            SuccessSignUp.id: (ctx) => const SuccessSignUp(),
            SearchScreen.id: (ctx) => const SearchScreen(),
            SearchResult.id: (ctx) => const SearchResult(),
            ChatList.id: (ctx) => const ChatList(),
          },
        );
      },
    );
  }
}
