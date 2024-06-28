import 'package:best_nail/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import '../../../models/products/product_detail_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';

class SelectVariationWidget extends StatelessWidget {
  final Variation variations;
  final int selectedVIndex;
  final void Function(String index) onSelect;
  final String selectedValue;
  const SelectVariationWidget(
      {super.key,
      required this.variations,
      required this.selectedVIndex,
      required this.selectedValue,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          variations.name ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Card(
          color: AppColor.primaryClr.withOpacity(0.1),
          elevation: 0,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: Dimesion.width5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(selectedValue.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColor.primaryClr,
                            fontWeight: FontWeight.bold,
                          )),
                ),
                DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColor.primaryClr,
                  ),
                  iconSize: Dimesion.iconSize25,
                  elevation: 0,
                  items:
                      variations.values?.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  underline: Container(height: 0),
                  onChanged: (newValue) => onSelect(newValue ?? ""),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Dimesion.height10,
        ),
      ],
    );
  }
}
