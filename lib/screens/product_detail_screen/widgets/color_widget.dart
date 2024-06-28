import 'package:best_nail/utils/extension/color_ext.dart';
import 'package:flutter/material.dart';

import '../../../models/products/product_detail_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';

class ColorWidget extends StatelessWidget {
  final Variation variations;
  final int? selectedColorIndex;
  final List<String>? avaliableVariables;
  final void Function(int index) onSelectColor;
  final String selectedValue;

  const ColorWidget(
      {super.key,
      required this.variations,
      this.selectedColorIndex,
      this.avaliableVariables,
      required this.selectedValue,
      required this.onSelectColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: Dimesion.height10,
        ),
        Wrap(
          spacing: Dimesion.width5,
          children: List.generate(variations.values!.length, (index) {
            return InkWell(
              onTap: () => onSelectColor(index),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedColorIndex == index
                        ? AppColor.primaryClr
                        : Colors.transparent),
                child: CircleAvatar(
                  backgroundColor: variations.values![index].toColor(),
                  radius: Dimesion.radius15 / 1.2,
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: Dimesion.height10,
        ),
      ],
    );
  }
}

