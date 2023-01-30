import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class SettingsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController oldPasswordController,
      newPasswordController,
      confirmPasswordController;

  FocusNode oldPasswordFocusNode = FocusNode(),
      newPasswordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();

  Color? oldPasswordErrorIconColor,
      newPasswordErrorIconColor,
      confirmPasswordErrorIconColor;

  String? validateOldPassword(String? oldPasswordFieldValue) {
    if (oldPasswordFieldValue == null || oldPasswordFieldValue.isEmpty) {
      oldPasswordErrorIconColor = Colors.red;
      return LocaleKeys.please_enter_old_password.tr;
    } else if (oldPasswordFieldValue.length < 6) {
      oldPasswordErrorIconColor = Colors.red;
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
      return LocaleKeys.please_enter_password.tr;
    } else if (passwordFieldValue.length < 6) {
      newPasswordErrorIconColor = Colors.red;
      return LocaleKeys.password_must_be_at_least_6_characters.tr;
    } else {
      newPasswordErrorIconColor = null;
    }
    update();
    return null;
  }

  String? validateConfirmNewPassword(String? confirmPasswordFieldValue) {
    if (confirmPasswordFieldValue == null ||
        confirmPasswordFieldValue.isEmpty) {
      confirmPasswordErrorIconColor = Colors.red;
      return LocaleKeys.please_enter_confirm_password.tr;
    } else if (confirmPasswordFieldValue != newPasswordController.text) {
      confirmPasswordErrorIconColor = Colors.red;
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
