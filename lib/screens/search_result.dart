import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/globals/search_filter_type.dart';

import '../globals/app_constants.dart';
import '../globals/network_status.dart';
import '../models/menu_restaurant.dart';
import '../reusable_widgets/NetworkResponder.dart';
import '../reusable_widgets/TextCustom.dart';
import '../sharednotifiers/app.dart';
import '../util/DatabaseRef.dart';
import 'home.dart';

class SearchResult extends StatefulWidget {
  static String id = "SearchResult";

  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  ValueNotifier<List<int>> filterVn = ValueNotifier([]);
  ValueNotifier<int> filterDataVn = ValueNotifier(NetworkStatus.CONNECTION);
  ValueNotifier<List<MenuRestaurant>> menResVn = ValueNotifier([]);

  @override
  void initState() {
    filterVn.value.addAll(foodVN.value);
    filterVn.value.add(typeVN.value);
    filterVn.value.add(locationVN.value);
    getMenRes();
    super.initState();
  }

  @override
  void dispose() {
    menResVn.dispose();
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
              height: height / 4,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width / 1.5,
                    child: Text(
                      "Find Your Favorite Food.",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (width / 6) * 4,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.red, size: 30),
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
                  Container(
                    width: (width / 6) * 1,
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
              const SizedBox(height: 20),
              Text(
                "Result",
                style: TextStyle(
                  fontFamily: fontFamily,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: filterVn,
                builder: (_, List<int> filter, Widget? child) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: filter.length,
                    itemBuilder: (_, index) {
                      int dataFilter = filter[index];
                      var constantOptions = [
                        SearchFilterType.MENU,
                        SearchFilterType.RESTAURANT
                      ];
                      return Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextCustom(
                                text: SearchFilterType.filterText(dataFilter),
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            !constantOptions.contains(dataFilter)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        filter.remove(dataFilter);
                                        filterVn.value = [];
                                        filterVn.value.addAll(filter);
                                        getMenRes();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 40,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              NetworkResponder(
                filterDataVn: filterDataVn,
                success: ValueListenableBuilder(
                  valueListenable: menResVn,
                  builder: (_, List<MenuRestaurant> list, __) {
                    if (list.isNotEmpty) {
                      if (list.first.restaurantUId != "") {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                               "Popular restaurant",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontWeight: FontWeight.bold,
                                fontFamily: fontFamily,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (_, int index) {
                                var data = MenuRestaurant()
                                    .menuResToMenuData(list[index]);
                                return FoodMenuCard(data: data);
                              },
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Text(
                              "Popular menu",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontWeight: FontWeight.bold,
                                fontFamily: fontFamily,
                              ),
                            ),
                            GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: list.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                              ),
                              itemBuilder: (BuildContext context, int e) {
                                var data = MenuRestaurant()
                                    .menuResToRestaurantData(list[e]);
                                return const RestaurantCard(id: "");
                              },
                            ),
                          ],
                        );
                      }
                    } else {
                      return Center(
                        child: TextCustom(
                          padding: const EdgeInsets.all(16),
                          text: "Empty",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontFamily,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getMenRes() {
    String firstChild = "";
    List<MenuRestaurant> list = [];
    if (filterVn.value.contains(SearchFilterType.RESTAURANT)) {
      firstChild = FirebaseConstants().RESTURANT_DATA_PATH;
    } else if (filterVn.value.contains(SearchFilterType.MENU)) {
      firstChild = FirebaseConstants().FOOD_MENU_PATH;
    }
    var ref = FirebaseDatabase.instance.ref().child(firstChild);
    ref.get().then((value) {
      filterDataVn.value = NetworkStatus.NETWORK;
      if (value.exists) {
        for (DataSnapshot s in value.children) {
          var data = MenuRestaurant.getMap(
            Map<String, dynamic>.from(s.value as Map<dynamic, dynamic>),
          );
          if (filterVn.value.length > 2) {
            for (int i in filterVn.value) {
              if (filterVn.value.contains(SearchFilterType.RESTAURANT) ||
                  filterVn.value.contains(SearchFilterType.MENU) ||
                  filterVn.value.contains(SearchFilterType.ONEKM) ||
                  filterVn.value.contains(SearchFilterType.GONEKM) ||
                  filterVn.value.contains(SearchFilterType.LONEKM)) {
                continue;
              }
              if (data.tags
                  .contains(SearchFilterType.filterText(i).toLowerCase())) {
                list.add(data);
                continue;
              }
            }
          } else {
            list.add(data);
          }
        }
        menResVn.value = list;
      } else {}
    }).catchError((e) {
      filterDataVn.value = NetworkStatus.ERROR;
    }).onError((error, stackTrace) {
      filterDataVn.value = NetworkStatus.NO_NETWORK;
    });
  }
}
