import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../models/noti/noti_model.dart';
import '../../../services/toast_service.dart';
import '../../auth/auth_logic/auth_repo.dart';
import 'noti_repo.dart';

class NotiController extends GetxController implements GetxService {
  final NotiRepo notiRepo;
  final AuthRepo authRepo;
  NotiController({required this.notiRepo, required this.authRepo});
  @override
  onInit() {
    checkToken();
    super.onInit();
  }

  checkToken() async {
    var token = await authRepo.getAppToken();
    if (token.isNotEmpty) {
      getNotiList();
    }
  }

  RxBool isLoading = false.obs;
  RxList<NotiData> notiList = <NotiData>[].obs;
  RxList<int> unReadNotiList = <int>[].obs;
  Future<void> getNotiList() async {
    isLoading.value = true;
    try {
      var response = await notiRepo.getNotifications();
      if (response.statusCode == 200) {
        NotiModel notiModel = NotiModel.fromJson(response.body);
        notiList.value = notiModel.data!;
        unReadNotiList.value = notiModel.data!
            .where((element) => element.read == 0)
            .map((e) => e.id!)
            .toList();
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getNotiDetail({required int id}) async {
    BotToast.showCustomLoading(
      toastBuilder: (_) => const CustomLoadingWidget(),
    );
    try {
      var response = await notiRepo.getNotificationDetail(id);
      if (response.statusCode == 200) {
        getNotiList();
      } else {
        BotToast.closeAllLoading();
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
