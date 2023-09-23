import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ninja/backend/controllers/getRestaurantsDataController.dart';
import 'package:food_ninja/backend/futureContoller/getMenuListFutureController.dart';
import 'package:food_ninja/backend/futureContoller/getRestaurantFutureController.dart';
import 'package:food_ninja/globals/app_constants.dart';
import 'package:food_ninja/models/FoodMenu.dart';
import 'package:food_ninja/models/RestaurantData.dart';
import 'package:food_ninja/reusable_widgets/TextCustom.dart';
import 'package:food_ninja/screens/restaurant.dart';
import 'package:food_ninja/screens/restaurant_food.dart';
import 'package:food_ninja/transistions/slide_left_to_right.dart';
import 'package:food_ninja/util/DatabaseRef.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:food_ninja/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'search_screen.dart';

class Home extends HookConsumerWidget {
  static const String id = "home";

  const Home({Key? key}) : super(key: key);
  final double screenPadding = 16;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Widget loading = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SpinKitRotatingCircle(color: AppColor.appColor, size: 60),
    );
    ValueNotifier<int> backStackCountVn = ValueNotifier(0);
    ValueNotifier<Widget> body1Vn = ValueNotifier(const SizedBox());
    Widget bodyAllRestaurant = ref.watch(getRestaurantFutureController).when(
          data: (data) {
            if (data.status) {
              var dataList = data.object as List<String>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All Restaurant",
                    style: TextStyle(
                      color: Util.txtColor(context),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontFamily,
                    ),
                  ),
                  GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: dataList.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemBuilder: (BuildContext context, int e) {
                      return RestaurantCard(id: dataList[e]);
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  data.object.toString(),
                  style: TextStyle(color: Util.txtColor(context)),
                ),
              );
            }
          },
          error: (_, __) {
            return Center(
              child: Text(
                "Could not fetch data\nReload",
                style: TextStyle(color: Util.txtColor(context)),
              ),
            );
          },
          loading: () => loading,
        );

    Widget allMenu = ref.watch(getMenuListFutureController).when(
          data: (data) {
            if (!data.status) {
              return Center(
                child: Text(
                  data.object.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: fontFamily,
                    color: Util.txtColor(context),
                  ),
                ),
              );
            }
            var foodMenuList = data.object as List<FoodMenu>;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foodMenuList.length,
              shrinkWrap: true,
              itemBuilder: (_, e) {
                var data = foodMenuList[e];
                if (e == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Popular Menu",
                        style: TextStyle(
                          color: Util.txtColor(context),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamily,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FoodMenuCard(data: data),
                    ],
                  );
                }
                return FoodMenuCard(data: data);
              },
            );
          },
          error: (_, e) {
            return Center(
              child: Text(
                e.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: fontFamily,
                  color: Util.txtColor(context),
                ),
              ),
            );
          },
          loading: () => loading,
        );
    Widget bodyHome = Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Image.asset(
            "assets/resturant_dummy_logo/promo_advertising.png",
            width: width,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        ref.watch(getRestaurantFutureController).when(
          data: (data) {
            if (data.status) {
              var dataList = data.object as List<String>;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nearest Restaurant",
                        style: TextStyle(
                          color: Util.txtColor(context),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamily,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          body1Vn.value = bodyAllRestaurant;
                          backStackCountVn.value = 1;
                        },
                        child: Text(
                          "View More",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            fontFamily: fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: dataList.length > 2 ? 2 : dataList.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemBuilder: (BuildContext context, int e) {
                      return RestaurantCard(id: dataList[e]);
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  data.object.toString(),
                  style: TextStyle(color: Util.txtColor(context)),
                ),
              );
            }
          },
          error: (_, __) {
            return Center(
              child: Text(
                "Could not fetch data\nReload",
                style: TextStyle(color: Util.txtColor(context)),
              ),
            );
          },
          loading: () {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SpinKitRotatingCircle(
                size: 40,
                color: AppColor.appColor,
              ),
            );
          },
        ),
        ref.watch(getMenuListFutureController).when(
              data: (data) {
                if (!data.status) {
                  return Center(
                    child: Text(
                      data.object.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: fontFamily,
                        color: Util.txtColor(context),
                      ),
                    ),
                  );
                }
                var foodMenuList = data.object as List<FoodMenu>;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: foodMenuList.length > 4 ? 4 : foodMenuList.length,
                  shrinkWrap: true,
                  itemBuilder: (_, e) {
                    var data = foodMenuList[e];
                    if (e == 0) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Popular Menu",
                                style: TextStyle(
                                  color: Util.txtColor(context),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: fontFamily,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  body1Vn.value = allMenu;
                                  backStackCountVn.value = 1;
                                },
                                child: Text(
                                  "View More",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                    fontFamily: fontFamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          FoodMenuCard(data: data),
                        ],
                      );
                    }
                    return FoodMenuCard(
                      data: data,
                    );
                  },
                );
              },
              error: (_, e) {
                return Center(
                  child: Text(
                    e.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: fontFamily,
                      color: Util.txtColor(context),
                    ),
                  ),
                );
              },
              loading: () => loading,
            ),
      ],
    );
    body1Vn.value = bodyHome;

    return WillPopScope(
      onWillPop: () async {
        if (backStackCountVn.value != 0) {
          backStackCountVn.value = 0;
          body1Vn.value = bodyHome;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Util.bgColor(context),
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
              padding: EdgeInsets.all(screenPadding),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: kToolbarHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width / 1.5,
                      child: Text(
                        "Find Your Favorite Food.",
                        style: TextStyle(
                          color: Util.txtColor(context),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(12, 40), //(x,y)
                            blurRadius: 66,
                            spreadRadius: 20,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Image.asset(
                        "assets/home/notification.png",
                        width: 30,
                        height: 30,
                        errorBuilder: (_, __, ___) {
                          return const Icon(Icons.access_alarms_rounded);
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SearchScreen.id);
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.search,
                                  color: Colors.red, size: 30),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "What do you want to order?",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontFamily: fontFamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        "assets/home/pref_notification.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder(
                  valueListenable: body1Vn,
                  builder: (_, Widget value, __) => value,
                ),
                const SizedBox(height: kToolbarHeight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FoodMenuCard extends StatefulWidget {
  final FoodMenu data;

  const FoodMenuCard({Key? key, required this.data}) : super(key: key);

  @override
  State<FoodMenuCard> createState() => _FoodMenuCardState();
}

class _FoodMenuCardState extends State<FoodMenuCard> {
  ValueNotifier<String> nameVN = ValueNotifier("----");

  @override
  void initState() {
    getFoodMenu(widget.data.restaurantUId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenPadding = 16;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SlideLeftToRight(page: RestaurantFood(data: widget.data)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.network(
                widget.data.images.first,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return SizedBox(
                    width: (width / 2) - screenPadding * 2,
                    height: 170,
                    child: SpinKitFadingCube(
                      color: AppColor.appColor,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  text: widget.data.name,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: Util.txtColor(context),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: nameVN,
                  builder: (_, String value, Widget? child) {
                    return TextCustom(
                      text: value,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: fontFamily,
                      ),
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  widget.data.currency,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  widget.data.price.toString(),
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getFoodMenu(String uid) {
    var fConst = FirebaseConstants();
    var ref = FirebaseDatabase.instance
        .ref()
        .child(fConst.RESTURANT_DATA_PATH)
        .child(uid);
    ref.get().then((value) {
      if (value.exists) {
        var data = RestaurantData.getMap(
            Map<String, dynamic>.from(value.value as Map<dynamic, dynamic>));
        nameVN.value = data.name;
      }
    });
  }
}

class RestaurantCard extends HookConsumerWidget {
  final String id;

  const RestaurantCard({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;
    double screenPadding = 16;

    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                offset: const Offset(2, 4), //(x,y)
                blurRadius: 8,
                spreadRadius: 5,
              ),
            ],
          ),
          child: FutureBuilder<RestaurantData>(
            future: getRestaurantData(ref, id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitDualRing(
                    size: 70,
                    color: AppColor.appColor,
                  ),
                );
              }
              var data = snapshot.data!;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    SlideLeftToRight(page: Restaurant(data: data)),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      data.images.first,
                      width: (width / 2) - screenPadding * 2,
                      height: 100,
                      errorBuilder: (_, __, ___) {
                        return SizedBox(
                          width: (width / 2) - screenPadding * 2,
                          height: 170,
                          child: SpinKitFadingCube(
                            color: AppColor.appColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    TextCustom(
                      text: data.name,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: Util.txtColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextCustom(
                      text: "-- Min",
                      style:
                          TextStyle(color: Colors.grey, fontFamily: fontFamily),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<RestaurantData> getRestaurantData(WidgetRef ref, String key) async {
    var response =
        await ref.watch(getRestaurantsDataController).getRestaurantsData(key);
    if (response.status) {
      return Future.value(response.object as RestaurantData);
    } else {
      return Future.value(RestaurantData());
    }
  }
}
