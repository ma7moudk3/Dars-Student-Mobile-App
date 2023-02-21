import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hessa_student/app/constants/constants.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_features/theme_manager.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'app/core/helper_functions.dart';
import 'app/data/cache_helper.dart';
import 'app/data/network_helper/dio_helper.dart';
import 'app/data/network_helper/firebase_cloud_messaging_helper.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  await CacheHelper.instance.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ColorManager.transparent, // transparent status bar
  ));
  await FcmHelper.initFcm();
  DioHelper.init();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            SfGlobalLocalizations.delegate
          ],
          supportedLocales: const <Locale>[Locale("en"), Locale("ar")],
          title: applicationName,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          locale: const Locale("ar"), // it's arabic for right now
          theme: getApplicationTheme(),
          translationsKeys: AppTranslation.translations,
        );
      },
    ),
  );
}
