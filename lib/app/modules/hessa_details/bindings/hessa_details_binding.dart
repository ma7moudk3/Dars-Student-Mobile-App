import 'package:get/get.dart';

import '../controllers/hessa_details_controller.dart';

class HessaDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HessaDetailsController>(
      () => HessaDetailsController(),
    );
  }
}
