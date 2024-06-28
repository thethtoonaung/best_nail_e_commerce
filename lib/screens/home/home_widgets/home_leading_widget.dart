import 'package:flutter/material.dart';

import '../../../app_widgets/column_text.dart';
import '../../../utils/app_config.dart';
import '../../../utils/dimesions.dart';

class HomeLeadingWidget extends StatelessWidget {
  const HomeLeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimesion.width5, top: Dimesion.width5),
      child: ColumnText(title: AppConfig.appName, val: AppConfig.appTagLine),
    );
  }
}
