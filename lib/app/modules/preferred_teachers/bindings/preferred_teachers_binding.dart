import 'package:get/get.dart';

import '../controllers/preferred_teachers_controller.dart';

class PreferredTeachersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreferredTeachersController>(
      () => PreferredTeachersController(),
    );
  }
}
