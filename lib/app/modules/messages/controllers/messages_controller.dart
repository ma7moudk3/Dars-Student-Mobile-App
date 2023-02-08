import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';

class MessagesController extends GetxController {
  int length = 10;
  RxBool isInternetConnected = true.obs;
  void deleteMessage() {
    length--;
    update();
  }

  @override
  void onInit() async {
    await checkInternet();
    super.onInit();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 5).then((bool internetStatus) {
      isInternetConnected.value = internetStatus;
    });
  }

  @override
  void onClose() {}
}
