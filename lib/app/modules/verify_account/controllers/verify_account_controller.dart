import 'dart:developer';

import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/verify_account/data/models/generate_otp_code/generate_otp_code.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_widgets/custom_snack_bar.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';

import '../../../../global_presentation/global_widgets/intl_phone_number_field/countries.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_field/phone_number.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../../edit_profile/data/repos/edit_profile_repo.dart';
import '../../edit_profile/data/repos/edit_profile_repo_implement.dart';
import '../../login/data/models/current_user_profile_info/current_user_profile_info.dart';
import '../data/repos/verify_account_repo.dart';
import '../data/repos/verify_account_repo_implement.dart';

class VerifyAccountController extends GetxController {
  late TextEditingController emailController, phoneNumberController;
  final EditProfileRepo _editProfileRepo = EditProfileRepoImplement();
  CurrentUserInfo currentUserInfo =
      CacheHelper.instance.getCachedCurrentUserInfo() ?? CurrentUserInfo();
  CurrentUserProfileInfo currentUserProfileInfo =
      CacheHelper.instance.getCachedCurrentUserProfileInfo() ??
          CurrentUserProfileInfo();
  RxBool isEmailConfirmed = false.obs, isPhoneNumberConfirmed = false.obs;
  FocusNode emailFocusNode = FocusNode(), phoneNumberFocusNode = FocusNode();
  final VerifyAccountRepo _verifyAccountRepo = VerifyAccountRepoImplement();
  GenerateOtpCode generateOtpCode = GenerateOtpCode();
  PhoneNumber phoneNumber =
      PhoneNumber(countryISOCode: "", countryCode: "", number: "");
  final GlobalKey<FormState> emailForm = GlobalKey(), phoneForm = GlobalKey();
  String? dialCode, countryCode;
  bool isValidPhoneNumber = false;
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
    String pattern = r'(^\+(970|972)(59|56)\d{7}$)';
    RegExp regExp = RegExp(pattern);
    if (phoneNumber.isEmpty) {
      isValidPhoneNumber = false;
      update();
      return '';
    } else if (!regExp.hasMatch(phoneNumber)) {
      isValidPhoneNumber = false;
      update();
      return "";
    }
    isValidPhoneNumber = true;
    update();
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
      validatePhoneNumber(phoneNumber.completeNumber);
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

  Future<int> _updateProfileData({String? email, String? phoneNumber}) async {
    int statusCode = 500;
    if (currentUserProfileInfo.result != null &&
        currentUserProfileInfo.result!.requester != null) {
      statusCode = await _editProfileRepo.updateProfile(
        email: email,
        phoneNumber: phoneNumber,
        id: currentUserProfileInfo.result!.requester!.userId ?? -1,
      );
    }
    return statusCode;
  }

  Future sendOTPEmail() async {
    if (emailController.text.isNotEmpty) {
      if (currentUserProfileInfo.result != null
          ? currentUserProfileInfo.result!.emailAddress != null
              ? emailController.text !=
                  currentUserProfileInfo.result!.emailAddress!
              : false
          : false) {
        await _updateProfileData(phoneNumber: phoneNumber.completeNumber)
            .then((int statusCode) async {
          if (statusCode == 200) {
            await _sendOTP(email: emailController.text);
          } else {
            CustomSnackBar.showCustomErrorSnackBar(
              title: LocaleKeys.error,
              message: LocaleKeys.something_went_wrong.tr,
            );
          }
        });
      } else {
        await _sendOTP(email: emailController.text);
      }
    }
  }

  Future sendOTPPhoneNumber() async {
    if (phoneNumber.completeNumber.isNotEmpty) {
      if (currentUserProfileInfo.result != null
          ? currentUserProfileInfo.result!.phoneNumber != null
              ? phoneNumber.completeNumber !=
                  currentUserProfileInfo.result!.phoneNumber!
              : false
          : false) {
        await _updateProfileData(phoneNumber: phoneNumber.completeNumber)
            .then((int statusCode) async {
          if (statusCode == 200) {
            await _sendOTP(
              phoneNumber: phoneNumber.completeNumber,
            );
          } else {
            CustomSnackBar.showCustomErrorSnackBar(
              title: LocaleKeys.error,
              message: LocaleKeys.something_went_wrong.tr,
            );
          }
        });
      } else {
        await _sendOTP(
          phoneNumber: phoneNumber.completeNumber,
        );
      }
    }
  }

  Future _sendOTP({String? phoneNumber, String? email}) async {
    showLoadingDialog();
    if (phoneNumber == null && email == null) {
      return;
    }
    if (phoneNumber != null) {
      generateOtpCode = await _verifyAccountRepo.sendOTP(
        phoneNumber: phoneNumber,
        isPhoneChanged: currentUserProfileInfo.result != null
            ? currentUserProfileInfo.result!.phoneNumber != null
                ? phoneNumber != currentUserProfileInfo.result!.phoneNumber!
                : false
            : false,
      );
      if (generateOtpCode.result != null &&
          generateOtpCode.result!.numberOfSeconds != null) {
        await Get.toNamed(Routes.VERIFY_OTP, arguments: {
          "phoneNumber": phoneNumber,
          "numberOfSeconds": generateOtpCode.result!.numberOfSeconds!,
          "isPhoneChanged": currentUserProfileInfo.result != null
              ? currentUserProfileInfo.result!.phoneNumber != null
                  ? phoneNumber != currentUserProfileInfo.result!.phoneNumber!
                  : false
              : false,
        });
      }
    }
    if (email != null) {
      generateOtpCode = await _verifyAccountRepo.sendOTP(
        emailAddress: email,
        isEmailChanged: currentUserProfileInfo.result != null
            ? currentUserProfileInfo.result!.emailAddress != null
                ? email != currentUserProfileInfo.result!.emailAddress!
                : false
            : false,
      );
      if (generateOtpCode.result != null &&
          generateOtpCode.result!.numberOfSeconds != null) {
        await Get.toNamed(Routes.VERIFY_OTP, arguments: {
          "email": email,
          "numberOfSeconds": generateOtpCode.result!.numberOfSeconds!,
          "isEmailChanged": currentUserProfileInfo.result != null
              ? currentUserProfileInfo.result!.emailAddress != null
                  ? email != currentUserProfileInfo.result!.emailAddress!
                  : false
              : false,
        });
      }
    }
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
