import 'package:flutter/material.dart';

class Snackbar{
  static void showToast(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}