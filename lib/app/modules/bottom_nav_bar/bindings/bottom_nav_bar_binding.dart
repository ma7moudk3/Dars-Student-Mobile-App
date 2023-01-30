import 'package:get/get.dart';
import 'package:hessa_student/app/modules/home/controllers/home_controller.dart';
import 'package:hessa_student/app/modules/messages/controllers/messages_controller.dart';
import 'package:hessa_student/app/modules/orders/controllers/orders_controller.dart';

import '../../profile/controllers/profile_controller.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BottomNavBarController>(
      BottomNavBarController(),
    );
    Get.put<HomeController>(
      HomeController(),
    );
    Get.put<OrdersController>(
      OrdersController(),
    );
    Get.put<MessagesController>(
      MessagesController(),
    );
    Get.put<ProfileController>(
      ProfileController(),
    );
  }
}
