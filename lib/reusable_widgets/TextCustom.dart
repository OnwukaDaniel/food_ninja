import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final TextStyle style;
  final String text;
  final int maxLines;
  final EdgeInsets padding;
  final TextAlign textAlign;
  final Alignment alignment;

  const TextCustom({
    Key? key,
    required this.text,
    this.style = const TextStyle(),
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.padding = const EdgeInsets.only(top: 0.0),
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: padding,
          child: Align(
            alignment: alignment,
            child: Text(
              text,
              style: style,
              textAlign: TextAlign.center,
              maxLines: maxLines,
            ),
          ),
        ),
      ],
    );
  }
}
