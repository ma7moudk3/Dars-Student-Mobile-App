import 'package:get/get.dart';

class StaticPageController extends GetxController {
  String pageTitle =
      Get.arguments != null ? Get.arguments['pageTitle'] ?? "" : "";
  String pageSubTitle =
      Get.arguments != null ? Get.arguments['pageSubTitle'] ?? "" : "";
  @override
  void onClose() {}
}
