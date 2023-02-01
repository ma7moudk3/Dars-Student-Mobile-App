import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';

import 'package:intl/intl.dart';

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

Divider moreDivider(
    {double thickness = 1.3, double? height, double opacity = 0.1}) {
  return Divider(
    thickness: thickness,
    height: height,
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
