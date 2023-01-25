import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  late TextEditingController emailController, passwordController;

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
      return LocaleKeys.please_enter_email.tr;
    } else if (email.isEmail == false) {
      return LocaleKeys.please_enter_valid_email.tr;
    }
    return null;
  }

  String? validatePassword(String? passwordFieldValue) {
    if (passwordFieldValue == null || passwordFieldValue.isEmpty) {
      return LocaleKeys.please_enter_password.tr;
    } else if(passwordFieldValue.length < 6){
      return LocaleKeys.password_must_be_at_least_6_characters.tr;
    }else{
      return null;
    }
  }

  @override
  void onClose() {}
}
