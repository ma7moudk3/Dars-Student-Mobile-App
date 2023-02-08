import 'package:get/get.dart';

import '../../../core/helper_functions.dart';

class OrdersController extends GetxController {
  RxBool isInternetConnected = true.obs;

  Future checkInternet() async {
    await checkInternetConnection(timeout: 5).then((bool internetStatus) {
      isInternetConnected.value = internetStatus;
    });
  }

  @override
  void onInit() async {
    await checkInternet();
    super.onInit();
  }

  @override
  void onClose() {}
}
