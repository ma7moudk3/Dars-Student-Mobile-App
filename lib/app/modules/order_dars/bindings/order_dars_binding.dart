import 'package:get/get.dart';

import '../controllers/order_dars_controller.dart';

class OrderDarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDarsController>(
      () => OrderDarsController(),
    );
  }
}