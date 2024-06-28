import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';

import '../utils/dimesions.dart';

class MyTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool isPasswords;
  final IconData prefixIcon;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FormFieldValidator? fieldValidator;
  final void Function(String)? onChanged;
  final int? maxLine;
  const MyTextFieldWidget(
      {super.key,
      required this.controller,
      this.hintText,
      required this.isPasswords,
      required this.prefixIcon,
      required this.inputType,
      required this.inputAction,
      this.fieldValidator,
      this.maxLine,
      this.onChanged});

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  bool showPass = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimesion.height40,
        padding: EdgeInsets.only(left: Dimesion.width10),
        margin: EdgeInsets.symmetric(
            horizontal: Dimesion.width5, vertical: Dimesion.width5),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
        child: Row(
          children: [
            Icon(
              widget.prefixIcon,
              size: Dimesion.iconSize16,
            ),
            SizedBox(
              width: Dimesion.width10,
            ),
            Expanded(
              child: TextFormField(
                showCursor: true,
                cursorColor: Colors.black,
                textAlign: TextAlign.start,
                controller: widget.controller,
                obscureText: widget.isPasswords ? showPass : false,
                autocorrect: false,
                readOnly: false,
                style: context.labelMedium,
                onChanged: widget.onChanged,
                validator: widget.fieldValidator,
                minLines: widget.maxLine ?? 1,
                maxLines: widget.maxLine ?? 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorStyle:
                      const TextStyle(height: 0, color: Colors.transparent),
                  hintText: widget.hintText ?? "",
                  suffixIcon: widget.isPasswords
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                          child: Icon(showPass
                              ? Icons.visibility
                              : Icons.visibility_off))
                      : null,
                ),
              ),
            ),
          ],
        ));
  }
}
