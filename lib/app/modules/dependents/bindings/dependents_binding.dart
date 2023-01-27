import 'package:get/get.dart';

import '../controllers/dependents_controller.dart';

class DependentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DependentsController>(
      () => DependentsController(),
    );
  }
}
