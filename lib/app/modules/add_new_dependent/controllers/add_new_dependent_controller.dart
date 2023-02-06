import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  late DateRangePickerController dateOfBirthRangeController;
  File? image;
  FocusNode nameFocusNode = FocusNode(),
      uplpoadPictureFileFocusNode = FocusNode(),
      dateOfBirthFocusNode = FocusNode();
  DateTime dateOfBirth = DateTime.now();
  Color? nameIconErrorColor,
      uplpoadPictureFileIconErrorColor,
      dateOfBirthIconErrorColor;
  int dependentGender = 0; // 0 male, 1 female

  Future handleImageSelection({required ImageSource imageSource}) async {
    XFile? result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: imageSource,
    );
    if (result != null) {
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;
      uplpoadPictureFileController.clear();
      this.image = File(file.path);
      String tempFileName = this.image!.path.split("image_picker").last;
      uplpoadPictureFileController.text = tempFileName.replaceAll(tempFileName,
          "${DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())}.${tempFileName.split(".").last}");
    }
    update();
  }

  Future handleFileSelection() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    String? fileName;
    if (result != null && result.files.single.path != null) {
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);
      fileName = file.path.split('/').last;
      image = null;
      uplpoadPictureFileController.text = fileName;
      // log(lookupMimeType(filePath).toString());
    }
    update();
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    uplpoadPictureFileController = TextEditingController();
    dateOfBirthController = TextEditingController();
    dateOfBirthRangeController = DateRangePickerController();
    nameFocusNode.addListener(() => update());
    uplpoadPictureFileFocusNode.addListener(() => update());
    dateOfBirthFocusNode.addListener(() => update());
    super.onInit();
  }

  String? validateDateOfBirth(String? dateOfBirth) {
    if (dateOfBirth != null && dateOfBirth.isNotEmpty) {
      DateTime tempDateTime =
          DateFormat("dd MMMM yyyy", "ar_SA").parse(dateOfBirth);
      if (dateOfBirth.isEmpty) {
        dateOfBirthIconErrorColor = Colors.red;
        update();
        return LocaleKeys.please_enter_dob.tr;
      } else if (!tempDateTime.isAtLeastYearsOld(10)) {
        // at least 10 years dependent can be registered ..
        dateOfBirthIconErrorColor = Colors.red;
        update();
        return LocaleKeys.check_dependent_dob.tr;
      } else {
        dateOfBirthIconErrorColor = null;
      }
    } else {
      dateOfBirthIconErrorColor = Colors.red;
      update();
      return LocaleKeys.please_enter_dob.tr;
    }
    update();
    return null;
  }

  void changeDate(DateRangePickerSelectionChangedArgs dateAndTime) {
    log(dateAndTime.value.toString());
    dateOfBirth = dateAndTime.value;
    dateOfBirthController.text =
        DateFormat("dd MMMM yyyy", "ar_SA").format(dateOfBirth);
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
      update();
      return LocaleKeys.please_enter_dependent_name.tr;
      // } else if (!regExp.hasMatch(fullName)) {
      // if (!fullName.contains(" ")) {
      //   return LocaleKeys.should_have_space.tr;
      // } else {
      //   return null;
      // }
    } else if (regExp.hasMatch(dependentName)) {
      nameIconErrorColor = Colors.red;
      update();
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
    dateOfBirthRangeController.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
