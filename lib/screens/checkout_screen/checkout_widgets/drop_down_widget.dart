import 'package:flutter/material.dart';
import '../../../models/check_out/region_model.dart';
import '../../../models/check_out/town_ship_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';

class DropDownWidget extends StatelessWidget {
  final String title;
  final String hint;
  final List<TownShipData>? townshipList;
  final List<RegionData>? regionList;
  final Function(RegionData?)? onChangedRegion;
  final Function(TownShipData?)? onChangedTownship;
  final void Function()? onTapTownShip;

  const DropDownWidget(
      {super.key,
      required this.title,
      required this.hint,
      this.regionList,
      this.townshipList,
      this.onTapTownShip,
      this.onChangedRegion,
      this.onChangedTownship});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: Dimesion.width5,
      ),
      Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!,
      ),
      Container(
        margin: EdgeInsets.only(top: Dimesion.width5),
        decoration: BoxDecoration(
            color: AppColor.primaryClr.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimesion.radius15)),
        padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
        child: townshipList == null
            ? DropdownButtonFormField(
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColor.primaryClr,
                ),
                menuMaxHeight: Dimesion.screenHeight * 0.3,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor.primaryClr)),
                items: regionList!
                    .map((e) => DropdownMenuItem<RegionData>(
                          value: e,
                          child: Text(e.name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.primaryClr)),
                        ))
                    .toList(),
                onChanged: onChangedRegion)
            : DropdownButtonFormField(
                menuMaxHeight: Dimesion.screenHeight * 0.3,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColor.primaryClr,
                ),
                onTap: onTapTownShip,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor.primaryClr)),
                items: townshipList!
                    .map((e) => DropdownMenuItem<TownShipData>(
                          value: e,
                          child: Text(e.name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.primaryClr)),
                        ))
                    .toList(),
                onChanged: onChangedTownship),
      ),
    ]);
  }
}
