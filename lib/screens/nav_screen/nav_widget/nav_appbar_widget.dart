import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final void Function() ontap;
  final int index;
  final String title;
  final String token;
  final void Function() logout;
  final void Function() ontapBook;
  const MyAppBar(
      {super.key,
      required this.ontap,
      required this.index,
      required this.title,
      required this.logout,
      required this.ontapBook,
      required this.token});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: index == 0 ? true : false,
      // leading: index == 0
      //     ? Container(
      //         margin: EdgeInsets.all(Dimesion.width5),
      //         child: Image.asset("assets/images/logo.png"))
      //     : null,
      // title: Text(
      //   title,
      //   style: MyTextStyle.subtitle,
      // ),
    );
  }
}
