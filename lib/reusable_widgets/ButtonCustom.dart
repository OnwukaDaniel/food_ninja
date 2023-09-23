import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final TextStyle style;
  final String text;
  final Color color;
  final Radius radius;
  final EdgeInsets padding;
  final EdgeInsets textPadding;
  final TextAlign textAlign;
  final double elevation;
  final Function() onTap;

  const ButtonCustom({
    Key? key,
    required this.text,
    this.color = Colors.black45,
    this.style = const TextStyle(),
    this.elevation = 5,
    this.textAlign = TextAlign.center,
    this.radius = const Radius.circular(0),
    required this.onTap,
    this.padding = const EdgeInsets.only(top: 0.0),
    this.textPadding = const EdgeInsets.only(top: 0.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onTap,
        child: Material(
          elevation: elevation,
          color: color,
          borderRadius: BorderRadius.all(radius),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: textPadding,
            child: Text(text, textAlign: textAlign, style: style),
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final Widget baseWidget;
  final Color color;
  final Radius radius;
  final double elevation;
  final EdgeInsets padding;
  final EdgeInsets textPadding;
  final VoidCallback onTap;

  const ButtonWidget({
    Key? key,
    required this.baseWidget,
    this.color = Colors.black45,
    this.elevation = 5,
    this.radius = const Radius.circular(0),
    required this.onTap,
    this.padding = const EdgeInsets.only(top: 0.0),
    this.textPadding = const EdgeInsets.only(top: 0.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onTap,
        child: Material(
          elevation: elevation,
          color: color,
          borderRadius: BorderRadius.all(radius),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: textPadding,
            child: baseWidget,
          ),
        ),
      ),
    );
  }
}

class ButtonWidgetLined extends StatelessWidget {
  final Widget baseWidget;
  final Color color;
  final Radius radius;
  final double elevation;
  final bool outline;
  final Color outlineColor;
  final EdgeInsets padding;
  final EdgeInsets textPadding;
  final VoidCallback onTap;

  const ButtonWidgetLined({
    Key? key,
    required this.baseWidget,
    this.color = Colors.black45,
    this.elevation = 5,
    this.outline = false,
    this.outlineColor = Colors.transparent,
    this.radius = const Radius.circular(0),
    required this.onTap,
    this.padding = const EdgeInsets.only(top: 0.0),
    this.textPadding = const EdgeInsets.only(top: 0.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onTap,
        child: Material(
          elevation: elevation,
          color: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: outlineColor),
            borderRadius: BorderRadius.all(radius),
          ),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: textPadding,
            child: baseWidget,
          ),
        ),
      ),
    );
  }
}
