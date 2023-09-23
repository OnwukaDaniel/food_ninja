import 'package:flutter/material.dart';

import 'TextCustom.dart';

class EditTextSuffix extends StatefulWidget {
  final String hint;
  final String suffixText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool hasPasswordText;
  final Color borderColor;
  final TextInputAction textInputAction;

  const EditTextSuffix({
    Key? key,
    this.hint = "",
    this.suffixText = "",
    this.hasPasswordText = false,
    required this.controller,
    this.borderColor = const Color(0xffb7b7b7),
    this.textInputAction = TextInputAction.none,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  State<EditTextSuffix> createState() => _EditTextSuffixState();
}

class _EditTextSuffixState extends State<EditTextSuffix> {
  bool isValid = true;
  var invalidBorder = Colors.red;

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    widget.controller.addListener(() {
      if(widget.controller.text.isEmpty){
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: isValid? widget.borderColor: invalidBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        decoration: InputDecoration(
            suffixIconConstraints: const BoxConstraints(maxHeight: 14),
            suffixIcon: SizedBox(
              width: 180,
              child: TextCustom(
                alignment: Alignment.centerRight,
                text: widget.suffixText,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            fillColor: Colors.white,
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Colors.black12),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      ),
    );
  }
}
