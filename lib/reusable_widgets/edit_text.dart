import 'package:flutter/material.dart';
import 'package:food_ninja/util/util.dart';

import '../util/app_color.dart';

class EditText extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool hasPasswordText;
  final Color borderColor;
  final double borderWidth;
  final Color hintColor;
  final Color invalidBorder;
  final EdgeInsets padding;
  final double innerHeight;
  final int minLines;
  final Widget leading;
  final Widget tailIcon;
  final bool hasTailIcon;
  final int maxLines;
  final double leadingSpace;
  final BorderRadius borderRadius;
  final bool hasDecoration;
  final TextInputAction textInputAction;

  const EditText({
    Key? key,
    this.hint = "",
    this.innerHeight = 8,
    this.minLines = 1,
    this.leading = const SizedBox(),
    this.maxLines = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    this.hasPasswordText = false,
    this.hasDecoration = true,
    this.hasTailIcon = false,
    this.leadingSpace = 0,
    this.borderRadius = BorderRadius.zero,
    this.borderWidth = 1,
    this.tailIcon = const Icon(Icons.person),
    required this.controller,
    this.borderColor = const Color(0xff3e3e3e),
    this.hintColor = Colors.grey,
    this.invalidBorder = Colors.red,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  bool _passwordVisible = false;
  bool isValid = true;

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    widget.controller.addListener(() {
      if (widget.controller.text.isEmpty) {
        setState(() {
          isValid = false;
        });
      } else {
        setState(() {
          isValid = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.padding,
      decoration: BoxDecoration(
        color: Util.bgColor(context),
        border: widget.hasDecoration == true
            ? Border.all(
                color: isValid ? widget.borderColor : widget.invalidBorder, width: widget.borderWidth)
            : Border.all(color: widget.borderColor, width: widget.borderWidth),
        borderRadius: widget.borderRadius,
      ),
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(width: widget.leadingSpace),
              widget.leading,
            ],
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              keyboardType: widget.textInputType,
              obscureText: _passwordVisible,
              textInputAction: widget.textInputAction,
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIconColor: AppColor.appColor,
                suffixIconConstraints: const BoxConstraints(maxHeight: 14),
                suffixIcon: widget.hasPasswordText == true
                    ? InkWell(
                        onTap: () => setState(
                          () {
                            _passwordVisible = !_passwordVisible;
                          },
                        ),
                        child: SizedBox(
                          width: 60,
                          child: _passwordVisible == true
                              ? Icon(
                                  Icons.remove_red_eye,
                                  color: AppColor.appColor,
                                )
                              : Image.asset(
                                  "assets/onboarding/eye_closed.png",
                                  color: AppColor.appColor,
                                  width: 40,
                                  height: 40,
                                ),
                        ),
                      )
                    : widget.hasTailIcon
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: widget.tailIcon,
                          )
                        : const SizedBox(),
                fillColor: Colors.white,
                isDense: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(color: widget.hintColor),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
