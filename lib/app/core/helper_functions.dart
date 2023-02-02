import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';

import 'package:intl/intl.dart';

import '../../generated/locales.g.dart';
import '../constants/exports.dart';

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}

String formatTimeOfDay(DateTime? dateAndTime) {
  final format = DateFormat.jm();
  return format.format(dateAndTime!);
}

bool detectLang({required String text}) {
  // String pattern = r'^(?:[a-zA-Z]|\P{L})+$';
  String pattern = r'^(?:[a-zA-Z.,;:!?]|\P{L})+$';
  RegExp regex = RegExp(pattern, unicode: true);
  return regex.hasMatch(text);
}

Future<bool> checkInternetConnection({required int timeout}) async {
  try {
    final result = await InternetAddress.lookup('www.google.com')
        .timeout(Duration(seconds: timeout));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    developer.log('not connected');
    print('not connected: $_');
  }
  return false;
}

Divider moreDivider({
  double thickness = 1.3,
  double? height,
  double opacity = 0.1,
  double? endIndent,
  double? indent,
}) {
  return Divider(
    thickness: thickness,
    height: height,
    endIndent: endIndent,
    indent: indent,
    color: ColorManager.grey5.withOpacity(opacity),
  );
}

bool hasDateExpired(int month, int? year) {
  return year != null && isNotExpired(year, month);
}

bool isNotExpired(int year, int month) {
  // It has not expired if both the year and date has not passed
  return !hasYearPassed(year) && !hasMonthPassed(year, month);
}

List<int> getExpiryDate(String value) {
  var split = value.split(RegExp(r'(\/)'));
  return [int.parse(split[0]), int.parse(split[1])];
}

/// Convert the two-digit year to four-digit year if necessary
int convertYearTo4Digits(int year) {
  if (year < 100 && year >= 0) {
    var now = DateTime.now();
    String currentYear = now.year.toString();
    String prefix = currentYear.substring(0, currentYear.length - 2);
    year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
  }
  return year;
}

bool hasMonthPassed(int year, int month) {
  var now = DateTime.now();
  // The month has passed if:
  // 1. The year is in the past. In that case, we just assume that the month
  // has passed
  // 2. Card's month (plus another month) is less than current month.
  return hasYearPassed(year) ||
      convertYearTo4Digits(year) == now.year && (month < now.month + 1);
}

bool hasYearPassed(int year) {
  int fourDigitsYear = convertYearTo4Digits(year);
  var now = DateTime.now();
  // The year has passed if the year we are currently, is greater than card's
  // year
  return fourDigitsYear < now.year;
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? 'one_week_ago'.tr : 'last_week'.tr;
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} ${"days_ago".tr}';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? 'one_day_ago'.tr : 'yesterday'.tr;
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} ${"hours_ago".tr}';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? 'one_hour_ago'.tr : 'an_hour_ago'.tr;
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} ${"minutes_ago".tr}';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? 'one_minute_ago'.tr : 'a_minute_ago'.tr;
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} ${"seconds_ago".tr}';
    } else {
      return 'just_now'.tr;
    }
  }

  String timeAgoCustom() {
    Duration diff = DateTime.now().difference(this);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? LocaleKeys.year.tr : LocaleKeys.years.tr} ${LocaleKeys.ago.tr}";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? LocaleKeys.month.tr : LocaleKeys.months.tr} ${LocaleKeys.ago.tr}";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? LocaleKeys.week.tr : LocaleKeys.weeks.tr} ${LocaleKeys.ago.tr}";
    }
    if (diff.inDays > 0) return DateFormat.E().add_jm().format(this);
    if (diff.inHours > 0) {
      return "${LocaleKeys.today.tr} ${DateFormat('jm').format(this)}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? LocaleKeys.minute.tr : LocaleKeys.minutes.tr} ${LocaleKeys.ago.tr}";
    }
    return "just_now".tr;
  }
}
