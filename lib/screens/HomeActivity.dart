import 'package:flutter/material.dart';
import 'package:food_ninja/backend/controllers/updateProfileController.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:food_ninja/screens/home.dart';
import 'package:food_ninja/screens/profile/profile_screen.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../sharednotifiers/app.dart';
import 'chat_list.dart';

class HomeActivity extends HookConsumerWidget {
  static const String id = "HomeActivity";

  const HomeActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;
    ValueNotifier<int> currentPageVn = ValueNotifier(0);
    int bottomCount = 4;
    var pad = const EdgeInsets.all(12);

    List<Widget> fragments = [
      const Home(),
      const ProfileScreen(),
      const SizedBox(),
      const ChatList(),
    ];
    double iconSize = 25;
    double iconHeight = 50;

    List<Widget> activatedWidget = [
      Container(
        padding: const EdgeInsets.all(12),
        margin: pad.copyWith(right: 0),
        width: width / 3,
        height: iconHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.lightGreen10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/bottom_navigation/Home.png",
              width: 30,
              height: 30,
            ),
            const Text(
              "Home",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(12),
        margin: pad.copyWith(right: 0, left: 0),
        width: width / 3,
        height: iconHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.lightGreen10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/bottom_navigation/Profile.png",
              width: 30,
              height: 30,
            ),
            const Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(12),
        margin: pad.copyWith(right: 0, left: 0),
        width: width / 3,
        height: iconHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.lightGreen10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/bottom_navigation/Buy.png",
              width: 30,
              height: 30,
            ),
            const Text(
              "Buy",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(12),
        margin: pad.copyWith(left: 0),
        width: width / 3,
        height: iconHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.lightGreen10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/bottom_navigation/Chat.png",
              width: 30,
              height: 30,
            ),
            const Text(
              "Chat",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    ];
    List<Widget> inActivatedWidget = [
      GestureDetector(
        onTap: () {
          currentPageVn.value = 0;
          homeBackStackCounterVN.value = 0;
        },
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          width: iconSize,
          height: iconHeight,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Image.asset(
            "assets/bottom_navigation/Home.png",
            width: 30,
            height: 30,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          currentPageVn.value = 1;
          homeBackStackCounterVN.value = 1;
        },
        child: Container(
          width: iconSize,
          height: iconHeight,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Image.asset(
            "assets/bottom_navigation/Profile.png",
            width: 30,
            height: 20,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          currentPageVn.value = 2;
          homeBackStackCounterVN.value = 1;
        },
        child: Container(
          width: iconSize,
          height: iconHeight,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Image.asset(
            "assets/bottom_navigation/Buy.png",
            width: 30,
            height: 30,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          currentPageVn.value = 3;
          homeBackStackCounterVN.value = 1;
        },
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          width: iconSize,
          height: iconHeight,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Image.asset(
            "assets/bottom_navigation/Chat.png",
            width: 30,
            height: 30,
          ),
        ),
      ),
    ];

    getUserProfile(ref);
    return ValueListenableBuilder(
      valueListenable: homeBackStackCounterVN,
      builder: (BuildContext context, int backCount, Widget? child) {
        return WillPopScope(
          onWillPop: () async {
            if (backCount != 0) {
              currentPageVn.value = 0;
              homeBackStackCounterVN.value = 0;
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Stack(
              children: [
                ValueListenableBuilder(
                  valueListenable: currentPageVn,
                  builder: (_, int currentPage, Widget? child) {
                    return fragments[currentPage];
                  },
                ),
                Positioned(
                  bottom: 1,
                  child: Container(
                    width: width - 24,
                    margin: pad.copyWith(top: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).cardColor,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: currentPageVn,
                      builder: (_, int value, Widget? child) {
                        List<Widget> showing = [];
                        for (int i in Iterable<int>.generate(bottomCount).toList()) {
                          if (i == value) {
                            showing.add(activatedWidget[i]);
                          } else {
                            showing.add(inActivatedWidget[i]);
                          }
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: showing,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getUserProfile(WidgetRef ref) async {
    var response = await ref.watch(updateProfileController).getProfile();
    if (response.status) userProfileVN.value = response.object as UserProfile;
  }
}
