import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/data/models/skills/item.dart' as skill;
import 'package:hessa_student/app/modules/orders/controllers/orders_controller.dart';
import 'package:hessa_student/app/modules/preferred_teachers/data/repos/preferred_teachers_repo.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../../global_presentation/global_widgets/multiselect_dropdown.dart';
import 'package:hessa_student/app/data/models/topics/result.dart' as topic;
import '../../../data/models/classes/classes.dart';
import '../../../data/models/classes/item.dart' as level;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_range/time_range.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/typeahead/cupertino_flutter_typeahead.dart';
import '../../../constants/exports.dart';
import '../../../data/models/skills/skills.dart';
import '../../../data/models/topics/topics.dart';
import '../../../routes/app_pages.dart';
import '../../addresses/data/models/address_result/address_result.dart';
import '../../addresses/data/repos/addresses.repo.dart';
import '../../addresses/data/repos/addresses_repo_implement.dart';
import '../../dependents/data/models/student/student.dart';
import '../../dependents/data/repos/dependents_repo.dart';
import '../../dependents/data/repos/dependents_repo_implement.dart';
import '../../home/controllers/home_controller.dart';
import '../../preferred_teachers/data/models/preferred_teacher/preferred_teacher.dart';
import '../../preferred_teachers/data/repos/preferred_teachers_repo_implement.dart';
import '../data/repos/order_dars_repo.dart';
import '../data/repos/order_dars_repo_implement.dart';

extension IsAtMaximumYears on DateTime {
  bool isAtMaximumYears(int years) {
    DateTime now = DateTime.now();
    DateTime boundaryDate = DateTime(now.year - years, now.month, now.day);
    DateTime thisDate = DateTime(year, month, day);
    return thisDate.compareTo(boundaryDate) >= 0;
  }
}

class OrderDarsController extends GetxController {
  final GlobalKey<FormState> 
  formKey = GlobalKey<FormState>();
  int sessionWay = 0; // 0 face-to-face, 1 electronic, 2 both
  int darsCategory = 0; // 0 academic learning, 1 skills
  int teacherGender =
      0; // 1 male, 2 female, 3 both , starts from zero just for the sake of the UI
  int orderType = 0; // 0 one dars, 1 school package , orderType is productId
  static const _pageSize = 3; // 3 students per page >> student = dependent
  final DependentsRepo _dependentsRepo = DependentsRepoImplement();
  List<Student> students = [];
  PagingController<int, Student> pagingController = PagingController(
      firstPageKey: 1); // Student = RequesterDependent or RequesterStudent :)
  final PreferredTeachersRepo _darsTeacherRepo =
      PreferredTeachersRepoImplement();
  late TextEditingController darsDateController,
      darsTimeController,
      locationController,
      teacherNameController,
      notesController;
  DateTime darsDate = DateTime.now();
  TimeRangeResult? darsTimeRange;
  Color? teacherNameErrorIconColor,
      darsDateErrorIconColor,
      darsTimeErrorIconColor;
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  late DateRangePickerController darsDateRangeController;
  final OrderDarsRepo _orderDarsRepo = OrderDarsRepoImplement();
  FocusNode darsDateFocusNode = FocusNode(), darsTimeFocusNode = FocusNode();
  final AddressesRepo _addressesRepo = AddressesRepoImplement();
  final CupertinoSuggestionsBoxController suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  Classes classes = Classes();
  Topics topics = Topics();
  Skills skills = Skills();
  level.Item selectedClass = level.Item();
  List<String> selectedTopics = [];
  List<PreferredTeacher> teachers = [];
  List<String> selectedSkills = [];
  List<Student> selectedStudents = [];
  List<AddressResult> addresses = [];
  AddressResult? selectedAddress;
  bool isAddressDropDownLoading = false;
  PreferredTeacher? chosenTeacher;

  @override
  void onInit() async {
    darsDateController = TextEditingController();
    darsDateRangeController = DateRangePickerController();
    darsTimeController = TextEditingController();
    locationController = TextEditingController();
    teacherNameController = TextEditingController();
    notesController = TextEditingController();
    await initializeDateFormatting("ar_SA", null);
    darsDateFocusNode.addListener(() => update());
    darsTimeFocusNode.addListener(() => update());
    _initPageRequestListener();
    await checkInternet();
    super.onInit();
  }

