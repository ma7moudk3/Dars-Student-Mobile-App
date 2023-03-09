import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:intl/intl.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/cache_helper.dart';
import '../../../data/models/classes/classes.dart';
import '../../home/data/models/dars_order.dart';
import '../../order_dars/data/repos/order_dars_repo.dart';
import '../../order_dars/data/repos/order_dars_repo_implement.dart';
import '../../teacher_details/data/repos/teacher_details_repo.dart';
import '../../teacher_details/data/repos/teacher_details_repo_implement.dart';
import '../data/models/order_details/order_details.dart';
import '../data/repos/order_details_repo.dart';
import '../data/repos/order_details_repo_implement.dart';

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
    // },
  ];
  DarsOrder darsOrder = Get.arguments ?? DarsOrder();
  final TeacherDetailsRepo _teacherDetailsRepo = TeacherDetailsRepoImplement();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController cancelReasonController;
  Classes classes = Classes();
  bool isPreferredTeacherFavorite = false;
  final OrderDarsRepo _orderDarsRepo = OrderDarsRepoImplement();
  final OrderDetailsRepo _darsDetailsRepoImplement =
      OrderDetailsRepoImplement();
  OrderDetails darsOrderDetails = OrderDetails();
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  @override
  void onInit() async {
    cancelReasonController = TextEditingController();
    await checkInternet();
    super.onInit();
  }

  void initOrderProperties() {
    DateTime preferredStartDate = DateFormat('yyyy-MM-dd').parse(
        (darsOrderDetails.result?.order?.preferredStartDate ?? '')
            .split("T")[0]);
    DateTime preferredStartTime = DateFormat('HH:mm:ss').parse(
        (darsOrderDetails.result?.order?.preferredStartDate ?? '')
            .split("T")[1]);
    DateTime preferredEndDate = DateFormat('yyyy-MM-dd').parse(
        (darsOrderDetails.result?.order?.preferredEndDate ?? '').split("T")[0]);
    DateTime preferredEndTime = DateFormat('HH:mm:ss').parse(
        (darsOrderDetails.result?.order?.preferredEndDate ?? '').split("T")[1]);
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
        darsOrderDetails.result?.order?.sessionTypeId == 0
            ? LocaleKeys.face_to_face.tr
            : darsOrderDetails.result?.order?.sessionTypeId == 1
                ? LocaleKeys.electronic.tr
                : LocaleKeys.both.tr;
    orderProperties[3]["content"] = darsOrderDetails.result?.productName ?? "";
    orderProperties.last["content"] =
        darsOrderDetails.result?.address?.addressDetails?.name ?? "";
    update();
  }

  Future<void> toggleTeacherFavorite() async {
    if (CacheHelper.instance.authenticated()) {
      isPreferredTeacherFavorite = !isPreferredTeacherFavorite;
      update();
      if (isPreferredTeacherFavorite == true) {
        await _teacherDetailsRepo.addTeacherToFavorite(
          teacherId: darsOrderDetails.result?.order?.preferredproviderId ?? -1,
        );
      } else {
        await _teacherDetailsRepo.removeTeacherFromFavorite(
          teacherId: darsOrderDetails.result?.order?.preferredproviderId ?? -1,
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

  Future getOrderDetails() async {
    if (darsOrder.id != null) {
      darsOrderDetails = await _darsDetailsRepoImplement.getDarsOrderDetails(
          darsOrder: darsOrder.id!);
    }
    isPreferredTeacherFavorite = darsOrderDetails.result != null &&
        darsOrderDetails.result!.order != null &&
        darsOrderDetails.result!.order!.preferredproviderId != null;
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
