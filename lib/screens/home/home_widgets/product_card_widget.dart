import 'package:flutter/material.dart';

import '../../../app_widgets/main_button.dart';
import '../../../app_widgets/my_cache_img.dart';
import '../../../audio_player/audio_player_screen.dart';
import '../../../models/products/product_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/data_constant.dart';
import '../../../utils/dimesions.dart';

class ProductCard extends StatelessWidget {
  final ProductData productData;
  final bool? removeBg;

  const ProductCard({
    super.key,
    required this.productData,
    this.removeBg = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: removeBg! ? null : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
      ),
      width: Dimesion.screeWidth * 0.5,
      height: Dimesion.screenHeight * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: MyCacheImg(
                url: productData.images!.isEmpty
                    ? ""
                    : productData.images!.first.image ?? "",
                boxfit: BoxFit.contain,
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
          ),
          SizedBox(
            height: Dimesion.width5,
          ),
          Row(
            children: [
              mainButton(
                  padding: EdgeInsets.all(Dimesion.width5),
                  elevation: 0,
                  height: Dimesion.height30,
                  color: AppColor.primaryClr,
                  title: Icon(
                    Icons.voice_chat,
                    color: Colors.white,
                    size: Dimesion.iconSize16 * 1.1,
                  ),
                  onTap: () => showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (_) => AudioPlayerScreen(
                            url: productData.voice?.voice ?? '',
                            images: productData.getImageList(),
                            title: productData.name ?? '',
                          )),
                  borderRadius: Dimesion.radius15 / 2,
                  width: Dimesion.width30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productData.name ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${DataConstant.priceFormat.format(productData.defaultPrice ?? 0)} Ks",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColor.primaryClr),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
