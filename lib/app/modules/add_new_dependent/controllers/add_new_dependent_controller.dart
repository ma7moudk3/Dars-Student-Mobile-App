import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:hessa_student/app/data/models/school_types/school_types.dart';
import 'package:hessa_student/app/modules/add_new_dependent/data/repos/add_new_dependent_repo.dart';
import 'package:hessa_student/app/modules/add_new_dependent/data/repos/add_new_dependent_repo_implement.dart';
import 'package:hessa_student/app/modules/dependents/controllers/dependents_controller.dart';
import 'package:hessa_student/app/modules/order_hessa/controllers/order_hessa_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../core/helper_functions.dart';
import 'package:hessa_student/app/data/models/school_types/result.dart'
    as school_type;
import '../../../data/models/classes/item.dart' as level;
import '../../../data/models/student_relation/result.dart' as student_relation;
import '../../../constants/exports.dart';
import '../../../data/models/classes/classes.dart';
import '../../../data/models/student_relation/student_relation.dart';

class AddNewDependentController extends GetxController {
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
  bool isFromOrderHessa = false;
  Color? nameIconErrorColor,
      schoolNameIconErrorColor,
      uplpoadPictureFileIconErrorColor,
      dateOfBirthIconErrorColor;

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
    nameController = TextEditingController();
    uplpoadPictureFileController = TextEditingController();
    // dateOfBirthController = TextEditingController();
    schoolNameController = TextEditingController();
    notesController = TextEditingController();
    dateOfBirthRangeController = DateRangePickerController();
    nameFocusNode.addListener(() => update());
    uplpoadPictureFileFocusNode.addListener(() => update());
    dateOfBirthFocusNode.addListener(() => update());
    isFromOrderHessa = Get.arguments != null
        ? Get.arguments["isFromOrderHessa"] ?? false
        : false;
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

  Future addNewStudent() async {
    // Student == Dependent
    showLoadingDialog();
    await _addNewDependentRepo
        .addOrEditDependent(
      genderId: dependentGender + 1,
      name: nameController.text,
      levelId: selectedClass.id ?? 1,
      schoolTypeId: selectedSchoolType.id ?? 1,
      relationId: selectedStudentRelation.id ?? 1,
      schoolName: schoolNameController.text,
      details: notesController.text,
      image: image,
    )
        .then((value) async {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      await Future.delayed(const Duration(milliseconds: 550))
          .then((value) async {
        if (isFromOrderHessa == false) {
          final DependentsController dependentsController =
              Get.find<DependentsController>();
          dependentsController.refreshPagingController();
        } else {
          final OrderHessaController orderHessaController =
              Get.find<OrderHessaController>();
          orderHessaController.refreshStudentsPagingController();
        }
        Get.back();
        CustomSnackBar.showCustomSnackBar(
          title: LocaleKeys.success.tr,
          message: LocaleKeys.dependent_added_successfully.tr,
        );
      });
    });
  }

  // void changeTopic(String? result) {
  //   if (topics.result != null && result != null) {
  //     for (var topic in topics.result ?? <topic.Result>[]) {
  //       if (topic.displayName != null &&
  //           topic.displayName!.toLowerCase() == result.toLowerCase()) {
  //         selectedTopic = topic;
  //       }
  //     }
  //   }
  //   update();
  // }

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
  }

  // Future _getTopics() async {
  //   topics = await _addNewDependentRepo.getTopics();
  //   if (topics.result != null) {
  //     topics.result!.insert(
  //       0,
  //       topic.Result(
  //         id: -1,
  //         displayName: LocaleKeys.choose_studying_subject.tr,
  //       ),
  //     );
  //   }
  // }

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

  // String? validateDateOfBirth(String? dateOfBirth) {
  //   if (dateOfBirth != null && dateOfBirth.isNotEmpty) {
  //     DateTime tempDateTime =
  //         DateFormat("dd MMMM yyyy", "ar_SA").parse(dateOfBirth);
  //     if (dateOfBirth.isEmpty) {
  //       dateOfBirthIconErrorColor = Colors.red;
  //       update();
  //       return LocaleKeys.please_enter_dob.tr;
  //     } else if (!tempDateTime.isAtLeastYearsOld(10)) {
  //       // at least 10 years dependent can be registered ..
  //       dateOfBirthIconErrorColor = Colors.red;
  //       update();
  //       return LocaleKeys.check_dependent_dob.tr;
  //     } else {
  //       dateOfBirthIconErrorColor = null;
  //       update();
  //       return null;
  //     }
  //   } else {
  //     dateOfBirthIconErrorColor = Colors.red;
  //     update();
  //     return LocaleKeys.please_enter_dob.tr;
  //   }
  // }

  // void changeDate(DateRangePickerSelectionChangedArgs dateAndTime) {
  //   log(dateAndTime.value.toString());
  //   dateOfBirth = dateAndTime.value;
  //   dateOfBirthController.text =
  //       DateFormat("dd MMMM yyyy", "ar_SA").format(dateOfBirth);
  //   update();
  // }

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

  @override
  void dispose() {
    nameController.dispose();
    uplpoadPictureFileController.dispose();
    // dateOfBirthController.dispose();
    nameFocusNode.dispose();
    notesController.dispose();
    schoolNameController.dispose();
    uplpoadPictureFileFocusNode.dispose();
    schoolNameFocusNode.dispose();
    dateOfBirthFocusNode.dispose();
    dateOfBirthRangeController.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
