import 'package:flutter/material.dart';

class SlideLeftToRight extends PageRouteBuilder {
  final Widget page;

  SlideLeftToRight({required this.page})
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
              reverseCurve: Curves.easeOut,
            );
            return SlideTransition(
              position: Tween(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: page,
            );
          },
        );
}
