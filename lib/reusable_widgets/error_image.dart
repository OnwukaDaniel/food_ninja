import 'package:flutter/material.dart';
import 'package:food_ninja/util/util.dart';

class ErrorImage extends StatelessWidget {
  final double h;
  final double w;

  const ErrorImage({Key? key, required this.w, required this.h}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        "assets/home/error_image.png",
        width: w,
        height: h,
        fit: BoxFit.cover,
        color: Util.txtColor(context),
      ),
    );
  }
}