  bool isDataChanged() {
    return darsDateController.text.isNotEmpty ||
        darsTimeRange != null ||
        (selectedAddress != addresses.first) ||
        selectedStudents.isNotEmpty ||
        selectedTopics.isNotEmpty ||
        selectedSkills.isNotEmpty ||
        sessionWay != 0 ||
        darsCategory != 0 ||
        orderType != 0 ||
        teacherGender != 0 ||
        teacherNameController.text.isNotEmpty ||
        notesController.text.isNotEmpty ||
        chosenTeacher != null;
  }

  @override
  void dispose() {
    darsDateController.dispose();
    darsDateRangeController.dispose();
    darsTimeController.dispose();
    locationController.dispose();
    teacherNameController.dispose();
    notesController.dispose();
    darsDateFocusNode.dispose();
    darsTimeFocusNode.dispose();
    super.dispose();
  }

  void changeDarsDate(DateRangePickerSelectionChangedArgs darsDate) {
    this.darsDate = darsDate.value;
    darsDateController.text =
        DateFormat("dd MMMM yyyy", "ar_SA").format(darsDate.value);
    update();
  }

  void changeDarsTime(TimeRangeResult? rangeResult) {
    if (rangeResult == null) return;
    darsTimeRange = rangeResult;
    DateTime now = DateTime.now();
    String formattedFromTime = DateFormat.jm('ar_SA').format(DateTime(now.year,
        now.month, now.day, rangeResult.start.hour, rangeResult.start.minute));
    String formattedToTime = DateFormat.jm('ar_SA').format(DateTime(now.year,
        now.month, now.day, rangeResult.end.hour, rangeResult.end.minute));
    darsTimeController.text = "$formattedFromTime - $formattedToTime";
    update();
  }

