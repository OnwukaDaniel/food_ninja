import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ninja/backend/controllers/addToCartController.dart';
import 'package:food_ninja/backend/controllers/getRestaurantMenuController.dart';
import 'package:food_ninja/models/RestaurantData.dart';
import 'package:food_ninja/reusable_widgets/ButtonCustom.dart';
import 'package:food_ninja/reusable_widgets/error_image.dart';
import 'package:food_ninja/util/app_color.dart';
import 'package:food_ninja/util/dialogs.dart';
import 'package:food_ninja/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../globals/app_constants.dart';
import '../../globals/network_status.dart';
import '../../models/FoodMenu.dart';
import '../../reusable_widgets/NetworkResponder.dart';
import '../../reusable_widgets/TextCustom.dart';

class RestaurantFood extends HookConsumerWidget {
  final FoodMenu data;

  const RestaurantFood({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<int> networkDataVn = ValueNotifier(NetworkStatus.NETWORK);
    var heartIcon = FontAwesomeIcons.heart;
    var ts = TextStyle(color: Util.txtColor(context));
    var w = MediaQuery.of(context).size.width;

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
                      const SizedBox(height: kToolbarHeight + 28),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 1,
            child: SizedBox(
              width: w,
              child: ButtonWidget(
                color: AppColor.appColor,
                textPadding: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(16),
                radius: const Radius.circular(12),
                baseWidget: Text(
                  "Add to cart",
                  textAlign: TextAlign.center,
                  style: ts.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onTap: () {

                },
              ),
            ),
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

  addToCart(WidgetRef ref, BuildContext context) async {
    var response =
    await ref.watch(addToCartController).addToCart(data);
    if (response.status && context.mounted) {
      CustomDialog.modalDialog(context, "Added");
    } else {
      CustomDialog.modalDialog(context, response.object.toString());
    }
  }
}