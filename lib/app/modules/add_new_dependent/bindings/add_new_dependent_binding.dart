import 'package:get/get.dart';

import '../controllers/add_new_dependent_controller.dart';

class AddNewDependentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewDependentController>(
      () => AddNewDependentController(),
    );
  }
}
