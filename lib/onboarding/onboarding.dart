import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/reusable_widgets/ButtonCustom.dart';
import 'package:food_ninja/util/app_color.dart';

import 'login.dart';

class OnBoarding extends StatefulWidget {
  static const String id = "OnBoarding";

  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  CarouselController carouselController = CarouselController();
  int carouselIndex = 0;

  List<String> images = [
    "assets/onboarding/illustartion1.png",
    "assets/onboarding/illustration2.png",
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          CarouselSlider(
            carouselController: carouselController,
            items: images.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Image.asset(e)),
                  const SizedBox(height: 25),
                ],
              );
            }).toList(),
            options: CarouselOptions(
              height: height / 1.5,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              onPageChanged: (value, carouselPageChangedReason) {
                setState(() {
                  carouselIndex = value;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  carouselIndex == 0
                      ? "Find your comfort\nFood here"
                      : "Food Ninja is Where Your Comfort Food Lives",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "LibreFranklin",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text(
                    carouselIndex == 0
                        ? "Here You Can find a chef or dish for every taste and color. Enjoy!"
                        : "Enjoy a fast and smooth food delivery at your doorstep",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 16,
                      fontFamily: "LibreFranklin",
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                ButtonWidget(
                  textPadding: const EdgeInsets.symmetric(horizontal: 46),
                  color: AppColor.lightGreen,
                  radius: const Radius.circular(15),
                  onTap: () {
                    if (carouselIndex == 0) {
                      carouselController.nextPage();
                    } else {
                      Navigator.pushNamed(context, Login.id);
                    }
                  },
                  baseWidget: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      carouselIndex == 0
                          ? "Next"
                          : "Continue",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "LibreFranklin",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
