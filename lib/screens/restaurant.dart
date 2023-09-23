import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ninja/backend/controllers/getRestaurantMenuController.dart';
import 'package:food_ninja/models/RestaurantData.dart';
import 'package:food_ninja/reusable_widgets/ButtonCustom.dart';
import 'package:food_ninja/reusable_widgets/error_image.dart';
import 'package:food_ninja/transistions/slide_left_to_right.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:food_ninja/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../globals/app_constants.dart';
import '../../globals/network_status.dart';
import '../../models/FoodMenu.dart';
import '../../reusable_widgets/NetworkResponder.dart';
import '../../reusable_widgets/TextCustom.dart';
import 'restaurant_food.dart';

class Restaurant extends HookConsumerWidget {
  final RestaurantData data;

  const Restaurant({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<int> networkDataVn = ValueNotifier(NetworkStatus.NETWORK);
    var heartIcon = FontAwesomeIcons.heart;
    var ts = TextStyle(color: Util.txtColor(context));

    return Scaffold(
      backgroundColor: Util.bgColor(context),
      body: Stack(
        children: [
          Image.network(
            data.images.first,
            width: MediaQuery.of(context).size.width,
            height: 290,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Icon(
                Icons.person,
                color: AppColor.appColor,
                size: 100,
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
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: AppColor.appColor.withOpacity(0.3),
                            ),
                            child: TextCustom(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(8),
                              text: "Popular",
                              style: TextStyle(
                                color: AppColor.appColor,
                                fontFamily: fontFamily,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                              backgroundColor:
                                  AppColor.appColor.withOpacity(0.3),
                              radius: 18,
                              child: Icon(
                                Icons.location_on_rounded,
                                color: AppColor.appColor,
                              ),
                            ),
                          ),
                          StatefulBuilder(
                            builder:
                                (_, void Function(void Function()) setState) {
                              return IconButton(
                                onPressed: () {
                                  setState(() {
                                    heartIcon = FontAwesomeIcons.solidHeart;
                                  });
                                },
                                icon: CircleAvatar(
                                  backgroundColor:
                                      AppColor.appColor.withOpacity(0.3),
                                  radius: 18,
                                  child: Icon(heartIcon, color: Colors.red),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data.name,
                        style: ts.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColor.appColor,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Location",
                            style: ts.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            FontAwesomeIcons.starHalfAlt,
                            color: AppColor.appColor,
                            size: 15,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "4.8 Rating",
                            style: ts.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Builder(builder: (context) {
                        var textMax = 3;
                        return StatefulBuilder(
                          builder: (_, void Function(void Function()) set) {
                            return GestureDetector(
                              onTap: () {
                                set(() {
                                  if (textMax < 4) {
                                    textMax = (data.desc.length / 5).round();
                                  } else {
                                    textMax = 3;
                                  }
                                });
                              },
                              child: Text(
                                data.desc,
                                maxLines: textMax,
                                style: ts.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                      const SizedBox(height: 28),
                      ButtonWidget(
                        color: AppColor.appColor,
                        textPadding: const EdgeInsets.symmetric(vertical: 16),
                        radius: const Radius.circular(12),
                        baseWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Track",
                              textAlign: TextAlign.center,
                              style: ts.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder(
                        future: getRestaurantMenu(ref, data.id),
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: SpinKitDualRing(
                                size: 70,
                                color: AppColor.appColor,
                              ),
                            );
                          } else {
                            var dataList = snapshot.data as List<FoodMenu>;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    Text(
                                      "Popular",
                                      style: ts.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "View All",
                                      style: ts.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.appColor,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 170,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: dataList.length,
                                    itemBuilder: (_, int index) {
                                      return FavoriteMenuCard(
                                        data: dataList[index],
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<FoodMenu>> getRestaurantMenu(WidgetRef ref, String key) async {
    var response =
        await ref.watch(getRestaurantMenuController).getRestaurantMenu(key);
    if (response.status) {
      return Future.value(response.object as List<FoodMenu>);
    } else {
      return Future.value([]);
    }
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
    var ts = TextStyle(color: Util.txtColor(context));

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          SlideLeftToRight(page: RestaurantFood(data: data)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              data.images.first,
              width: 100,
              height: 100,
              errorBuilder: (_, __, ___) => const ErrorImage(w: 100, h: 100),
            ),
            Expanded(
              child: Text(
                data.name,
                style: ts.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamily,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  data.currency,
                  style: ts.copyWith(
                    color: AppColor.lightGreen,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  data.price.toString(),
                  style: ts.copyWith(
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
    );
  }
}
