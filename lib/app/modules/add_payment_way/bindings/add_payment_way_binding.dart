import 'package:get/get.dart';

import '../controllers/add_payment_way_controller.dart';

class AddPaymentWayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPaymentWayController>(
      () => AddPaymentWayController(),
    );
  }
}
