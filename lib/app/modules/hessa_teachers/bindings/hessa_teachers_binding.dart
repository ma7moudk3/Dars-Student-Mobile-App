import 'package:get/get.dart';

import '../controllers/hessa_teachers_controller.dart';

class HessaTeachersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HessaTeachersController>(
      () => HessaTeachersController(),
    );
  }
}
