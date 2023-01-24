import 'dart:async';

import 'package:get/get.dart';

class LoginOrSignUpController extends GetxController {
  String loginBackgroundImage = "assets/images/login_background1.png";
  int count = 1;
  Timer? timer;

  @override
  void onInit() {
    timer = Timer.periodic( 
        const Duration(milliseconds: 2500), (Timer t) => setImage());
    super.onInit();
  }

  void setImage() {
    if (count < 3) {
      count++;
    } else {
      count = 1;
    }
    loginBackgroundImage = "assets/images/login_background$count.png";
    update();
  }

  @override
  void onClose() {}
}
