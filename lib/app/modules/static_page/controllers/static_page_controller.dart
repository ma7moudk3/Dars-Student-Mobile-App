import 'package:get/get.dart';

class StaticPageController extends GetxController {
  String pageTitle =
      Get.arguments != null ? Get.arguments['pageTitle'] ?? "" : "";
  @override
  void onClose() {}
}
