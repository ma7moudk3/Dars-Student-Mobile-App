import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';

import 'package:intl/intl.dart';

import '../constants/exports.dart';

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

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}
