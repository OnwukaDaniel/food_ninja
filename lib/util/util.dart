import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Util {
  static var months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  static var monthsShort = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  static var dayShort = ["Mon", "Tue", "Wed", "Thurs", "Fri", "Sat", "Sun"];

  String removeWhiteSpace(String input) {
    var output = "";
    for (String i in input.characters) {
      if (i.toString() == " ") {
        continue;
      }
      output += i;
    }
    return output;
  }

  String formatNumber(String input) {
    var accepted = removeWhiteSpace(input);
    if (accepted.length < 10) {
      return accepted;
    }
    return accepted.substring(accepted.length - 10, accepted.length);
  }

  static String timeDate(String input, {String sep = ":"}) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(input));
    var day = date.day.toString();
    var monthInt = date.month;
    var year = date.year.toString();
    var minute = date.minute.toString().length == 1
        ? "0${date.minute.toString()}"
        : date.minute.toString();
    var ap = date.minute.toString();
    var hour = date.hour.toString();
    return "$hour sep$minute - $day sep$monthInt sep$year";
  }

  static String date2(String input, {String sep = " - "}) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(input), isUtc: true);
    var day = date.weekday - 1;
    var monthInt = date.month;
    var year = date.year.toString();
    return "${Util.dayShort[day]}$sep${Util.monthsShort[monthInt]}$sep$year";
  }

  static String date(String input, {String sep = " - "}) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(input));
    var day = date.day.toString();
    var monthInt = date.month;
    var year = date.year.toString();
    return "$day$sep$monthInt$sep$year";
  }

  static String otherUid(String myUid, String uid1, String uid2) {
    if (myUid == uid1) {
      return uid2;
    }
    if (myUid == uid2) {
      return uid1;
    }
    return uid1;
  }

  static String time(String input, {String sep = " - "}) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(input));
    var day = date.day.toString();
    var monthInt = date.month;
    var year = date.year.toString();
    var minute = date.minute.toString().length == 1
        ? "0${date.minute.toString()}"
        : date.minute.toString();
    var ap = date.minute.toString();
    var hour = date.hour.toString();
    return "$hour$sep$minute";
  }

  static String toCurrency(String input){
    String finalValue = "";
    if(input.length <= 1){
      return input;
    }
    int threeCounts = 0;
    for(int i = input.length - 1; i >= 0; i--){
      if(threeCounts == 3){
        threeCounts = 0;
        finalValue += ",";
      }
      finalValue += input[i];
      threeCounts ++;
    }
    return reverse(finalValue);
  }

  static String reverse(String input){
    String finalValue = "";
    if(input.length <= 1){
      return input;
    }
    int threeCounts = 0;
    for(int i = input.length - 1; i >= 0; i--){
      finalValue += input[i];
    }
    return finalValue;
  }

  static String scrambleEmail(String input){
    var spilt = input.split("@");
    int splitterCount = (spilt.first.length / 3).round();
    var first = input.substring(0, splitterCount);
    var second = input.substring(splitterCount * 2, spilt.first.length);
    return "$first...$second@${spilt.last}";
  }

  static Color txtColor(BuildContext context){
    return Theme.of(context).textTheme.bodyText1!.color!;
  }

  static Color bgColor(BuildContext context){
    return Theme.of(context).backgroundColor;
  }

  static Color cardColor(BuildContext context){
    return Theme.of(context).cardColor;
  }

  static Color dividerColor(BuildContext context){
    return Theme.of(context).dividerColor;
  }
}
