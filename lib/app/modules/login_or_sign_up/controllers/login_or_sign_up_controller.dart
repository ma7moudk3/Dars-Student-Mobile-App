import 'dart:async';

import 'package:get/get.dart';

class LoginOrSignUpController extends GetxController {
  String loginBackgroundImage =
      "assets/images/login_or_sign_up_background1.png";
  int count = 1;
  int numberOfLoginBackgroundImages = 3;
  // login_or_sign_up_background1.png
  // login_or_sign_up_background2.png
  // login_or_sign_up_background3.png
  Timer? timer;

  @override
  void onInit() {
    timer = Timer.periodic(
        const Duration(milliseconds: 2500), (Timer t) => setImage());
    super.onInit();
  }

  void setImage() {
    if (count < numberOfLoginBackgroundImages) {
      count++;
    } else {
      count = 1;
    }
    loginBackgroundImage =
        "assets/images/login_or_sign_up_background$count.png";
    update();
  }

  @override
  void onClose() {}
}
