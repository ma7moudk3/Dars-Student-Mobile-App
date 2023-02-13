import 'dart:developer';

import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/dependents/controllers/dependents_controller.dart';
import 'package:hessa_student/app/modules/order_hessa/data/repos/order_hessa_repo.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../data/models/classes/classes.dart';
import 'package:hessa_student/app/data/models/topics/result.dart' as topic;
import '../../../data/models/classes/item.dart' as level;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_range/time_range.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/typeahead/cupertino_flutter_typeahead.dart';
import '../../../constants/exports.dart';
import '../../../data/models/topics/topics.dart';
import '../data/models/teacher.dart';
import '../data/repos/order_hessa_repo_implement.dart';

extension IsAtMaximumYears on DateTime {
  bool isAtMaximumYears(int years) {
    DateTime now = DateTime.now();
    DateTime boundaryDate = DateTime(now.year - years, now.month, now.day);
    DateTime thisDate = DateTime(year, month, day);
    return thisDate.compareTo(boundaryDate) >= 0;
  }
}

class OrderHessaController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int sessionWay = 0; // 0 face-to-face, 1 electronic, 2 both
  int teacherGender = 0; // 0 male, 1 female, 2 both
  int orderType = 0; // 0 one hessa, 1 school package
  late TextEditingController hessaDateController,
      hessaTimeController,
      locationController,
      teacherNameController,
      notesController;
  DateTime hessaDate = DateTime.now();
  Color? teacherNameErrorIconColor,
      hessaDateErrorIconColor,
      hessaTimeErrorIconColor;
  TimeRangeResult? hessaTimeRange;
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  late DateRangePickerController hessaDateRangeController;
  final OrderHessaRepo _orderHessaRepo = OrderHessaRepoImplement();
  FocusNode hessaDateFocusNode = FocusNode(), hessaTimeFocusNode = FocusNode();
  DependentsController dependentsController =
      Get.put<DependentsController>(DependentsController());
  final CupertinoSuggestionsBoxController suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  Classes classes = Classes();
  Topics topics = Topics();
  level.Item selectedClass = level.Item();
  topic.Result selectedTopic = topic.Result();
  Teacher? chosenTeacher;
  void changeHessaDate(DateRangePickerSelectionChangedArgs hessaDate) {
    log(hessaDate.value.toString());
    this.hessaDate = hessaDate.value;
    hessaDateController.text =
        DateFormat("dd MMMM yyyy", "ar_SA").format(hessaDate.value);
    update();
  }

  List<Teacher> teachers = [
    Teacher(
      name: "وليد علي",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "ولاء يوسف",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Ahmed Alashi",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Abdullah Alashi2",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Abdullah Alashi3",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Abdullah Alashi4",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Abdullah Alashi5",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Abdullah Alashi6",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Abdullah Alashi7",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Abdullah Alashi8",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Abdullah Alashi9",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
    Teacher(
      name: "Abdullah Alashi10",
      subjects: ["فيزياء", "رياضيات", "علوم"],
      address: "رام الله، الضفة",
      picture: ImagesManager.avatar,
    ),
  ];

  List<Teacher> foundTeachers = [];

  List<Teacher> searchTeacher({required String searchValue}) {
    return foundTeachers = teachers
        .where((Teacher teacher) =>
            teacher.name.toLowerCase().contains(searchValue) ||
            teacher.address.toLowerCase().contains(searchValue) ||
            teacher.subjects.any((String subject) =>
                subject.toLowerCase().contains(searchValue)))
        .toList();
    // for (Teacher teacher in foundedTeachers) {
    //   log("Teacher name: ${teacher.name}");
    // }
  }

  void selectTeacher(Teacher teacher) {
    teacherNameController.text = teacher.name;
    chosenTeacher = teacher;
    update();
  }

  void changeTopic(String? result) {
    if (topics.result != null && result != null) {
      for (var topic in topics.result ?? <topic.Result>[]) {
        if (topic.displayName != null &&
            topic.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedTopic = topic;
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

  void changeLocation(String location) {
    locationController.text = location;
    update();
  }

  String? validateHessaDate(String? hessaDate) {
    if (hessaDate != null && hessaDate.isNotEmpty) {
      DateTime tempDateTime =
          DateFormat("dd MMMM yyyy", "ar_SA").parse(hessaDate);
      if (hessaDate.isEmpty) {
        hessaDateErrorIconColor = Colors.red;
        update();
        return LocaleKeys.please_enter_hessa_date.tr;
      } else if (!tempDateTime.isAtMaximumYears(1)) {
        hessaDateErrorIconColor = Colors.red;
        update();
        return LocaleKeys.check_hessa_date.tr;
      } else {
        hessaDateErrorIconColor = null;
      }
    } else {
      hessaDateErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_hessa_date.tr;
    }
    update();
    return null;
  }

  String? validateHessaTime(String? hessaTime) {
    if (hessaTime != null && hessaTime.isNotEmpty) {
      hessaTimeErrorIconColor = null;
    } else {
      hessaTimeErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_hessa_date.tr;
    }
    update();
    return null;
  }

  String? validateTeacherName(String? teacherName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (teacherName == null || teacherName.isEmpty) {
      teacherNameErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_teacher_name.tr;
      // } else if (!regExp.hasMatch(fullName)) {
      // if (!fullName.contains(" ")) {
      //   return LocaleKeys.should_have_space.tr;
      // } else {
      //   return null;
      // }
    } else if (regExp.hasMatch(teacherName)) {
      teacherNameErrorIconColor = Colors.red;
      update();
      return LocaleKeys.check_teacher_name.tr;
    } else {
      teacherNameErrorIconColor = null;
    }
    update();
    return null;
  }

  void changeHessaTime(TimeRangeResult? rangeResult) {
    if (rangeResult == null) return;
    hessaTimeRange = rangeResult;
    DateTime now = DateTime.now();
    String formattedFromTime = DateFormat.jm('ar_SA').format(DateTime(now.year,
        now.month, now.day, rangeResult.start.hour, rangeResult.start.minute));
    String formattedToTime = DateFormat.jm('ar_SA').format(DateTime(now.year,
        now.month, now.day, rangeResult.end.hour, rangeResult.end.minute));
    hessaTimeController.text = "$formattedFromTime - $formattedToTime";
    update();
  }

  @override
  void onInit() async {
    hessaDateController = TextEditingController();
    hessaDateRangeController = DateRangePickerController();
    hessaTimeController = TextEditingController();
    locationController = TextEditingController();
    teacherNameController = TextEditingController();
    notesController = TextEditingController();
    await initializeDateFormatting("ar_SA", null);
    hessaDateFocusNode.addListener(() => update());
    hessaTimeFocusNode.addListener(() => update());
    await checkInternet();
    super.onInit();
  }

  @override
  void dispose() {
    hessaDateController.dispose();
    hessaDateRangeController.dispose();
    hessaTimeController.dispose();
    locationController.dispose();
    teacherNameController.dispose();
    notesController.dispose();
    hessaDateFocusNode.dispose();
    hessaTimeFocusNode.dispose();
    super.dispose();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        await Future.wait([
          _getClasses(),
          _getTopics(),
        ]).then((value) => isLoading.value = false);
      }
    });
  }

  Future _getClasses() async {
    classes = await _orderHessaRepo.getClasses();
    if (classes.result != null && classes.result!.items != null) {
      classes.result!.items!.add(
        level.Item(
          id: -1,
          displayName: LocaleKeys.choose_studying_class.tr,
        ),
      );
      classes.result!.items!.sort((a, b) => a.id!.compareTo(b.id!));
    }
  }

  Future _getTopics() async {
    topics = await _orderHessaRepo.getTopics();
    if (topics.result != null) {
      topics.result!.add(
        topic.Result(
          id: -1,
          displayName: LocaleKeys.choose_studying_subject.tr,
        ),
      );
      topics.result!.sort((a, b) => a.id!.compareTo(b.id!));
    }
  }

  void changeSessionWay(int value) {
    sessionWay = value;
    update();
  }

  void changeTeacherGender(int value) {
    teacherGender = value;
    update();
  }

  void changeOrderType(int value) {
    orderType = value;
    update();
  }

  @override
  void onClose() {}
}
