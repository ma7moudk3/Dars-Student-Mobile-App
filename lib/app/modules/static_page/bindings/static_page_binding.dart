import 'package:get/get.dart';

import '../controllers/static_page_controller.dart';

class StaticPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaticPageController>(
      () => StaticPageController(),
    );
  }
}
