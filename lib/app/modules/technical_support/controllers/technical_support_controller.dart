import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class TechnicalSupportController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController,
      messageController,
      emailController;
  FocusNode fullNameFocusNode = FocusNode(), emailFocusNode = FocusNode();
  Color? fullNameIconErrorColor, emailIconErrorColor;

  String? validateFullName(String? fullName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (fullName == null || fullName.isEmpty) {
      fullNameIconErrorColor = Colors.red;
      update();
      return LocaleKeys.please_enter_fullname.tr;
    } else if (regExp.hasMatch(fullName)) {
      fullNameIconErrorColor = Colors.red;
      update();
      return LocaleKeys.check_your_full_name.tr;
    } else {
      fullNameIconErrorColor = null;
    }
    update();
    return null;
  }

  String? validateMessage(String? message) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (message == null || message.isEmpty) {
      return LocaleKeys.please_enter_message_content.tr;
    } else if (regExp.hasMatch(message)) {
      return LocaleKeys.check_message_content.tr;
    }
    update();
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      emailIconErrorColor = Colors.red;
      update();
      return LocaleKeys.please_enter_email.tr;
    } else if (email.isEmail == false) {
      emailIconErrorColor = Colors.red;
      update();
      return LocaleKeys.please_enter_valid_email.tr;
    } else {
      emailIconErrorColor = null;
    }
    update();
    return null;
  }

  @override
  void onInit() {
    fullNameController = TextEditingController();
    messageController = TextEditingController();
    emailController = TextEditingController();
    fullNameFocusNode.addListener(() => update());
    emailFocusNode.addListener(() => update());
    super.onInit();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    messageController.dispose();
    emailController.dispose();
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
