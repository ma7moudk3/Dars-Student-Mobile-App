import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class EditProfileController extends GetxController {
  late TextEditingController fullNameController,
      emailController,
      phoneController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode fullNameFocusNode = FocusNode(),
      emailFocusNode = FocusNode(),
      phoneFocusNode = FocusNode();
  Color? fullNameErrorIconColor, emailErrorIconColor;
  String? phoneNumber;
  int gender = 0; // 0 male, 1 female
  File? image;

  @override
  void onInit() {
    fullNameController = TextEditingController();
    fullNameFocusNode.addListener(() => update());
    emailController = TextEditingController();
    emailFocusNode.addListener(() => update());
    phoneController = TextEditingController();
    phoneFocusNode.addListener(() => update());
    super.onInit();
  }

  void changeGender(int genderValue) {
    gender = genderValue;
    update();
  }

  Future pickImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
    update();
  }

  String? validateFullName(String? fullName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (fullName == null || fullName.isEmpty) {
      fullNameErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_fullname.tr;
    } else if (!regExp.hasMatch(fullName)) {
      if (!fullName.contains(" ")) {
        fullNameErrorIconColor = Colors.red;
        update();
        return LocaleKeys.should_have_space.tr;
      } else {
        fullNameErrorIconColor = null;
        update();
        return null;
      }
    } else if (regExp.hasMatch(fullName)) {
      fullNameErrorIconColor = Colors.red;
      update();
      return LocaleKeys.check_your_full_name.tr;
    } else {
      fullNameErrorIconColor = null;
    }
    update();
    return null;
  }

  void changePhoneNumber(PhoneNumber number) {
    phoneNumber = number.completeNumber.toString();
    update();
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
    fullNameController.dispose();
    fullNameFocusNode.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
