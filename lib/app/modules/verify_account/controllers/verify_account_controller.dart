import 'dart:developer';

import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/verify_account/data/models/generate_otp_code/generate_otp_code.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../../login/data/models/current_user_profile_info/current_user_profile_info.dart';
import '../data/repos/verify_account_repo.dart';
import '../data/repos/verify_account_repo_implement.dart';

class VerifyAccountController extends GetxController {
  late TextEditingController emailController, phoneNumberController;

  CurrentUserInfo currentUserInfo =
      CacheHelper.instance.getCachedCurrentUserInfo() ?? CurrentUserInfo();
  CurrentUserProfileInfo currentUserProfileInfo =
      CacheHelper.instance.getCachedCurrentUserProfileInfo() ??
          CurrentUserProfileInfo();
  RxBool isEmailConfirmed = false.obs;
  RxBool isPhoneNumberConfirmed = false.obs;
  FocusNode emailFocusNode = FocusNode(), phoneNumberFocusNode = FocusNode();
  final VerifyAccountRepo _verifyAccountRepo = VerifyAccountRepoImplement();
  GenerateOtpCode generateOtpCode = GenerateOtpCode();
  PhoneNumber phoneNumber =
      PhoneNumber(countryISOCode: "", countryCode: "", number: "");
  final GlobalKey<FormState> emailForm = GlobalKey(), phoneForm = GlobalKey();
  String? dialCode, countryCode;

  @override
  void onInit() {
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    initData();
    emailFocusNode.addListener(() => update());
    phoneNumberFocusNode.addListener(() => update());
    super.onInit();
  }

  void changePhoneNumber(PhoneNumber number) {
    phoneNumber = number;
    log(phoneNumber.toString());
    update();
  }

  String? validatePhoneNumber(String phoneNumber) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (phoneNumber.isEmpty) {
      return '';
    } else if (!regExp.hasMatch(phoneNumber)) {
      return "";
    }
    return null;
  }

  void changeCountry(Country country) {
    phoneNumber.countryCode = "+${country.dialCode}";
    update();
  }

  void initData() {
    isEmailConfirmed.value = CacheHelper.instance.getIsEmailConfirmed();
    isPhoneNumberConfirmed.value = CacheHelper.instance.getIsPhoneConfirmed();
    if (currentUserInfo.result != null &&
        currentUserInfo.result!.emailAddress != null) {
      emailController.text = currentUserInfo.result!.emailAddress!;
    }
    if (currentUserProfileInfo.result != null &&
        currentUserProfileInfo.result!.phoneNumber != null) {
      _seperatePhoneAndDialCode(
          phoneWithDialCode: currentUserProfileInfo.result!.phoneNumber!);
    }
  }

  void _seperatePhoneAndDialCode({required String phoneWithDialCode}) {
    List<Map<String, String>> allowedCountries = [
      {"name": "Palestine", "dial_code": "+970", "code": "PS"},
      {"name": "Israel", "dial_code": "+972", "code": "IL"},
    ];
    Map<String, String> foundCountry = {};
    for (Map<String, String> country in allowedCountries) {
      String dialCode = country["dial_code"].toString();
      if (phoneWithDialCode.contains(dialCode)) {
        foundCountry = country;
        break;
      }
    }
    if (foundCountry.isNotEmpty) {
      String dialCode = phoneWithDialCode.substring(
        0,
        foundCountry["dial_code"]!.length,
      );
      this.dialCode = dialCode;
      countryCode = foundCountry["code"];
      String phoneNumber = phoneWithDialCode.substring(
        foundCountry["dial_code"]!.length,
      );
      log("Dial Code: $dialCode");
      log("Phone Number: $phoneNumber");
      phoneNumberController.text = phoneNumber;
      this.phoneNumber = PhoneNumber(
          countryISOCode: dialCode, countryCode: dialCode, number: phoneNumber);
      log("Complete Number: ${this.phoneNumber.completeNumber}");
    }
    update();
  }

  Future sendOTPEmail() async {
    if (emailController.text.isNotEmpty) {
      // log(emailController.text);
      // log(currentUserProfileInfo.result!.emailAddress ?? "no email");
      // log((currentUserProfileInfo.result!.emailAddress != null
      //         ? emailController.text !=
      //             currentUserProfileInfo.result!.emailAddress!
      //         : false)
      //     .toString());
      await sendOTP(email: emailController.text);
    }
  }

  Future sendOTPPhoneNumber() async {
    if (phoneNumber.completeNumber.isNotEmpty) {
      // log(phoneNumber.completeNumber);
      // log(currentUserProfileInfo.result!.phoneNumber ?? "no phone1");
      // log((currentUserProfileInfo.result!.phoneNumber != null
      //         ? phoneNumber.completeNumber !=
      //             currentUserProfileInfo.result!.phoneNumber!
      //         : false)
      //     .toString());
      await sendOTP(
        phoneNumber: phoneNumber.completeNumber,
      );
    }
  }

  Future sendOTP({String? phoneNumber, String? email}) async {
    showLoadingDialog();
    if (phoneNumber == null && email == null) {
      return;
    }
    if (phoneNumber != null) {
      generateOtpCode = await _verifyAccountRepo.sendOTP(
        phoneNumber: phoneNumber,
        isPhoneChanged: currentUserProfileInfo.result!.phoneNumber != null
            ? phoneNumber != currentUserProfileInfo.result!.phoneNumber!
            : false,
      );
      await Get.toNamed(Routes.VERIFY_OTP, arguments: {
        "phoneNumber": phoneNumber,
      });
    }
    if (email != null) {
      generateOtpCode = await _verifyAccountRepo.sendOTP(
        emailAddress: email,
        isEmailChanged: currentUserProfileInfo.result!.emailAddress != null
            ? email != currentUserProfileInfo.result!.emailAddress!
            : false,
      );
      if (generateOtpCode.result != null &&
          generateOtpCode.result!.numberOfSeconds != null) {
        await Get.toNamed(Routes.VERIFY_OTP, arguments: {
          "email": email,
        });
      }
    }
  }

  Future logout() async {
    showLoadingDialog();
    await _verifyAccountRepo.logout().then((int statusCode) async {
      if (statusCode == 200) {
        await CacheHelper.instance.setAccessToken("");
        await CacheHelper.instance.setRefreshToken("");
        await CacheHelper.instance.cacheCurrentUserInfo(null);
        await CacheHelper.instance.cacheCurrentUserProfileInfo(null);
        await CacheHelper.instance.setAuthed(false);
        await CacheHelper.instance.setIsEmailConfirmed(false);
        await CacheHelper.instance.setIsPhoneConfirmed(false);
        if (Get.isDialogOpen!) {
          Get.back();
        }
        await Get.offAllNamed(Routes.LOGIN_OR_SIGN_UP, arguments: {
          "isFromOnboarding": false,
        });
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.error.tr,
          message: LocaleKeys.something_went_wrong.tr,
        );
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneNumberController.dispose();
    emailFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
