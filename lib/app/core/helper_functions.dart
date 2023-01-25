import 'dart:developer';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

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

Future<String> getTranslation({required String text}) async {
  if (await checkInternetConnection(timeout: 10)) {
    GoogleTranslator translator = GoogleTranslator();
    Translation translation =
        await translator.translate(text, to: Get.locale!.languageCode);
    String translatedText = translation.text;
    return translatedText;
  }
  return "";
}

Future<bool> checkInternetConnection({required int timeout}) async {
  try {
    final result = await InternetAddress.lookup('www.google.com')
        .timeout(Duration(seconds: timeout));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    log('not connected');
  }
  return false;
}
