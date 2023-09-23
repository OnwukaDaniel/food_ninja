import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../globals/app_constants.dart';
import '../globals/network_status.dart';
import '../util/app_color.dart';
import 'TextCustom.dart';

class NetworkResponder extends StatelessWidget {
  const NetworkResponder({
    Key? key,
    required this.filterDataVn,
    required this.success,
  }) : super(key: key);

  final ValueNotifier<int> filterDataVn;
  final Widget success;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: filterDataVn,
      builder: (_, int networkStatus, Widget? child) {
        if (networkStatus == NetworkStatus.NETWORK) {
          return success;
        } else if (networkStatus == NetworkStatus.CONNECTION) {
          return SpinKitSpinningCircle(
            color: AppColor.appColor,
            size: 100,
          );
        } else if (networkStatus == NetworkStatus.NO_NETWORK){
          return Center(
            child: TextCustom(
              padding: const EdgeInsets.all(16),
              text: "Poor Network connection",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
              ),
            ),
          );
        } else {
          return Center(
            child: TextCustom(
              padding: const EdgeInsets.all(32),
              text: "Please retry!!!",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
              ),
            ),
          );
        }
      },
    );
  }
}