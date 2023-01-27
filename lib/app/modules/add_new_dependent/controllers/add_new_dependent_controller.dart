import 'package:intl/intl.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

extension IsAtLeastYearsOld on DateTime {
  bool isAtLeastYearsOld(int years) {
    DateTime now = DateTime.now();
    DateTime boundaryDate = DateTime(now.year - years, now.month, now.day);
    DateTime thisDate = DateTime(year, month, day);
    return thisDate.compareTo(boundaryDate) <= 0;
  }
}

class AddNewDependentController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      uplpoadPictureFileController,
      dateOfBirthController;
  FocusNode nameFocusNode = FocusNode(),
      uplpoadPictureFileFocusNode = FocusNode(),
      dateOfBirthFocusNode = FocusNode();
  DateTime dateOfBirth = DateTime.now();
  Color? nameIconErrorColor,
      uplpoadPictureFileIconErrorColor,
      dateOfBirthIconErrorColor;
  int dependentGender = 0; // 0 male, 1 female

  @override
  void onInit() {
    nameController = TextEditingController();
    uplpoadPictureFileController = TextEditingController();
    dateOfBirthController = TextEditingController();
    nameFocusNode.addListener(() => update());
    uplpoadPictureFileFocusNode.addListener(() => update());
    dateOfBirthFocusNode.addListener(() => update());
    super.onInit();
  }

  String? validateDateOfBirth(String? dateOfBirth) {
    if (dateOfBirth != null && dateOfBirth.isNotEmpty) {
      DateTime tempDateTime = DateFormat("dd/MM/yyyy").parse(dateOfBirth);
      if (dateOfBirth.isEmpty) {
        dateOfBirthIconErrorColor = Colors.red;
        return LocaleKeys.please_enter_dob.tr;
      } else if (!tempDateTime.isAtLeastYearsOld(10)) {
        // at least 10 years dependent can be registered ..
        dateOfBirthIconErrorColor = Colors.red;
        return LocaleKeys.check_dependent_dob.tr;
      } else {
        dateOfBirthIconErrorColor = null;
      }
    } else {
      dateOfBirthIconErrorColor = Colors.red;
      return LocaleKeys.please_enter_dob.tr;
    }
    update();
    return null;
  }

  void changeDate(DateTime? dateAndTime) {
    dateOfBirth = dateAndTime!;
    dateOfBirthController.text = DateFormat("dd/MM/yyyy").format(dateOfBirth);
    update();
  }

  void changeDependentGender(int value) {
    dependentGender = value;
    update();
  }

  String? validateDependentName(String? dependentName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (dependentName == null || dependentName.isEmpty) {
      nameIconErrorColor = Colors.red;
      return LocaleKeys.please_enter_dependent_name.tr;
      // } else if (!regExp.hasMatch(fullName)) {
      // if (!fullName.contains(" ")) {
      //   return LocaleKeys.should_have_space.tr;
      // } else {
      //   return null;
      // }
    } else if (regExp.hasMatch(dependentName)) {
      nameIconErrorColor = Colors.red;
      return LocaleKeys.check_dependent_name.tr;
    } else {
      nameIconErrorColor = null;
    }
    update();
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    uplpoadPictureFileController.dispose();
    dateOfBirthController.dispose();
    nameFocusNode.dispose();
    uplpoadPictureFileFocusNode.dispose();
    dateOfBirthFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
