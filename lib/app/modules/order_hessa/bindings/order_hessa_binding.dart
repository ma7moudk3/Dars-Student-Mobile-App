import 'package:get/get.dart';

import '../controllers/order_hessa_controller.dart';

class OrderHessaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderHessaController>(
      () => OrderHessaController(),
    );
  }
}
