import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController passwordController, confirmPasswordController;
  FocusNode passwordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();

  Color? passwordErrorIconColor, confirmPasswordErrorIconColor;

  @override
  void onInit() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    passwordFocusNode.addListener(() => update());
    confirmPasswordFocusNode.addListener(() => update());
    super.onInit();
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
      confirmPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_confirm_password.tr;
    } else if (confirmPasswordFieldValue != passwordController.text) {
      confirmPasswordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.check_confirm_password.tr;
    } else {
      confirmPasswordErrorIconColor = null;
    }
    update();
    return null;
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
