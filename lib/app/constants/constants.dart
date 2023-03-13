import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import '../data/cache_helper.dart';

const applicationName = "دَرْس - الطالب";

List<int> darsProductTypes = [19, 41];
// 19 is for studying package, 41 is for one dars, if another product id is added, add it to darsProductTypes list ..

enum SessionStatus { notStarted, inProgress, paused, completed, cancelled }

enum OrderStatus {
  submitted,
  confirmed,
  started,
  tempPaused,
  completed,
  cancelled
}

enum DarsCategory { skills, academicTopics }

enum PaymentStatus { fullyPaid, partiallyPaid, unPaid }

enum CardType { visaCard, masterCard, madaCard }

List<String> months = [
  LocaleKeys.january.tr,
  LocaleKeys.february.tr,
  LocaleKeys.march.tr,
  LocaleKeys.april.tr,
  LocaleKeys.may.tr,
  LocaleKeys.june.tr,
  LocaleKeys.july.tr,
  LocaleKeys.august.tr,
  LocaleKeys.september.tr,
  LocaleKeys.october.tr,
  LocaleKeys.november.tr,
  LocaleKeys.december.tr,
];

Map<String, dynamic> headers = {
  'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
};
