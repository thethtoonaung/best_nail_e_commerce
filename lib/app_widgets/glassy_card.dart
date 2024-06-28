import 'package:flutter/material.dart';

import '../utils/dimesions.dart';

class GlassyCard extends StatelessWidget {
  final Widget child;
  const GlassyCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        borderOnForeground: true,
        shadowColor: Colors.black,
        child: child);
  }
}

class GlassyCardVoid extends StatelessWidget {
  final Widget child;
  const GlassyCardVoid({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimesion.radius15 / 2),
                bottomRight: Radius.circular(Dimesion.radius15 / 2))),
        color: Colors.white.withOpacity(0.6),
        elevation: 0,
        borderOnForeground: true,
        margin: EdgeInsets.zero,
        shadowColor: Colors.white.withOpacity(0.4),
        child: child);
  }
}
