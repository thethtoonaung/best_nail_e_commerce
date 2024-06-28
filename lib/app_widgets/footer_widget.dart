import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../utils/dimesions.dart';

Widget footer({required bool canLoadMore}) {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.loading) {
        body = const CupertinoActivityIndicator(
          color: Colors.black,
        );
      } else if (mode == LoadStatus.failed) {
        body = Text("Load Failed!Click retry!",
            style: context.labelMedium.copyWith(fontWeight: FontWeight.bold));
      } else if (mode == LoadStatus.canLoading) {
        body = Text(
          "release to load more",
          style: context.labelMedium.copyWith(fontWeight: FontWeight.bold),
        );
      } else if (canLoadMore == false) {
        body = Text(
          "No more Data",
          style: context.labelMedium.copyWith(fontWeight: FontWeight.bold),
        );
      } else {
        body = Text(
          "",
          style: context.labelMedium.copyWith(fontWeight: FontWeight.bold),
        );
      }
      return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(bottom: Dimesion.height40 * 2),
        height: Dimesion.height40 * 1.2,
        child: body,
      );
    },
  );
}
