import 'dart:async';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class VerifyOtpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController pinController;
  FocusNode pinFocusNode = FocusNode();
  late Timer _pinTimer;
  int start = 60;

  @override
  void onInit() {
    pinController = TextEditingController();
    pinFocusNode.addListener(() => update);
    startTimer();
    super.onInit();
  }

  void startTimer() {
    _pinTimer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          update();
        } else {
          start--;
          update();
        }
      },
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    _pinTimer.cancel();
    super.dispose();
  }

  String? validatePIN(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.please_enter_the_verification_code.tr;
    }
    if (value.length != 4) {
      return LocaleKeys.check_pin_code.tr;
    }
    return null;
  }

  void resendOTP() {
    start = 60;
    startTimer();
    update();
  }

  @override
  void onClose() {}
}
