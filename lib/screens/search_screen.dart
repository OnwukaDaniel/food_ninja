import 'package:flutter/material.dart';
import 'package:food_ninja/screens/search_result.dart';

import '../globals/app_constants.dart';
import '../globals/search_filter_type.dart';
import '../reusable_widgets/TextCustom.dart';
import '../util/app_color.dart';
import '../sharednotifiers/app.dart';

class SearchScreen extends StatefulWidget {
  static String id = "SearchScreen";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Stack(
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
                  "Type",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontFamily: fontFamily,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: typeVN,
                      builder: (_, int value, Widget? child) {
                        var color = value == SearchFilterType.RESTAURANT
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            typeVN.value = SearchFilterType.RESTAURANT;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: "Restaurant",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: typeVN,
                      builder: (_, int value, Widget? child) {
                        var color = value == SearchFilterType.MENU
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            typeVN.value = SearchFilterType.MENU;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: "Menu",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Location",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontFamily: fontFamily,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: locationVN,
                      builder: (_, int value, Widget? child) {
                        var color = value == SearchFilterType.ONEKM
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            locationVN.value = SearchFilterType.ONEKM;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: "1 KM",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: locationVN,
                      builder: (_, int value, Widget? child) {
                        var color = value == SearchFilterType.GONEKM
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            locationVN.value = SearchFilterType.GONEKM;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: ">10 KM",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: locationVN,
                      builder: (_, int value, Widget? child) {
                        var color = value == SearchFilterType.LONEKM
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            locationVN.value = SearchFilterType.LONEKM;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: "<10 KM",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Food",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontFamily: fontFamily,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: foodVN,
                      builder: (_, List<int> value, Widget? child) {
                        var color = value.contains(SearchFilterType.CAKE)
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            if(value.contains(SearchFilterType.CAKE)){
                              value.remove(SearchFilterType.CAKE);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            } else {
                              value.add(SearchFilterType.CAKE);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: "CAKE",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: foodVN,
                      builder: (_, List<int> value, Widget? child) {
                        var color = value.contains(SearchFilterType.SOUP)
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            if(foodVN.value.contains(SearchFilterType.SOUP)){
                              value.remove(SearchFilterType.SOUP);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            } else {
                              value.add(SearchFilterType.SOUP);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: "SOUP",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: foodVN,
                      builder: (_, List<int> value, Widget? child) {
                        var color = value.contains(SearchFilterType.MAIN_COURSE)
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            if(foodVN.value.contains(SearchFilterType.MAIN_COURSE)){
                              value.remove(SearchFilterType.MAIN_COURSE);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            } else {
                              value.add(SearchFilterType.MAIN_COURSE);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: "MAIN COURSE",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: foodVN,
                      builder: (_, List<int> value, Widget? child) {
                        var color = value.contains(SearchFilterType.APPETIZER)
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            if(foodVN.value.contains(SearchFilterType.APPETIZER)){
                              value.remove(SearchFilterType.APPETIZER);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            } else {
                              value.add(SearchFilterType.APPETIZER);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: "APPETIZER",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: foodVN,
                      builder: (_, List<int> value, Widget? child) {
                        var color = value.contains(SearchFilterType.DESSERT)
                            ? Colors.grey
                            : Theme.of(context).cardColor;
                        return GestureDetector(
                          onTap: () {
                            if(foodVN.value.contains(SearchFilterType.DESSERT)){
                              value.remove(SearchFilterType.DESSERT);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            } else {
                              value.add(SearchFilterType.DESSERT);
                              foodVN.value = [];
                              foodVN.value.addAll(value);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: TextCustom(
                              text: "DESSERT",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, SearchResult.id);
        },
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.appColor,
          ),
          child: TextCustom(
            text: "Search",
            style: TextStyle(
              fontFamily: fontFamily,
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color,
            ),
            padding: const EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}