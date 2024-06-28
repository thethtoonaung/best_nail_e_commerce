import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_widgets/empty_view_widget.dart';
import '../../routes_helper/routes_helper.dart';
import '../../utils/dimesions.dart';
import '../home/home_widgets/product_card_widget.dart';
import '../product_detail_screen/product_detail_screen.dart';
import 'fav_logic/fav_controller.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final FavController favController = Get.find<FavController>();
  @override
  void initState() {
    favController.getFavList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Whishlist",
          style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: Obx(() {
        if (favController.favList.isEmpty) {
          return EmptyViewWidget(
            refresh: () => favController.getFavList(),
          );
        } else {
          return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: Dimesion.width5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Dimesion.width5,
                  mainAxisSpacing: Dimesion.width5),
              itemCount: favController.favList.length,
              itemBuilder: (context, index) => InkWell(
                    onTap: () => Get.toNamed(RouteHelper.productDetailScreen,
                        arguments: ProductDetailScreen(
                          id: favController.favList[index].product!.id!,
                        )),
                    child: ProductCard(
                      productData: favController.favList[index].product!,
                    ),
                  ));
        }
      }),
    );
  }
}
