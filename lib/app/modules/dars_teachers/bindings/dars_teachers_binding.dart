import 'package:get/get.dart';

import '../controllers/dars_teachers_controller.dart';

class DarsTeachersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DarsTeachersController>(
      () => DarsTeachersController(),
    );
  }
}
