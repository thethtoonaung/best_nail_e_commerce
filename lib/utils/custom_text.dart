import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? size;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final bool? isEllip;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;

  const CustomText(
      {super.key,
      required this.text,
      this.textColor,
      this.size,
      this.textAlign,
      this.fontWeight,
      this.fontFamily,
      this.isEllip = true,
      this.maxLines,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(text ?? "",
          maxLines: maxLines ?? 1,
          style: TextStyle(
              fontFamily: fontFamily ?? "Roboto",
              color: textColor ?? Colors.black,
              fontSize: size ?? 16,
              overflow: isEllip == false
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              fontWeight: fontWeight ?? FontWeight.normal),
          textAlign: textAlign ?? TextAlign.start),
    );
  }
}
