import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/data/models/skills/item.dart' as skill;
import 'package:hessa_student/app/modules/order_dars/data/models/order_dars_to_edit/order_dars_to_edit.dart';
import 'package:hessa_student/app/modules/order_details/controllers/order_details_controller.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int? orderIdToEdit = Get.arguments?["orderIdToEdit"];
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
  List<PreferredTeacher> preferredDarsTeachers = [];
  OrderDarsToEdit orderDarsToEdit = OrderDarsToEdit();
  late TextEditingController darsDateController,
      darsTimeController,
      locationController,
      preferredTeacherNameController,
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
  PreferredTeacher? chosenPreferredTeacher;

  @override
  void onInit() async {
    darsDateController = TextEditingController();
    darsDateRangeController = DateRangePickerController();
    darsTimeController = TextEditingController();
    locationController = TextEditingController();
    preferredTeacherNameController = TextEditingController();
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
        (addresses.isNotEmpty && addresses.first != selectedAddress) ||
        selectedStudents.isNotEmpty ||
        selectedTopics.isNotEmpty ||
        selectedSkills.isNotEmpty ||
        sessionWay != 0 ||
        darsCategory != 0 ||
        orderType != 0 ||
        teacherGender != 0 ||
        preferredTeacherNameController.text.isNotEmpty ||
        notesController.text.isNotEmpty ||
        chosenPreferredTeacher != null;
  }

  @override
  void dispose() {
    darsDateController.dispose();
    darsDateRangeController.dispose();
    darsTimeController.dispose();
    locationController.dispose();
    preferredTeacherNameController.dispose();
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

  Future addOrEditOrderDars() async {
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
      currencyId: orderDarsToEdit.result?.order?.currencyId,
      paymentMethodId: orderDarsToEdit.result?.order?.paymentMethodId,
      providerId: orderDarsToEdit.result?.order?.providerId,
      rate: orderDarsToEdit.result?.order?.rate,
      rateNotes: orderDarsToEdit.result?.order?.rateNotes,
      preferredProviderId:
          chosenPreferredTeacher?.preferredProvider?.providerId ?? -1,
      notes: notesController.text,
      id: orderIdToEdit,
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
        if (Get.isRegistered<OrderDetailsController>()) {
          final OrderDetailsController orderDetailsController =
              Get.find<OrderDetailsController>();
          await orderDetailsController.getOrderDetails();
        }
        await Future.delayed(const Duration(milliseconds: 550))
            .then((value) async {
          Get.back();
          CustomSnackBar.showCustomSnackBar(
            title: LocaleKeys.success.tr,
            message: orderIdToEdit != null && orderIdToEdit != -1
                ? LocaleKeys.order_edited_successfully.tr
                : LocaleKeys.order_added_successfully.tr,
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

  Future getMyStudents({required int page, int? pageSize}) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        students = await _dependentsRepo.getMyStudents(
            page: page, perPage: pageSize ?? _pageSize);
        final isLastPage = students.length < (pageSize ?? _pageSize);
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
    return teachers =
        await getDarsPreferredTeachers(page: 1, searchValue: searchValue);
  }

  Future<List<PreferredTeacher>> getDarsPreferredTeachers({
    required int page,
    required String searchValue,
  }) async {
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

  void selectTeacher(PreferredTeacher? teacher) {
    preferredTeacherNameController.text = teacher?.providerName ?? "";
    chosenPreferredTeacher = teacher;
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
      log("addresses ${addresses.length}");
      isAddressDropDownLoading = false;
    });
    update();
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
        isLoading.value = true;
        List<Future> futures = [
          getClasses(),
          getTopics(),
          getSkills(),
          getMyAddresses(),
        ];
        await Future.wait(futures).then((value) async {
          if (orderIdToEdit != null && orderIdToEdit != -1) {
            await getMyStudents(page: 1, pageSize: 100).then((value) async {
              await getDarsPreferredTeachers(page: 1, searchValue: "")
                  .then((value) async {
                await getOrderToEdit().then((value) => isLoading.value = false);
              });
            });
          } else {
            isLoading.value = false;
          }
        });
        update();
      }
    });
  }

  Future getOrderToEdit() async {
    if (orderIdToEdit != null && orderIdToEdit != -1) {
      await _orderDarsRepo
          .getOrderDarsToEdit(orderDarsToEditId: orderIdToEdit!)
          .then((OrderDarsToEdit orderDarsToEdit) {
        this.orderDarsToEdit = orderDarsToEdit;
        log("addreses ${addresses.length}");
        selectedAddress = addresses.firstWhereOrNull(
          (AddressResult address) {
            return (address.address?.id ?? -1) ==
                (orderDarsToEdit.result?.order?.addressId ?? 0);
          },
        );
        selectedStudents = students.where((Student student) {
          return (orderDarsToEdit.result?.order?.orderStudentId ?? [])
              .contains(student.requesterStudent?.id ?? -1);
        }).toList();
        update();
        // 19 is for studying package, 41 is for one dars
        orderType =
            (orderDarsToEdit.result?.order?.productId ?? 0) == 41 ? 0 : 1;
        sessionWay = orderDarsToEdit.result?.order?.sessionTypeId ??
            0; // 0 is for face to face, 1 is for online, 2 is for both
        teacherGender =
            (orderDarsToEdit.result?.order?.targetGenderId ?? 1) - 1;
        // darsCategory = orderDarsToEdit.result?.order?.darsCategoryId ?? 0; // TODO: get darsCategory
        //TODO: check darsCategory >> // 0 academic learning, 1 skills
        if (darsCategory == 0) {
          selectedTopics = (topics.result ?? <topic.Result>[])
              .where((topic.Result topic) {
                return (orderDarsToEdit.result?.order?.orderTopicOrSkillId ??
                        [])
                    .contains(topic.id ?? -1);
              })
              .toList()
              .map((topic.Result topic) {
                return topic.displayName ?? "";
              })
              .toList();
        } else {
          selectedSkills = (skills.result?.items ?? <skill.Item>[])
              .where((skill.Item skill) {
                return (orderDarsToEdit.result?.order?.orderTopicOrSkillId ??
                        [])
                    .contains(skill.id ?? -1);
              })
              .toList()
              .map((skill.Item skill) {
                return skill.displayName ?? "";
              })
              .toList();
        }
        darsDate = DateTime.parse(
            orderDarsToEdit.result?.order?.preferredStartDate ??
                ""); // or preferredEndDate
        darsDateController.text =
            DateFormat("dd MMMM yyyy", "ar_SA").format(darsDate);
        DateTime preferredStartDate = DateTime.parse(
            orderDarsToEdit.result?.order?.preferredStartDate ?? "");
        DateTime preferredEndDate = DateTime.parse(
            orderDarsToEdit.result?.order?.preferredEndDate ?? "");
        darsTimeRange = TimeRangeResult(
          TimeOfDay(
            hour: preferredStartDate.hour,
            minute: preferredStartDate.minute,
          ),
          TimeOfDay(
            hour: preferredEndDate.hour,
            minute: preferredEndDate.minute,
          ),
        );
        String formattedFromTime = DateFormat.jm('ar_SA').format(DateTime(
            preferredStartDate.year,
            preferredStartDate.month,
            preferredStartDate.day,
            darsTimeRange?.start.hour ?? 0,
            darsTimeRange?.start.minute ?? 0));
        String formattedToTime = DateFormat.jm('ar_SA').format(DateTime(
            preferredEndDate.year,
            preferredEndDate.month,
            preferredEndDate.day,
            darsTimeRange?.end.hour ?? 0,
            darsTimeRange?.end.minute ?? 0));
        darsTimeController.text = "$formattedFromTime - $formattedToTime";
        notesController.text = orderDarsToEdit.result?.order?.notes ?? "";
        chosenPreferredTeacher = preferredDarsTeachers
            .firstWhereOrNull((PreferredTeacher preferredTeacher) {
          return (orderDarsToEdit.result?.order?.preferredproviderId ?? -1) ==
              (preferredTeacher.preferredProvider?.providerId ?? 0);
        });
        preferredTeacherNameController.text =
            chosenPreferredTeacher?.providerName ?? "";
      });
    }
    update();
  }

  Future getClasses() async {
    classes = await _orderDarsRepo.getClasses();
    update();
  }

  Future getTopics() async {
    topics = await _orderDarsRepo.getTopics();
    update();
  }

  Future getSkills() async {
    skills = await _orderDarsRepo.getSkills();
    update();
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
