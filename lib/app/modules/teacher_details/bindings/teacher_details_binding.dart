import 'package:get/get.dart';

import '../controllers/teacher_details_controller.dart';

class TeacherDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherDetailsController>(
      () => TeacherDetailsController(),
    );
  }
}
