import 'dart:developer';

import 'package:hessa_student/app/modules/forgot_password/data/repos/forgot_password_implement.dart';
import 'package:hessa_student/app/modules/forgot_password/data/repos/forgot_password_repo.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../widgets/email_verification_sent_dialog_content.dart';

class ForgotPasswordController extends GetxController {
  late TextEditingController emailController;
  FocusNode emailFocusNode = FocusNode();
  Color? emailErrorIconColor;
  final ForgotPasswordRepo _forgotPasswordRepo = ForgotPasswordRepoImplement();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    emailController = TextEditingController();
    emailFocusNode.addListener(() => update());
    super.onInit();
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

  Future sendPasswordResetCode() async {
    showLoadingDialog();
    try {
      await _forgotPasswordRepo
          .sendPasswordResetCode(
        emailAddress: emailController.text,
      )
          .then((value) async {
        await _resetPasswordDialog();
        Future.delayed(const Duration(milliseconds: 1200)).then((value) async {
          if (Get.isDialogOpen!) {
            Get.back();
          }
          Get.back();
        });
      });
    } catch (e) {
      log("sendPasswordResetCode $e");
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }

  Future _resetPasswordDialog() async {
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
            child: const EmailVerificationSentDialogContent(),
          ),
        ),
      ),
      arguments: {
        'email': emailController.text,
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
