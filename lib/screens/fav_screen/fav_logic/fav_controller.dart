import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../models/products/fav_model.dart';
import '../../../services/toast_service.dart';
import 'fav_repo.dart';

class FavController extends GetxController {
  final FavRepo favRepo;

  FavController({
    required this.favRepo,
  });

  RxList<FavData> favList = <FavData>[].obs;

  Future<void> getFavList() async {
    var loading = BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) => const CustomLoadingWidget(),
    );
    try {
      var response = await favRepo.getFavList();
      if (response.statusCode == 200) {
        var data = FavModel.fromJson(response.body);
        favList.assignAll(data.data!);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      loading();
    }
  }

  Future<bool> addFav({required int productId}) async {
    bool result = false;
    var loading = BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    try {
      var response = await favRepo.addFav(productId: productId);
      if (response.statusCode == 201) {
        result = true;
        ToastService.successToast(response.body["message"]);
      } else {
        result = false;
        ToastService.errorToast("${response.body["message"]}");
      }
    } catch (e) {
      result = false;
      ToastService.errorToast(e.toString());
    } finally {
      loading();
    }
    return result;
  }

  Future<bool> removeFav({required int productId}) async {
    bool result = false;
    var loading = BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    try {
      var response = await favRepo.deleteFav(favId: productId);
      if (response.statusCode == 200) {
        result = true;
        ToastService.successToast(response.body["message"]);
      } else {
        result = false;
        ToastService.errorToast("${response.body["message"]}");
      }
    } catch (e) {
      result = false;
      ToastService.errorToast(e.toString());
    } finally {
      loading();
    }
    return result;
  }
}
