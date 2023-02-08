import 'dart:async';

import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_profile_info/current_user_profile_info.dart';
import 'package:hessa_student/app/modules/verify_account/data/models/generate_otp_code/generate_otp_code.dart';
import 'package:hessa_student/app/modules/verify_account/data/repos/verify_account_repo.dart';
import 'package:hessa_student/app/modules/verify_otp/data/models/verify_otp_response/verify_otp_response.dart';
import 'package:hessa_student/global_presentation/global_widgets/custom_snack_bar.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../../login/data/models/current_user_info/current_user_info.dart';
import '../../verify_account/data/repos/verify_account_repo_implement.dart';

class VerifyOtpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController pinController;
  FocusNode pinFocusNode = FocusNode();
  late Timer _pinTimer;
  int start = 60;
  String? email;
  String? phoneNumber;
  final VerifyAccountRepo _verifyAccountRepo = VerifyAccountRepoImplement();
  GenerateOtpCode generateOtpCode = GenerateOtpCode();
  VerifyOtpResponse verifyOtpResponse = VerifyOtpResponse();
  CurrentUserInfo currentUserInfo =
      CacheHelper.instance.getCachedCurrentUserInfo() ?? CurrentUserInfo();
  CurrentUserProfileInfo currentUserProfileInfo =
      CacheHelper.instance.getCachedCurrentUserProfileInfo() ??
          CurrentUserProfileInfo();
  @override
  void onInit() {
    if (Get.arguments != null) {
      email = Get.arguments["email"] ?? "";
      phoneNumber = Get.arguments["phoneNumber"] ?? "";
    }
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
    if (value.length != 6) {
      return LocaleKeys.check_pin_code.tr;
    }
    return null;
  }

  Future verifyOTP() async {
    if (((email == null || email!.isEmpty) &&
            (phoneNumber == null || phoneNumber!.isEmpty)) ||
        pinController.text.isEmpty) {
      return;
    }
    showLoadingDialog();
    if (email != null && email!.isNotEmpty) {
      verifyOtpResponse = await _verifyAccountRepo.verifyOTP(
        emailAddress: email,
        otpCode: pinController.text,
      );
    }
    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      verifyOtpResponse = await _verifyAccountRepo.verifyOTP(
        phoneNumber: phoneNumber,
        otpCode: pinController.text,
      );
    }
    if (verifyOtpResponse.result != null &&
        verifyOtpResponse.result!.isValid == true) {
      CustomSnackBar.showCustomSnackBar(
        title: LocaleKeys.success.tr,
        message: verifyOtpResponse.result!.message ??
            LocaleKeys.verified_successfully.tr,
      );
      if (phoneNumber != null && phoneNumber!.isNotEmpty) {
        await CacheHelper.instance.setIsPhoneConfirmed(true);
      } else {
        await CacheHelper.instance.setIsEmailConfirmed(true);
      }
      if (CacheHelper.instance.getIsEmailConfirmed() &&
          CacheHelper.instance.getIsPhoneConfirmed()) {
        await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
      } else {
        await Get.offAllNamed(Routes.VERIFY_ACCOUNT);
      }
    } else if (verifyOtpResponse.result != null &&
        verifyOtpResponse.result!.isValid == false) {
      CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.something_went_wrong.tr,
          message: verifyOtpResponse.result!.message ?? "");
    }
  }

  Future resendOTP() async {
    if (email == null && phoneNumber == null) {
      return;
    }
    showLoadingDialog();
    if (email != null && email!.isNotEmpty) {
      generateOtpCode = await _verifyAccountRepo.sendOTP(
        emailAddress: email,
        isEmailChanged: currentUserProfileInfo.result!.emailAddress != null
            ? email != currentUserProfileInfo.result!.emailAddress!
            : false,
      );
    } else if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      generateOtpCode = await _verifyAccountRepo.sendOTP(
        phoneNumber: phoneNumber,
        isPhoneChanged: currentUserProfileInfo.result!.phoneNumber != null
            ? phoneNumber != currentUserProfileInfo.result!.phoneNumber!
            : false,
      );
    }
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    start = 60;
    startTimer();
    update();
  }

  @override
  void onClose() {}
}
