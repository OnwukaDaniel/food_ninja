import 'package:flutter/material.dart';
import 'package:food_ninja/reusable_widgets/error_image.dart';
import 'package:food_ninja/sharednotifiers/app.dart';
import 'package:food_ninja/theme/apptheme.dart';
import 'package:food_ninja/transistions/slide_left_to_right.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:food_ninja/util/snackbar.dart';
import 'package:food_ninja/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals/app_constants.dart';
import '../../globals/network_status.dart';
import '../../models/FoodMenu.dart';
import '../../models/UserProfile.dart';
import '../../models/Voucher.dart';
import '../../reusable_widgets/NetworkResponder.dart';
import '../../reusable_widgets/TextCustom.dart';
import '../../sharednotifiers/home.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ValueNotifier<int> networkDataVn = ValueNotifier(NetworkStatus.NETWORK);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: userProfileVN,
            builder: (_, UserProfile profile, __) {
              return Image.network(
                profile.image,
                width: MediaQuery.of(context).size.width,
                height: 290,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: ErrorImage(w: MediaQuery.of(context).size.width, h: 290),
                  );
                },
              );
            },
          ),
          ListView(
            children: [
              const SizedBox(height: 220),
              NetworkResponder(
                filterDataVn: networkDataVn,
                success: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42),
                    color: Util.bgColor(context),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Colors.grey.withOpacity(0.6),
                            ),
                            height: 7,
                            width: 100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: AppColor.appColor.withOpacity(0.3),
                            ),
                            child: TextCustom(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(8),
                              text: "Member Gold",
                              style: TextStyle(
                                color: AppColor.appOrange,
                                fontFamily: fontFamily,
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: appTheme,
                            builder: (_, ThemeData value, Widget? child) {
                              if (value == AppTheme.darkTheme) {
                                return IconButton(
                                  onPressed: () async {
                                    var prefs = await SharedPreferences
                                        .getInstance();
                                    prefs.setBool('appTheme', false);
                                    appTheme.value = AppTheme.lightTheme;
                                  },
                                  icon: const Icon(
                                    Icons.sunny,
                                    color: Colors.amber,
                                  ),
                                );
                              } else {
                                return IconButton(
                                  onPressed: () async {
                                    var prefs = await SharedPreferences
                                        .getInstance();
                                    prefs.setBool('appTheme', true);
                                    appTheme.value = AppTheme.darkTheme;
                                  },
                                  icon: const Icon(
                                    Icons.nightlight,
                                    color: Colors.black54,
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      ValueListenableBuilder(
                        valueListenable: errorMsgUserprofileVN,
                        builder: (_, String value, __) {
                          if (value != "") {
                            Snackbar.showToast(value, context);
                            return const SizedBox();
                          }
                          return ValueListenableBuilder(
                            valueListenable: userProfileVN,
                            builder: (_, UserProfile profile, __) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextCustom(
                                        alignment: Alignment.centerLeft,
                                        text: profile.fullName,
                                        style: TextStyle(
                                          fontSize: 27,
                                          color: Util.txtColor(context),
                                          fontWeight: FontWeight.w800,
                                          fontFamily: fontFamily,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            SlideLeftToRight(
                                              page: const EditProfile(),
                                            ),
                                          );
                                        },
                                        icon: Image.asset(
                                          "assets/home/edit.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  TextCustom(
                                    alignment: Alignment.centerLeft,
                                    text: profile.email,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey,
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: voucherVN,
                        builder: (_, List<Voucher> value, __) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  offset: const Offset(5, 5), //(x,y)
                                  blurRadius: 12,
                                  spreadRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/home/voucher_icon.png",
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextCustom(
                                    alignment: Alignment.centerLeft,
                                    text: "You have ${value.length} vouchers",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Util.txtColor(context),
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextCustom(
                        alignment: Alignment.centerLeft,
                        text: "Favourite",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontFamily: fontFamily,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: favouriteVN,
                        builder: (_, List<FoodMenu> value, __) {
                          if (value.isEmpty) {
                            return TextCustom(
                              text: "You have no favorite dishes yet.",
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontFamily: fontFamily,
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, int index) {
                              var data = value[index];
                              return FavoriteMenuCard(data: data);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: kToolbarHeight + 24),
            ],
          ),
        ],
      ),
    );
  }
}

class FavoriteMenuCard extends StatelessWidget {
  const FavoriteMenuCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final FoodMenu data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Util.cardColor(context),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(12, 40), //(x,y)
            blurRadius: 12,
            spreadRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(34),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.lightGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              data.images.first,
              width: 65,
              height: 65,
              errorBuilder: (_, __, ___){
                return const ErrorImage(w: 35, h: 35);
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Util.txtColor(context),
                    fontFamily: fontFamily,
                  ),
                ),
                Text(
                  data.desc,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.withOpacity(0.8),
                    fontFamily: fontFamily,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      data.currency,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.lightGreen,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      data.price.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.lightGreen,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColor.lightGreen),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            onPressed: () {},
            child: Text(
              "Buy Again",
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
