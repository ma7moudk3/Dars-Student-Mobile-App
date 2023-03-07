import 'package:get/get.dart';

import '../controllers/dars_details_controller.dart';

class DarsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DarsDetailsController>(
      () => DarsDetailsController(),
    );
  }
}
