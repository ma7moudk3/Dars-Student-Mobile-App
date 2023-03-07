import 'package:get/get.dart';

import '../controllers/about_dars_controller.dart';

class AboutDarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutDarsController>(
      () => AboutDarsController(),
    );
  }
}
