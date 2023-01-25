import 'package:get/get.dart';

import '../controllers/connection_failed_controller.dart';

class ConnectionFailedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionFailedController>(
      () => ConnectionFailedController(),
    );
  }
}
