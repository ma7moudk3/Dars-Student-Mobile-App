import 'package:get/get.dart';

import '../controllers/login_or_sign_up_controller.dart';

class LoginOrSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginOrSignUpController>(
      () => LoginOrSignUpController(),
    );
  }
}
