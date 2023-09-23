import 'package:flutter/material.dart';

import '../util/app_color.dart';
import 'TextCustom.dart';

class ActionEditText extends StatefulWidget {
  final String hint;
  final String text;
  final String actionText;
  final List<String> services;
  final TextInputType textInputType;
  final bool hasPasswordText;
  final Color borderColor;
  final TextInputAction textInputAction;

  const ActionEditText({
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
  State<ActionEditText> createState() => _ActionEditTextState();
}

class _ActionEditTextState extends State<ActionEditText> {
  String actionText = '';

  @override
  Widget build(BuildContext context) {
    var appColor = AppColor();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextCustom(
            text: actionText,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color!,
            ),
          ),
          const Spacer(),
          DropdownButton(
            dropdownColor: Theme.of(context).cardColor,
            focusColor: Colors.transparent,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).textTheme.bodyText1!.color!,
            ),
            items: widget.services.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                actionText = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}
