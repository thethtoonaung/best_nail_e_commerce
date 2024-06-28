import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimesions.dart';

class ApploadingWidget extends StatelessWidget {
  final Color? color;
  const ApploadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CupertinoActivityIndicator(
      color: color ?? Colors.black,
      radius: Dimesion.radius15 / 2,
      animating: true,
    ));
  }
}
