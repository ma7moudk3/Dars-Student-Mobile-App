import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

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
  Color? fullNameErrorIconColor,
      emailErrorIconColor,
      passwordErrorIconColor,
      confimationPasswordErrorIconColor;
  bool tosIsAgreed = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  int gender = 0; // 1 male , 0 female

  void changeGender(int genderValue) {
    gender = genderValue;
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

  void toggleTermsOfUse({bool? isAgreed}) {
    tosIsAgreed = isAgreed ?? !tosIsAgreed;
    update();
  }

  String? validateFullName(String? fullName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (fullName == null || fullName.isEmpty) {
      return LocaleKeys.please_enter_fullname.tr;
      // } else if (!regExp.hasMatch(fullName)) {
      // if (!fullName.contains(" ")) {
      //   return LocaleKeys.should_have_space.tr;
      // } else {
      //   return null;
      // }
    } else if (regExp.hasMatch(fullName)) {
      return LocaleKeys.check_your_full_name.tr;
    } else {
      return null;
    }
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

  String? validateConfirmPassword(String? confirmPasswordFieldValue) {
    if (confirmPasswordFieldValue == null ||
        confirmPasswordFieldValue.isEmpty) {
      confimationPasswordErrorIconColor = Colors.red;
      return LocaleKeys.please_enter_confirm_password.tr;
    } else if (confirmPasswordFieldValue != passwordController.text) {
      confimationPasswordErrorIconColor = Colors.red;
      return LocaleKeys.check_confirm_password.tr;
    } else {
      passwordErrorIconColor = null;
    }
    update();
    return null;
  }

  @override
  void onClose() {}
}
