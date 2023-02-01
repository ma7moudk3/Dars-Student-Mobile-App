import 'package:get/get.dart';

import '../controllers/about_hessa_controller.dart';

class AboutHessaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutHessaController>(
      () => AboutHessaController(),
    );
  }
}
