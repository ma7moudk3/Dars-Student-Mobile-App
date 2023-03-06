import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:intl/intl.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/models/classes/classes.dart';
import '../../home/data/models/hessa_order.dart';
import '../../order_hessa/data/repos/order_hessa_repo.dart';
import '../../order_hessa/data/repos/order_hessa_repo_implement.dart';
import '../data/models/hessa_order_details/hessa_order_details.dart';
import '../data/repos/hessa_details_repo.dart';
import '../data/repos/hessa_details_repo_implement.dart';

class HessaDetailsController extends GetxController {
  List<Map<String, dynamic>> hessaProperties = [
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
    //   "title": LocaleKeys.hessa_duration.tr,
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
  HessaOrder hessaOrder = Get.arguments ?? HessaOrder();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController cancelReasonController;
  Classes classes = Classes();
  final OrderHessaRepo _orderHessaRepo = OrderHessaRepoImplement();
  final HessaDetailsRepo _hessaDetailsRepoImplement =
      HessaDetailsRepoImplement();
  HessaOrderDetails hessaOrderDetails = HessaOrderDetails();
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  @override
  void onInit() async {
    cancelReasonController = TextEditingController();
    await checkInternet();
    super.onInit();
  }

  void initTeacherProperties() {
    DateTime preferredStartDate = DateFormat('yyyy-MM-dd').parse(
        (hessaOrderDetails.result?.order?.preferredStartDate ?? '')
            .split("T")[0]);
    DateTime preferredStartTime = DateFormat('HH:mm:ss').parse(
        (hessaOrderDetails.result?.order?.preferredStartDate ?? '')
            .split("T")[1]);
    DateTime preferredEndDate = DateFormat('yyyy-MM-dd').parse(
        (hessaOrderDetails.result?.order?.preferredEndDate ?? '')
            .split("T")[0]);
    DateTime preferredEndTime = DateFormat('HH:mm:ss').parse(
        (hessaOrderDetails.result?.order?.preferredEndDate ?? '')
            .split("T")[1]);

    hessaProperties[0]["content"] = "${DateFormat.jm('ar_SA').format(
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
    hessaProperties[1]["content"] =
        DateFormat("dd MMMM yyyy", "ar_SA").format(preferredStartDate);
    hessaProperties[2]["content"] =
        hessaOrderDetails.result?.order?.sessionTypeId == 0
            ? LocaleKeys.face_to_face.tr
            : hessaOrderDetails.result?.order?.sessionTypeId == 1
                ? LocaleKeys.electronic.tr
                : LocaleKeys.both.tr;
    hessaProperties[3]["content"] = hessaOrderDetails.result?.productName ?? "";
    hessaProperties.last["content"] =
        hessaOrderDetails.result?.address?.addressDetails?.name ?? "";
    update();
  }

  Future _getClasses() async {
    classes = await _orderHessaRepo.getClasses();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        await Future.wait([
          _getClasses(),
          getHessaOrderDetails(),
        ]).then((value) {
          initTeacherProperties();
          isLoading.value = false;
        });
      }
    });
  }

  Future getHessaOrderDetails() async {
    if (hessaOrder.id != null) {
      hessaOrderDetails = await _hessaDetailsRepoImplement.getHessaOrderDetails(
          hessaOrderId: hessaOrder.id!);
    }
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
