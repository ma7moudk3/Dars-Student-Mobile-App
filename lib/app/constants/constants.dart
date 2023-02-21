import 'package:get/get.dart';

import '../../generated/locales.g.dart';

const applicationName = "حصة - الطالب";

enum HessaType { oneHessa, studyingPackage }

enum HessaStatus { confirmed, started, canceled, finished }

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