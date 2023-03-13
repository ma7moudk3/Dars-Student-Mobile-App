import 'dart:developer';

import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/order_details/data/models/order_details/address.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../data/cache_helper.dart';
import '../../../data/models/classes/classes.dart';
import '../../../routes/app_pages.dart';
import '../../home/data/models/dars_order.dart';
import '../../order_dars/data/repos/order_dars_repo.dart';
import '../../order_dars/data/repos/order_dars_repo_implement.dart';
import '../../teacher_details/data/models/teacher_details/dars_teacher_details.dart';
import '../../teacher_details/data/repos/teacher_details_repo.dart';
import '../../teacher_details/data/repos/teacher_details_repo_implement.dart';
import '../data/models/order_details/order_details.dart';
import '../data/models/order_session/order_session.dart';
import '../data/repos/order_details_repo.dart';
import '../data/repos/order_details_repo_implement.dart';
import '../widgets/you_cant_cancel_dars_dialog_content.dart';

class OrderDetailsController extends GetxController {
  List<Map<String, dynamic>> orderProperties = [
    {
      "icon": ImagesManager.clockIocn,
      "title": LocaleKeys.timing.tr,
    },
    {
      "icon": ImagesManager.calendarIcon,
      "title": LocaleKeys.date.tr,
    },
    {
      "icon": ImagesManager.tvIcon,
      "title": LocaleKeys.session.tr,
    },
    {
      "icon": ImagesManager.boardIcon,
      "title": LocaleKeys.dars_type.tr,
    },
    // {
    //   "icon": ImagesManager.timerIcon,
    //   "title": LocaleKeys.dars_duration.tr,
    // },
    {
      "icon": ImagesManager.addressIcon,
      "title": LocaleKeys.address.tr,
    },
    // {
    //   "icon": ImagesManager.classIcon,
    //   "title": LocaleKeys.studying_class.tr,
    {
      "icon": ImagesManager.aboutDarsIcon,
      "title": LocaleKeys.notes.tr,
    },
    // },
  ];
  // Map<int, List<Map<String, dynamic>>> orderPropertiesMap = {};

