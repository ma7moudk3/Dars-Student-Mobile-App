import 'package:get/get.dart';

import '../controllers/edit_dependent_controller.dart';

class EditDependentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditDependentController>(
      () => EditDependentController(),
    );
  }
}
