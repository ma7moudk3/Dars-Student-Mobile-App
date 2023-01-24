import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_features/theme_manager.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Hessa App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: const Locale("ar"),
      theme: getApplicationTheme(),
      translationsKeys: AppTranslation.translations,
    ),
  );
}
