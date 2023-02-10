import 'dart:developer';

import 'package:hessa_student/app/modules/settings/data/repos/settings_repo.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../constants/exports.dart';
import '../data/repos/settings_repo_implement.dart';

class SettingsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController oldPasswordController,
      newPasswordController,
      confirmPasswordController;

  FocusNode oldPasswordFocusNode = FocusNode(),
      newPasswordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();
  final SettingsRepo _settingsRepo = SettingsRepoImplement();
  Color? oldPasswordErrorIconColor,
      newPasswordErrorIconColor,
      confirmPasswordErrorIconColor;

  String? validateOldPassword(String? oldPasswordFieldValue) {
    if (oldPasswordFieldValue == null || oldPasswordFieldValue.isEmpty) {
      oldPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_old_password.tr;
    } else if (oldPasswordFieldValue.length < 6) {
      oldPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.password_must_be_at_least_6_characters.tr;
    } else {
      oldPasswordErrorIconColor = null;
    }
    update();
    return null;
  }

  String? validateNewPassword(String? passwordFieldValue) {
    if (passwordFieldValue == null || passwordFieldValue.isEmpty) {
      newPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_password.tr;
    } else if (passwordFieldValue.length < 6) {
      newPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.password_must_be_at_least_6_characters.tr;
    } else {
      newPasswordErrorIconColor = null;
    }
    update();
    return null;
  }

  Future changePassword() async {
    try {
      showLoadingDialog();
      await _settingsRepo
          .changePassword(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
      )
          .then((bool status) async {
        if (status) {
          clearData();
          if (Get.isBottomSheetOpen!) {
            Get.back();
          }
          CustomSnackBar.showCustomSnackBar(
            title: LocaleKeys.success.tr,
            message: LocaleKeys.password_changed_successfully.tr,
          );
        }
      });
    } catch (error) {
      log("Error in changePassword: $error");
    }
  }

  String? validateConfirmNewPassword(String? confirmPasswordFieldValue) {
    if (confirmPasswordFieldValue == null ||
        confirmPasswordFieldValue.isEmpty) {
      confirmPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_confirm_password.tr;
    } else if (confirmPasswordFieldValue != newPasswordController.text) {
      confirmPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.check_confirm_password.tr;
    } else {
      newPasswordErrorIconColor = null;
    }
    update();
    return null;
  }

  void clearData() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    oldPasswordFocusNode.unfocus();
    newPasswordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
    oldPasswordErrorIconColor = null;
    newPasswordErrorIconColor = null;
    confirmPasswordErrorIconColor = null;
    update();
  }

  @override
  void onInit() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    oldPasswordFocusNode.addListener(() => update());
    newPasswordFocusNode.addListener(() => update());
    confirmPasswordFocusNode.addListener(() => update());
    super.onInit();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
