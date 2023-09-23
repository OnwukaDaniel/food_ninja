import 'package:flutter/material.dart';

import '../globals/app_constants.dart';
import '../models/ChatData.dart';
import '../reusable_widgets/TextCustom.dart';
import '../sharednotifiers/app.dart';
import '../util/app_color.dart';

class ChatList extends StatefulWidget {
  static const String id = "ChatList";
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
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
            children: [
              Wrap(
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
              const SizedBox(height: 20),
              Text(
                "Chat",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamily,
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: chatListVN,
                builder: (_, List<ChatData> value, Widget? child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.length,
                    itemBuilder: (BuildContext context, int index) {
                      ChatData data = value[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(32),
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
                              child: Image.asset(
                                "assets/resturant_dummy_logo/vegan_restto.png",
                                width: 65,
                                height: 65,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextCustom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    text: "data.name",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                  TextCustom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    text: data.time,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      TextCustom(
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        text: "data.currency",
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColor.lightGreen,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Text(
                                "Buy Again",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
