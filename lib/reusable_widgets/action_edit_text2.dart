import 'package:flutter/material.dart';
import '../util/app_color.dart';
import 'TextCustom.dart';

class ActionEditText2 extends StatelessWidget {
  final String hint;
  final String text;
  final String actionText;
  final List<PopupMenuItem> services;
  final TextInputType textInputType;
  final bool hasPasswordText;
  final Color borderColor;
  final TextInputAction textInputAction;

  const ActionEditText2({
    Key? key,
    this.services = const [],
    this.hint = "",
    this.text = "",
    this.actionText = "",
    this.hasPasswordText = false,
    this.borderColor = const Color(0xffb7b7b7),
    this.textInputAction = TextInputAction.none,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColor = AppColor();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextCustom(
            text: text == "" ? hint : text,
            style: TextStyle(color: text == "" ? Colors.white54 : Colors.black),
          ),
          const Spacer(),
          SizedBox(
            width: (actionText.length + 5) * 7,
            child: TextCustom(
              alignment: Alignment.centerRight,
              text: actionText,
              padding: const EdgeInsets.symmetric(horizontal: 3),
            ),
          ),
        ],
      ),
    );
  }
}