  DarsOrder darsOrder = Get.arguments ?? DarsOrder();
  final TeacherDetailsRepo _teacherDetailsRepo = TeacherDetailsRepoImplement();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController cancelReasonController;
  Classes classes = Classes();
  bool isPreferredTeacherFavorite = false;
  int? favoriteTeacherId;
  static const _pageSize = 5; // 5 sessions per page
  List<OrderSession> orderSessions = [];
  PagingController<int, OrderSession> pagingController =
      PagingController(firstPageKey: 1); // item = order session
  final OrderDarsRepo _orderDarsRepo = OrderDarsRepoImplement();
  final OrderDetailsRepo _darsDetailsRepoImplement =
      OrderDetailsRepoImplement();
  Rx<OrderDetails> darsOrderDetails = OrderDetails().obs;
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  @override
  void onInit() async {
    cancelReasonController = TextEditingController();
    _initPageRequestListener();
    await checkInternet();
    super.onInit();
  }

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      await getOrderSessions(page: pageKey);
    });
  }

  Future deleteSession({
    required int sessionId,
  }) async {
    if (sessionId != -1) {
      await _darsDetailsRepoImplement
          .deleteSession(
        sessionId: sessionId,
      )
          .then((int statusCode) {
        if (statusCode == 200) {
          CustomSnackBar.showCustomSnackBar(
            title: LocaleKeys.success.tr,
            message: LocaleKeys.session_deleted_successfully.tr,
          );
          pagingController.refresh();
        }
      });
    } else {
      CustomSnackBar.showCustomSnackBar(
        title: LocaleKeys.error.tr,
        message: LocaleKeys.you_cant_delete_this_session.tr,
      );
    }
  }

  void initOrderProperties() {
    DateTime preferredStartDate = DateFormat('yyyy-MM-dd').parse(
        (darsOrderDetails.value.result?.order?.preferredStartDate ?? '')
            .split("T")[0]);
    DateTime preferredStartTime = DateFormat('HH:mm:ss').parse(
        (darsOrderDetails.value.result?.order?.preferredStartDate ?? '')
            .split("T")[1]);
    DateTime preferredEndDate = DateFormat('yyyy-MM-dd').parse(
        (darsOrderDetails.value.result?.order?.preferredEndDate ?? '')
            .split("T")[0]);
    DateTime preferredEndTime = DateFormat('HH:mm:ss').parse(
        (darsOrderDetails.value.result?.order?.preferredEndDate ?? '')
            .split("T")[1]);
    orderProperties[0]["content"] = "${DateFormat.jm('ar_SA').format(
      DateTime(
        preferredStartDate.year,
        preferredStartDate.month,
        preferredStartDate.day,
        preferredStartTime.hour,
        preferredStartTime.minute,
      ),
    )} - ${DateFormat.jm('ar_SA').format(
      DateTime(
        preferredEndDate.year,
        preferredEndDate.month,
        preferredEndDate.day,
        preferredEndTime.hour,
        preferredEndTime.minute,
      ),
    )}";
    orderProperties[1]["content"] =
        DateFormat("dd MMMM yyyy", "ar_SA").format(preferredStartDate);
    orderProperties[2]["content"] =
        darsOrderDetails.value.result?.order?.sessionTypeId == 0
            ? LocaleKeys.face_to_face.tr
            : darsOrderDetails.value.result?.order?.sessionTypeId == 1
                ? LocaleKeys.electronic.tr
                : LocaleKeys.both.tr;
    orderProperties[3]["content"] =
        darsOrderDetails.value.result?.productName ?? "--";
    orderProperties[4]["content"] =
        _formatAddress(darsOrderDetails.value.result?.address);
    orderProperties[5]["content"] =
        darsOrderDetails.value.result?.order?.notes ?? "--";
    update();
  }

  String _formatAddress(Address? address) {
    List<String> addressParts = [];
    if (address == null) {
      return "";
    }
    if (address.countryName != null && address.countryName!.isNotEmpty) {
      addressParts.add(address.countryName!);
    }
    if (address.governorateName != null &&
        address.governorateName!.isNotEmpty) {
      addressParts.add(address.governorateName!);
    }
    if (address.localityName != null && address.localityName!.isNotEmpty) {
      addressParts.add(address.localityName!);
    }
    if (address.addressDetails != null &&
        address.addressDetails!.name != null &&
        address.addressDetails!.name!.isNotEmpty) {
      addressParts.add(address.addressDetails!.name!);
    }
    return addressParts.join(' - ');
  }

  Future<void> toggleTeacherFavorite() async {
    if (CacheHelper.instance.authenticated() &&
        favoriteTeacherId != null &&
        favoriteTeacherId != -1 &&
        favoriteTeacherId != 0) {
      isPreferredTeacherFavorite = !isPreferredTeacherFavorite;
      update();
      if (isPreferredTeacherFavorite == true) {
        await _teacherDetailsRepo.addTeacherToFavorite(
          teacherId: favoriteTeacherId!,
        );
      } else {
        await _teacherDetailsRepo.removeTeacherFromFavorite(
          teacherId: favoriteTeacherId!,
        );
      }
    }
  }

  Future _getClasses() async {
    classes = await _orderDarsRepo.getClasses();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        await Future.wait([
          _getClasses(),
          getOrderDetails(),
        ]).then((value) {
          initOrderProperties();
          isLoading.value = false;
        });
      }
    });
  }

  Future cancelOrder() async {
    showLoadingDialog();
    await _darsDetailsRepoImplement
        .cancelDarsOrder(
      darsOrderId: darsOrder.id ?? -1,
      reason: cancelReasonController.text,
    )
        .then((int statusCode) async {
      if (statusCode == 200) {
        await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
      } else {
        await Get.dialog(
          Container(
            color: ColorManager.black.withOpacity(0.1),
            height: 230.h,
            width: 312.w,
            child: Center(
              child: Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                child: const CannotCancelDarsDialogContent(),
              ),
            ),
          ),
          transitionCurve: Curves.easeInOutBack,
          barrierDismissible: true,
        );
      }
    });
  }

  String? validateCancelReason(String? value) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return LocaleKeys.please_enter_cancel_order_reason.tr;
    } else if (regExp.hasMatch(value)) {
      return LocaleKeys.check_cancel_order_reason.tr;
    }
    update();
    return null;
  }

  String getStudentsCountString(int studentsCount) {
    if (Get.locale!.languageCode == "ar") {
      if (studentsCount == 1) {
        return LocaleKeys.one_student.tr;
      } else if (studentsCount == 2) {
        return LocaleKeys.two_students.tr;
      } else if (studentsCount >= 3 && studentsCount <= 10) {
        return "$studentsCount ${LocaleKeys.students.tr}";
      } else {
        return "$studentsCount ${LocaleKeys.student_count.tr}";
      }
    } else {
      if (studentsCount == 1) {
        return LocaleKeys.one_student.tr;
      } else {
        return "$studentsCount ${LocaleKeys.student.tr}";
      }
    }
  }

  Future getOrderDetails() async {
    if (darsOrder.id != null) {
      await _darsDetailsRepoImplement
          .getDarsOrderDetails(darsOrder: darsOrder.id!)
          .then((OrderDetails orderDetails) async {
        darsOrderDetails.value = orderDetails;
      });
    }
    if (darsOrderDetails.value.result != null &&
        darsOrderDetails.value.result!.order != null &&
        darsOrderDetails.value.result!.order!.providerId != null &&
        darsOrderDetails.value.result!.order!.providerId != 0 &&
        darsOrderDetails.value.result!.order!.providerId != -1) {
      await _teacherDetailsRepo
          .getTeacherDetails(
              teacherId: darsOrderDetails.value.result!.order!.providerId!)
          .then((DarsTeacherDetails teacherDetails) {
        isPreferredTeacherFavorite =
            teacherDetails.result!.isPreferred ?? false;
        favoriteTeacherId = darsOrderDetails.value.result?.order?.providerId;
      });
    } else if (darsOrderDetails.value.result != null &&
        darsOrderDetails.value.result!.order != null &&
        darsOrderDetails.value.result!.order!.preferredproviderId != null) {
      await _teacherDetailsRepo
          .getTeacherDetails(
              teacherId:
                  darsOrderDetails.value.result!.order!.preferredproviderId!)
          .then((DarsTeacherDetails teacherDetails) {
        isPreferredTeacherFavorite =
            teacherDetails.result!.isPreferred ?? false;
        favoriteTeacherId =
            darsOrderDetails.value.result?.order?.preferredproviderId;
      });
    }
    update();
  }

  Future getOrderSessions({
    required int page,
  }) async {
    try {
      if (darsOrder.id != null) {
        orderSessions = await _darsDetailsRepoImplement.getDarsOrderSessions(
            darsOrderId: darsOrder.id!, page: page, perPage: _pageSize);
        final isLastPage = orderSessions.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(orderSessions);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(orderSessions, nextPageKey);
        }
      }
    } on Exception catch (e) {
      log("error in get order sessions $e");
    }
    update();
  }

  @override
  void dispose() {
    cancelReasonController.dispose();
    super.dispose();
  }

  void clearData() {
    cancelReasonController.clear();
    update();
  }

  @override
  void onClose() {}
}