  Future addNewOrderDars() async {
    showLoadingDialog();
    List<int> selectedTopicsOrSkills = [];
    if (darsCategory == 0) {
      // academic learning
      if (topics.result != null) {
        selectedTopicsOrSkills = topics.result!
            .where((topic.Result element) =>
                selectedTopics.contains(element.displayName))
            .map((topic.Result topic) => topic.id ?? -1)
            .toList();
      }
      selectedTopicsOrSkills.removeWhere((int element) => element == -1);
    } else {
      if (skills.result != null && skills.result!.items != null) {
        selectedTopicsOrSkills = skills.result!.items!
            .where((skill.Item skill) =>
                selectedSkills.contains(skill.displayName))
            .map((skill.Item skill) => skill.id ?? -1)
            .toList();
      }
      selectedTopicsOrSkills.removeWhere((int element) => element == -1);
    }
    DateFormat yearDateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeDateFormat = DateFormat("HH:mm:ss.SSS");
    String preferredStartDate =
        "${yearDateFormat.format(darsDate)}T${timeDateFormat.format(DateTime(darsDate.year, darsDate.month, darsDate.day, darsTimeRange!.start.hour, darsTimeRange!.start.minute))}Z";
    String preferredEndDate =
        "${yearDateFormat.format(darsDate)}T${timeDateFormat.format(DateTime(darsDate.year, darsDate.month, darsDate.day, darsTimeRange!.end.hour, darsTimeRange!.end.minute))}Z";
    await _orderDarsRepo
        .addOrEditOrderDars(
      addressId: selectedAddress?.address?.id ?? -1,
      orderStudentsIDs: selectedStudents
          .map((Student student) => student.requesterStudent?.id ?? -1)
          .toList(),
      orderTopicsOrSkillsIDs: selectedTopicsOrSkills,
      sessionTypeId: sessionWay,
      productId:
          orderType == 0 ? 41 : 19, // 41 for one dars, 19 for studying package
      targetGenderId: teacherGender + 1,
      preferredStartDate: preferredStartDate,
      preferredEndDate: preferredEndDate,
      preferredProviderId: chosenTeacher?.preferredProvider?.providerId ?? -1,
      notes: notesController.text,
    )
        .then((int statusCode) async {
      if (statusCode == 200) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        final OrdersController ordersController = Get.find<OrdersController>();
        ordersController.refreshPagingController();
        final HomeController homeController = Get.find<HomeController>();
        await homeController.getMyOrders();
        await Future.delayed(const Duration(milliseconds: 550))
            .then((value) async {
          Get.back();
          CustomSnackBar.showCustomSnackBar(
            title: LocaleKeys.success.tr,
            message: LocaleKeys.order_added_successfully.tr,
          );
        });
      }
    });
  }

  void selectStudent(Student studentItem, bool isChecked) {
    if (isChecked &&
        selectedStudents.firstWhereOrNull((Student student) =>
                (student.requesterStudent?.id ?? -1) ==
                (studentItem.requesterStudent?.id ?? -1)) ==
            null) {
      selectedStudents.add(studentItem);
    } else {
      selectedStudents.removeWhere((Student student) =>
          (student.requesterStudent?.id ?? -1) ==
          (studentItem.requesterStudent?.id ?? -1));
    }
    update();
  }

  void refreshStudentsPagingController() {
    pagingController.refresh();
    update();
  }

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      await getMyStudents(page: pageKey);
    });
  }

  Future getMyStudents({required int page}) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        students =
            await _dependentsRepo.getMyStudents(page: page, perPage: _pageSize);
        final isLastPage = students.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(students);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(students, nextPageKey);
        }
      } else {
        isInternetConnected.value = false;
      }
    } on DioError catch (e) {
      log("getMyStudents DioError ${e.message}");
    }
    update();
  }

  Future<List<PreferredTeacher>> searchTeacher(
      {required String searchValue}) async {
    return teachers = await getDarsTeachers(page: 1, searchValue: searchValue);
  }

  Future<List<PreferredTeacher>> getDarsTeachers({
    required int page,
    required String searchValue,
  }) async {
    List<PreferredTeacher> preferredDarsTeachers = [];
    try {
      if (await checkInternetConnection(timeout: 10)) {
        preferredDarsTeachers = await _darsTeacherRepo.getPreferredTeachers(
          page: 1,
          perPage:
              1000, // there's a restriction on the searchValue length to be at least 3 characters so we can get all the teachers for that searchValue
          searchValue: searchValue,
        );
      } else {
        isInternetConnected.value = false;
      }
    } on DioError catch (e) {
      log("getDarsTeachers DioError ${e.message}");
    }
    return preferredDarsTeachers;
  }

  void selectTeacher(PreferredTeacher teacher) {
    teacherNameController.text = teacher.providerName ?? "";
    chosenTeacher = teacher;
    update();
  }

  Future getMyAddresses() async {
    isAddressDropDownLoading = true;
    update();
    await Future.delayed(const Duration(milliseconds: 500), () async {
      addresses = await _addressesRepo.getAllMyAddresses(
        page: 1,
        perPage: 100,
      );
      if (addresses.isNotEmpty) {
        selectedAddress = addresses.first;
      }
      isAddressDropDownLoading = false;
      update();
    });
  }

  Future showMultiSelectTopics() async {
    final List<String> items = topics.result != null &&
            topics.result!.isNotEmpty
        ? (topics.result!
            .map((topic.Result result) => result.displayName ?? "")).toList()
        : [""];

    final List<String>? results = await Get.dialog(
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 250),
        transitionCurve: Curves.easeInOutBack,
        MultiSelect(
          items: items,
          cancelButtonText: LocaleKeys.cancel.tr,
          submitButtonText: LocaleKeys.save.tr,
          title: LocaleKeys.choose_studying_subjects.tr,
          selectedItems: selectedTopics,
        ));
    if (results != null) {
      selectedTopics = results;
    }
    update();
  }

  void removeTopic(String item) {
    selectedTopics.remove(item);
    update();
  }

  void refreshPagingController() {
    pagingController.refresh();
    update();
  }

  Future deleteStudent({required int studentId}) async {
    if (studentId != -1) {
      if (await checkInternetConnection(timeout: 10)) {
        showLoadingDialog();
        await _dependentsRepo
            .deleteStudent(studentId: studentId)
            .then((int statusCode) {
          if (statusCode == 200) {
            removeStudent(studentId: studentId);
            CustomSnackBar.showCustomSnackBar(
              title: LocaleKeys.success.tr,
              message: LocaleKeys.student_deleted_successfully.tr,
            );
            refreshPagingController();
          }
        });
      } else {
        await Get.toNamed(Routes.CONNECTION_FAILED);
      }
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
        title: LocaleKeys.error.tr,
        message: LocaleKeys.please_choose_a_valid_student_to_delete.tr,
      );
    }
  }

  void removeStudent({Student? studentItem, int? studentId}) {
    if (studentItem == null && studentId == null) {
      return;
    }
    if (studentId != null && studentId != -1) {
      selectedStudents.removeWhere((Student student) =>
          (student.requesterStudent?.id ?? -1) == studentId);
    } else if (studentItem != null) {
      selectedStudents.removeWhere((Student student) =>
          (student.requesterStudent?.id ?? -1) ==
          (studentItem.requesterStudent?.id ?? -1));
    }
    update();
  }

  void removeSkill(String item) {
    selectedSkills.remove(item);
    update();
  }

  Future showMultiSelectSkills() async {
    final List<String> items = skills.result != null &&
            skills.result!.items != null &&
            skills.result!.items!.isNotEmpty
        ? (skills.result!.items!
            .map((skill.Item result) => result.displayName ?? "")).toList()
        : [""];

    final List<String>? results = await Get.dialog(
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 250),
        transitionCurve: Curves.easeInOutBack,
        MultiSelect(
          items: items,
          cancelButtonText: LocaleKeys.cancel.tr,
          submitButtonText: LocaleKeys.save.tr,
          title: LocaleKeys.choose_skills.tr,
          selectedItems: selectedSkills,
        ));
    if (results != null) {
      selectedSkills = results;
    }
    update();
  }

  // void changeLevel(String? result) {
  //   if (classes.result != null &&
  //       classes.result!.items != null &&
  //       result != null) {
  //     for (var level in classes.result!.items ?? <level.Item>[]) {
  //       if (level.displayName != null &&
  //           level.displayName!.toLowerCase() == result.toLowerCase()) {
  //         selectedClass = level;
  //       }
  //     }
  //   }
  //   update();
  // }

  String? validateDarsDate(String? darsDate) {
    if (darsDate != null && darsDate.isNotEmpty) {
      DateTime tempDateTime =
          DateFormat("dd MMMM yyyy", "ar_SA").parse(darsDate);
      if (darsDate.isEmpty) {
        darsDateErrorIconColor = Colors.red;
        update();
        return LocaleKeys.please_enter_dars_date.tr;
      } else if (!tempDateTime.isAtMaximumYears(1)) {
        darsDateErrorIconColor = Colors.red;
        update();
        return LocaleKeys.check_dars_date.tr;
      } else {
        darsDateErrorIconColor = null;
      }
      // 2023-02-21T08:40:00 is in the format: yyyy-MM-ddTHH:mm:ss
    } else {
      darsDateErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_dars_date.tr;
    }
    update();
    return null;
  }

  String? validateDarsTime(String? darsTime) {
    if (darsTime != null && darsTime.isNotEmpty) {
      darsTimeErrorIconColor = null;
    } else {
      darsTimeErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_dars_date.tr;
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

  Future changeAddress(String? result) async {
    if (addresses.isNotEmpty && result != null) {
      for (var address in addresses) {
        if (address.countryName != null &&
                address.governorateName != null &&
                address.localityName != null
            ? "${address.countryName ?? ""} - ${address.governorateName ?? ""} - ${address.localityName ?? ""}"
                    .toLowerCase() ==
                result.toLowerCase()
            : "${address.countryName ?? ""}${address.governorateName ?? ""}${address.localityName ?? ""}"
                    .toLowerCase() ==
                result.toLowerCase()) {
          selectedAddress = address;
        }
      }
    }
    update();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        await Future.wait([
          _getClasses(),
          _getTopics(),
          _getSkills(),
          getMyAddresses(),
        ]).then((value) => isLoading.value = false);
      }
    });
  }

  Future _getClasses() async {
    classes = await _orderDarsRepo.getClasses();
    // if (classes.result != null && classes.result!.items != null) {
    //   classes.result!.items!.insert(
    //     0,
    //     level.Item(
    //       id: -1,
    //       displayName: LocaleKeys.choose_studying_class.tr,
    //     ),
    //   );
    // }
  }

  Future _getTopics() async {
    topics = await _orderDarsRepo.getTopics();
  }

  Future _getSkills() async {
    skills = await _orderDarsRepo.getSkills();
  }

  void changeSessionWay(int value) {
    sessionWay = value;
    update();
  }

  void changeDarsCategory(int value) {
    darsCategory = value;
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
