import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_features/theme_manager.dart';

import 'app/data/cache_helper.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.instance.init();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: "Hessa Student App",
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          locale: const Locale("ar"),
          theme: getApplicationTheme(),
          translationsKeys: AppTranslation.translations,
        );
      },
    ),
  );
}
