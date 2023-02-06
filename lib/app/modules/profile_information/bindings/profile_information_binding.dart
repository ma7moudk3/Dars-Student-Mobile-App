import 'package:get/get.dart';

import '../controllers/profile_information_controller.dart';

class ProfileInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileInformationController>(
      () => ProfileInformationController(),
    );
  }
}
