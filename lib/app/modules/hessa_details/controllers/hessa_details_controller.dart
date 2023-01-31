import 'package:hessa_student/app/constants/constants.dart';
import 'package:hessa_student/app/constants/exports.dart';

import '../../../../generated/locales.g.dart';

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
  HessaType hessaType = Get.arguments != null
      ? Get.arguments["hessa_type"] ?? HessaType.oneHessa
      : HessaType.oneHessa;

  @override
  void onClose() {}
}
