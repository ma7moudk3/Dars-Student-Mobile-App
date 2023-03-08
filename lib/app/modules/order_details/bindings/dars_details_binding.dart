import 'package:get/get.dart';

import '../controllers/order_details_controller.dart';

class DarsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsController>(
      () => OrderDetailsController(),
    );
  }
}
