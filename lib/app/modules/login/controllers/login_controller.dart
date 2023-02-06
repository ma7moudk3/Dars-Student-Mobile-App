import 'dart:developer';

import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../constants/exports.dart';
import '../../../data/cache_helper.dart';
import '../../../routes/app_pages.dart';
import '../data/repos/login_repo_implement.dart';
import '../widgets/welcome_back_dialog_content.dart';

class LoginController extends GetxController {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  late TextEditingController emailController, passwordController;
  Color? emailErrorIconColor, passwordErrorIconColor;
  final GlobalKey<FormState> formKey = GlobalKey();
  final LoginRepo _loginRepo = LoginRepoImplement();
  CurrentUserInfo? currentUserInfo;
  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode.addListener(() => update());
    passwordFocusNode.addListener(() => update());
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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

  Future login() async {
    try {
      showLoadingDialog();
      await _loginRepo
          .login(
        login: emailController.text,
        password: passwordController.text,
      )
          .then((int statusCode) async {
        if (statusCode == 200) {
          Future.wait([_getCurrentUserInfo()]).then((value) async {
            if (currentUserInfo != null &&
                currentUserInfo!.result != null &&
                ((currentUserInfo!.result!.isEmailConfirmed != null &&
                        !currentUserInfo!.result!.isEmailConfirmed!) ||
                    (currentUserInfo!.result!.isPhoneNumberConfirmed != null &&
                        !currentUserInfo!.result!.isPhoneNumberConfirmed!))) {
              await CacheHelper.instance.setIsEmailAndPhoneConfirmed(false);
              await Get.offAllNamed(Routes.VERIFY_ACCOUNT, arguments: {
                'isEmailConfirmed': currentUserInfo!.result!.isEmailConfirmed,
                'isPhoneNumberConfirmed':
                    currentUserInfo!.result!.isPhoneNumberConfirmed,
              });
            } else {
              await CacheHelper.instance.setIsEmailAndPhoneConfirmed(true);
              await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
              Future.delayed(const Duration(microseconds: 1200), () async {
                await Get.dialog(
                  Container(
                    color: ColorManager.black.withOpacity(0.1),
                    height: 140.h,
                    width: 140.w,
                    child: Center(
                      child: Container(
                        width: Get.width,
                        margin: EdgeInsets.symmetric(
                          horizontal: 18.w,
                        ),
                        child: const WelcomeBackDialogContent(),
                      ),
                    ),
                  ),
                );
              });
            }
          });
        }
      });
    } catch (e) {
      log('login Exception error {{2}} $e');
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }

  Future _getCurrentUserInfo() async {
    showLoadingDialog();
    currentUserInfo = await _loginRepo.getCurrentUserInfo();
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

  @override
  void onClose() {}
}
