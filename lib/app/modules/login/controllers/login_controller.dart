import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class LoginController extends GetxController {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  late TextEditingController emailController, passwordController;
  Color? emailErrorIconColor, passwordErrorIconColor;
  final GlobalKey<FormState> formKey = GlobalKey();

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
      return LocaleKeys.please_enter_email.tr;
    } else if (email.isEmail == false) {
      emailErrorIconColor = Colors.red;
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
      return LocaleKeys.please_enter_password.tr;
    } else if (passwordFieldValue.length < 6) {
      passwordErrorIconColor = Colors.red;
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
