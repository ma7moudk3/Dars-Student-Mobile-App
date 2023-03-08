import 'package:get/get.dart';

import '../../generated/locales.g.dart';

const applicationName = "دَرْس - الطالب";

List<int> darsProductTypes = [19, 41];
// 19 is for studying package, 41 is for one dars, if another product id is added, add it to darsProductTypes list ..

enum SessionStatus {
  notStarted,
  inProgress,
  paused,
  completed,
  cancelled
}

enum OrderStatus {
  submitted,
  confirmed,
  started,
  tempPaused,
  completed,
  cancelled
}

enum PaymentStatus { fullyPaid, partiallyPaid, unpaid }

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
