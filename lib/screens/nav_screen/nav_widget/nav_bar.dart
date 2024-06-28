// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'floationg_nav_item.dart';

typedef MyItemBuilder = Widget Function(
    BuildContext context, MyFloatingNavbarItem items);

class MyFloatingNavbar extends StatefulWidget {
  final List<MyFloatingNavbarItem>? items;
  final int? currentIndex;
  final void Function(int val)? onTap;
  final Color? selectedBackgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color? backgroundColor;
  final double? fontSize;
  final double? iconSize;
  final double? itemBorderRadius;
  final double? borderRadius;
  final MyItemBuilder? itemBuilder;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double width;
  final double? elevation;

  MyFloatingNavbar({
    Key? key,
    @required this.items,
    @required this.currentIndex,
    @required this.onTap,
    MyItemBuilder? itemBuilder,
    this.backgroundColor = Colors.black,
    this.selectedBackgroundColor = Colors.white,
    this.selectedItemColor = Colors.black,
    this.iconSize = 24.0,
    this.fontSize = 11.0,
    this.borderRadius = 8,
    this.itemBorderRadius = 8,
    this.unselectedItemColor = Colors.white,
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    this.padding = const EdgeInsets.only(bottom: 8, top: 8),
    this.width = double.infinity,
    this.elevation = 0.0,
  })  : assert(items!.length > 1),
        assert(items!.length <= 5),
        assert(currentIndex! <= items!.length),
        assert(width > 50),
        itemBuilder = _defaultItemBuilder(
          unselectedItemColor: unselectedItemColor,
          selectedItemColor: selectedItemColor,
          borderRadius: borderRadius,
          fontSize: fontSize,
          width: width,
          backgroundColor: backgroundColor,
          currentIndex: currentIndex,
          iconSize: iconSize,
          itemBorderRadius: itemBorderRadius,
          items: items,
          onTap: onTap,
          selectedBackgroundColor: selectedBackgroundColor,
        ),
        super(key: key);

  @override
  _MyFloatingNavbarState createState() => _MyFloatingNavbarState();
}

class _MyFloatingNavbarState extends State<MyFloatingNavbar> {
  List<MyFloatingNavbarItem> get items => widget.items!;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: widget.elevation,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          color: widget.backgroundColor,
        ),
        width: widget.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: items.map((f) {
              return widget.itemBuilder!(context, f);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

MyItemBuilder _defaultItemBuilder({
  Function(int val)? onTap,
  List<MyFloatingNavbarItem>? items,
  int? currentIndex,
  Color? selectedBackgroundColor,
  Color? selectedItemColor,
  Color? unselectedItemColor,
  Color? backgroundColor,
  double width = double.infinity,
  double? fontSize,
  double? iconSize,
  double? itemBorderRadius,
  double? borderRadius,
}) {
  return (BuildContext context, MyFloatingNavbarItem item) => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: currentIndex == items!.indexOf(item)
                      ? selectedBackgroundColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(itemBorderRadius!)),
              child: InkWell(
                onTap: () {
                  onTap!(items.indexOf(item));
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: width.isFinite
                      ? (width / items.length - 8)
                      : MediaQuery.of(context).size.width / items.length - 24,
                  padding: EdgeInsets.symmetric(
                      horizontal: 4, vertical: item.title != null ? 4 : 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      item.customWidget == null
                          ? Icon(
                              item.icon,
                              color: currentIndex == items.indexOf(item)
                                  ? selectedItemColor
                                  : unselectedItemColor,
                              size: iconSize,
                            )
                          : item.customWidget!,
                      if (item.title != null)
                        Text(
                          '${item.title}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: currentIndex == items.indexOf(item)
                                ? selectedItemColor
                                : unselectedItemColor,
                            fontSize: fontSize,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
