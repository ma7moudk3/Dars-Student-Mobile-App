import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';

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
      "title": LocaleKeys.hessa_type.tr,
    },
    {
      "icon": ImagesManager.timerIcon,
      "title": LocaleKeys.hessa_duration.tr,
    },
    {
      "icon": ImagesManager.addressIcon,
      "title": LocaleKeys.address.tr,
    },
    {
      "icon": ImagesManager.classIcon,
      "title": LocaleKeys.studying_class.tr,
    },
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

  Future _getClasses() async {
    classes = await _orderHessaRepo.getClasses();
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

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        await Future.wait([
          _getClasses(),
          getHessaOrderDetails(),
        ]).then((value) => isLoading.value = false);
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
