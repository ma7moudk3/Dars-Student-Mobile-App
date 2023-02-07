import 'dart:developer';

import 'package:hessa_student/app/modules/login/data/repos/login_repo.dart';
import 'package:hessa_student/global_presentation/global_widgets/custom_snack_bar.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../constants/exports.dart';
import '../../../data/cache_helper.dart';
import '../../../routes/app_pages.dart';
import '../../login/data/models/current_user_info/current_user_info.dart';
import '../../login/data/models/current_user_profile_info/current_user_profile_info.dart';
import '../../login/data/repos/login_repo_implement.dart';
import '../data/repos/sign_up_repo.dart';
import '../data/repos/sign_up_repo_implement.dart';

class SignUpController extends GetxController {
  late TextEditingController fullNameController,
      emailController,
      passwordController,
      confimationPasswordController,
      phoneController;
  FocusNode fullNameFocusNode = FocusNode(),
      emailFocusNode = FocusNode(),
      passwordFocusNode = FocusNode(),
      confimationPasswordFocusNode = FocusNode(),
      phoneFocusNode = FocusNode();
  final SignUpRepo _signUpRepo = SignUpRepoImplement();
  Color? fullNameErrorIconColor,
      emailErrorIconColor,
      passwordErrorIconColor,
      confimationPasswordErrorIconColor;
  bool tosIsAgreed = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  final LoginRepo _loginRepo = LoginRepoImplement();
  int gender = 0; // 0 male , 1 female
  String? phoneNumber;
  void changeGender(int genderValue) {
    gender = genderValue;
    update();
  }

  void changePhoneNumber(PhoneNumber number) {
    phoneNumber = number.completeNumber.toString();
    update();
  }

  @override
  void onInit() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confimationPasswordController = TextEditingController();
    phoneController = TextEditingController();
    fullNameFocusNode.addListener(() => update());
    emailFocusNode.addListener(() => update());
    passwordFocusNode.addListener(() => update());
    confimationPasswordFocusNode.addListener(() => update());
    phoneFocusNode.addListener(() => update());
    super.onInit();
  }

  Future<int?> register() async {
    int? statusCode;
    await _signUpRepo
        .register(
      emailAddress: emailController.text,
      captchaResponse: "",
      fullName: fullNameController.text,
      password: passwordController.text,
      gender: gender.toString(),
      phoneNumber: phoneNumber ?? "",
    )
        .then((int? statusCode) async {
      statusCode = statusCode;
      if (statusCode != null && statusCode == 200) {
        await _loginRepo
            .login(
          login: emailController.text,
          password: passwordController.text,
        )
            .then((value) async {
          Future.wait([_getCurrentUserInfo(), _getCurrentUserProfileInfo()])
              .then((value) async {
            CurrentUserInfo currentUserInfo =
                CacheHelper.instance.getCachedCurrentUserInfo() ??
                    CurrentUserInfo();
            bool isEmailConfirmed = currentUserInfo.result != null
                ? currentUserInfo.result!.isEmailConfirmed ?? false
                : false;
            bool isPhoneConfirmed = currentUserInfo.result != null
                ? currentUserInfo.result!.isPhoneNumberConfirmed ?? false
                : false;
            log("isEmailConfirmed? $isEmailConfirmed");
            log("isPhoneConfirmed? $isPhoneConfirmed");
            Future.wait([
              CacheHelper.instance.setIsEmailConfirmed(
                  currentUserInfo.result!.isEmailConfirmed ?? false),
              CacheHelper.instance.setIsPhoneConfirmed(
                  currentUserInfo.result!.isPhoneNumberConfirmed ?? false)
            ]).then((value) async {
              await Get.offAllNamed(Routes.VERIFY_ACCOUNT);
            });
          });
        });
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: LocaleKeys.something_went_wrong.tr);
      }
    });
    return statusCode;
  }

  Future _getCurrentUserInfo() async {
    // information like: isProfileCompleted, isExternalUser (google or facecbook), isEmailConfirmed, isPhoneNumberConfirmed
    showLoadingDialog();
    await _loginRepo
        .getCurrentUserInfo()
        .then((CurrentUserInfo currentUserInfo) async {
      await CacheHelper.instance.cacheCurrentUserInfo(currentUserInfo.toJson());
    });
  }

  Future _getCurrentUserProfileInfo() async {
    // information like: userName, emailAddress, paymentMethodName, phoneNumber, addresses
    showLoadingDialog();
    await _loginRepo
        .getCurrentUserProfileInfo()
        .then((CurrentUserProfileInfo currentUserProfileInfo) async {
      await CacheHelper.instance
          .cacheCurrentUserProfileInfo(currentUserProfileInfo.toJson());
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confimationPasswordController.dispose();
    phoneController.dispose();
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confimationPasswordFocusNode.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  void toggleTermsOfUse({bool? isAgreed}) {
    tosIsAgreed = isAgreed ?? !tosIsAgreed;
    update();
  }

  String? validateFullName(String? fullName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (fullName == null || fullName.isEmpty) {
      fullNameErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_fullname.tr;
    } else if (!regExp.hasMatch(fullName)) {
      if (!fullName.contains(" ")) {
        fullNameErrorIconColor = Colors.red;
        update();
        return LocaleKeys.should_have_space.tr;
      } else {
        fullNameErrorIconColor = null;
        update();
        return null;
      }
    } else if (regExp.hasMatch(fullName)) {
      fullNameErrorIconColor = Colors.red;
      update();
      return LocaleKeys.check_your_full_name.tr;
    } else {
      fullNameErrorIconColor = null;
    }
    update();
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      emailErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_email.tr;
    } else if (email.isEmail == false) {
      emailErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_valid_email.tr;
    } else {
      emailErrorIconColor = null;
    }
    update();
    return null;
  }

  String? validatePassword(String? passwordFieldValue) {
    if (passwordFieldValue == null || passwordFieldValue.isEmpty) {
      passwordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_password.tr;
    } else if (passwordFieldValue.length < 6) {
      passwordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.password_must_be_at_least_6_characters.tr;
    } else {
      passwordErrorIconColor = null;
    }
    update();
    return null;
  }

  String? validateConfirmPassword(String? confirmPasswordFieldValue) {
    if (confirmPasswordFieldValue == null ||
        confirmPasswordFieldValue.isEmpty) {
      confimationPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_confirm_password.tr;
    } else if (confirmPasswordFieldValue != passwordController.text) {
      confimationPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.check_confirm_password.tr;
    } else {
      confimationPasswordErrorIconColor = null;
    }
    update();
    return null;
  }

  @override
  void onClose() {}
}
