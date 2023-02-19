import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:hessa_student/app/modules/dependents/data/models/student/student.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:hessa_student/app/data/models/school_types/result.dart'
    as school_type;
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../core/helper_functions.dart';
import '../../../data/models/classes/item.dart' as level;
import '../../../data/models/student_relation/result.dart' as student_relation;
import '../../../constants/exports.dart';
import '../../../data/models/classes/classes.dart';
import '../../../data/models/school_types/school_types.dart';
import '../../../data/models/student_relation/student_relation.dart';
import '../../add_new_dependent/data/repos/add_new_dependent_repo.dart';
import '../../add_new_dependent/data/repos/add_new_dependent_repo_implement.dart';
import '../../dependents/controllers/dependents_controller.dart';

extension IsAtLeastYearsOld on DateTime {
  bool isAtLeastYearsOld(int years) {
    DateTime now = DateTime.now();
    DateTime boundaryDate = DateTime(now.year - years, now.month, now.day);
    DateTime thisDate = DateTime(year, month, day);
    return thisDate.compareTo(boundaryDate) <= 0;
  }
}

class EditDependentController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      notesController,
      uplpoadPictureFileController,
      schoolNameController; // ,dateOfBirthController;
  late DateRangePickerController dateOfBirthRangeController;
  File? image;
  FocusNode nameFocusNode = FocusNode(),
      uplpoadPictureFileFocusNode = FocusNode(),
      dateOfBirthFocusNode = FocusNode(),
      schoolNameFocusNode = FocusNode();
  DateTime dateOfBirth = DateTime.now();
  Color? nameIconErrorColor,
      schoolNameIconErrorColor,
      uplpoadPictureFileIconErrorColor,
      dateOfBirthIconErrorColor;
  Student studentToEdit =
      Get.arguments != null ? Get.arguments ?? Student() : Student();
  int dependentGender = 0; // 0 male, 1 female
  Classes classes = Classes();
  // Topics topics = Topics();
  StudentRelation studentRelations = StudentRelation();
  SchoolTypes schoolTypes = SchoolTypes();
  level.Item selectedClass = level.Item();
  // topic.Result selectedTopic = topic.Result();
  school_type.Result selectedSchoolType = school_type.Result();
  student_relation.Result selectedStudentRelation = student_relation.Result();
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  final AddNewDependentRepo _addNewDependentRepo =
      AddNewDependentRepoImplement();

  @override
  void onInit() async {
    nameController = TextEditingController(
      text: studentToEdit.requesterStudent?.name ?? '',
    );
    uplpoadPictureFileController = TextEditingController();
    // dateOfBirthController = TextEditingController();
    schoolNameController = TextEditingController(
      text: studentToEdit.requesterStudent?.schoolName ?? '',
    );
    notesController = TextEditingController(
      text: studentToEdit.requesterStudent?.details ?? '',
    );
    dependentGender = studentToEdit.requesterStudent != null
        ? studentToEdit.requesterStudent!.genderId != null
            ? (studentToEdit.requesterStudent!.genderId! - 1)
            : 0
        : 0;
    // dateOfBirthRangeController = DateRangePickerController();
    nameFocusNode.addListener(() => update());
    uplpoadPictureFileFocusNode.addListener(() => update());
    dateOfBirthFocusNode.addListener(() => update());
    await checkInternet();
    super.onInit();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10).then(
      (bool internetStatus) async {
        isInternetConnected.value = internetStatus;
        if (isInternetConnected.value) {
          await Future.wait([
            _getClasses(),
            // _getTopics(),
            _getStudentRelations(),
            _getSchoolTypes(),
          ]).then((value) => isLoading.value = false);
        }
      },
    );
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
      nameFocusNode.requestFocus();
      update();
      return LocaleKeys.please_enter_dependent_name.tr;
    } else if (!regExp.hasMatch(dependentName)) {
      if (!dependentName.contains(" ")) {
        nameIconErrorColor = Colors.red;
        nameFocusNode.requestFocus();
        update();
        return LocaleKeys.should_have_space.tr;
      } else {
        nameIconErrorColor = null;
        nameFocusNode.unfocus();
        update();
        return null;
      }
    } else if (regExp.hasMatch(dependentName)) {
      nameIconErrorColor = Colors.red;
      nameFocusNode.requestFocus();
      update();
      return LocaleKeys.check_dependent_name.tr;
    } else {
      nameIconErrorColor = null;
      nameFocusNode.unfocus();
      update();
      return null;
    }
  }

  String? validateSchoolName(String? schoolName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (schoolName == null || schoolName.isEmpty) {
      schoolNameIconErrorColor = Colors.red;
      schoolNameFocusNode.requestFocus();
      update();
      return LocaleKeys.please_enter_dependent_name.tr;
    } else if (regExp.hasMatch(schoolName)) {
      schoolNameIconErrorColor = Colors.red;
      schoolNameFocusNode.requestFocus();
      update();
      return LocaleKeys.check_dependent_name.tr;
    } else {
      schoolNameIconErrorColor = null;
      schoolNameFocusNode.unfocus();
      update();
      return null;
    }
  }

  Future editStudent() async {
    // Student == Dependent
    showLoadingDialog();
    await _addNewDependentRepo
        .addOrEditDependent(
      genderId: dependentGender + 1,
      name: nameController.text,
      levelId: selectedClass.id ?? 1,
      requesterId: studentToEdit.requesterStudent?.requesterId ?? -1,
      schoolTypeId: selectedSchoolType.id ?? 1,
      relationId: selectedStudentRelation.id ?? 1,
      schoolName: schoolNameController.text,
      details: notesController.text,
      image: image,
      id: studentToEdit.requesterStudent?.id ?? -1,
    )
        .then((value) async {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      await Future.delayed(const Duration(milliseconds: 550))
          .then((value) async {
        final DependentsController dependentsController =
            Get.find<DependentsController>();
        dependentsController.refreshPagingController();
        Get.back();
        CustomSnackBar.showCustomSnackBar(
          title: LocaleKeys.success.tr,
          message: LocaleKeys.dependent_edited_successfully.tr,
        );
      });
    });
  }

  void changeSchoolType(String? result) {
    if (schoolTypes.result != null && result != null) {
      for (var schoolType in schoolTypes.result ?? <school_type.Result>[]) {
        if (schoolType.displayName != null &&
            schoolType.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedSchoolType = schoolType;
        }
      }
    }
    update();
  }

  void changeLevel(String? result) {
    if (classes.result != null &&
        classes.result!.items != null &&
        result != null) {
      for (var level in classes.result!.items ?? <level.Item>[]) {
        if (level.displayName != null &&
            level.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedClass = level;
        }
      }
    }
    update();
  }

  void changeStudentRelation(String? result) {
    if (studentRelations.result != null && result != null) {
      for (var studentRelation
          in studentRelations.result ?? <student_relation.Result>[]) {
        if (studentRelation.displayName != null &&
            studentRelation.displayName!.toLowerCase() ==
                result.toLowerCase()) {
          selectedStudentRelation = studentRelation;
        }
      }
    }
    update();
  }

  Future _getClasses() async {
    classes = await _addNewDependentRepo.getClasses();
    if (classes.result != null && classes.result!.items != null) {
      classes.result!.items!.insert(
        0,
        level.Item(
          id: -1,
          displayName: LocaleKeys.choose_studying_class.tr,
        ),
      );
    }
    for (var level in classes.result!.items ?? <level.Item>[]) {
      if (level.id == (studentToEdit.requesterStudent?.levelId ?? -1)) {
        selectedClass = level;
      }
    }
    update();
  }

  Future _getStudentRelations() async {
    studentRelations = await _addNewDependentRepo.getStudentRelations();
    if (studentRelations.result != null) {
      studentRelations.result!.insert(
        0,
        student_relation.Result(
          id: -1,
          displayName: LocaleKeys.choose_student_relation.tr,
        ),
      );
    }
    for (var studentRelation
        in studentRelations.result ?? <student_relation.Result>[]) {
      if (studentRelation.id ==
          (studentToEdit.requesterStudent?.relationId ?? -1)) {
        selectedStudentRelation = studentRelation;
      }
    }
    update();
  }

  Future _getSchoolTypes() async {
    schoolTypes = await _addNewDependentRepo.getSchoolTypes();
    if (schoolTypes.result != null) {
      schoolTypes.result!.insert(
        0,
        school_type.Result(
          id: -1,
          displayName: LocaleKeys.choose_school_type.tr,
        ),
      );
    }
    for (var schoolType in schoolTypes.result ?? <school_type.Result>[]) {
      if (schoolType.id ==
          (studentToEdit.requesterStudent?.schoolTypeId ?? -1)) {
        selectedSchoolType = schoolType;
      }
    }
    update();
  }

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
}
