import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class ForgotPasswordController extends GetxController {
  late TextEditingController emailController;
  FocusNode emailFocusNode = FocusNode();
  Color? emailErrorIconColor;

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

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
