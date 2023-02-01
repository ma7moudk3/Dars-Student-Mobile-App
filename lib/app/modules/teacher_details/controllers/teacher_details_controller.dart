import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/images_manager.dart';

class TeacherDetailsController extends GetxController {
  int currentStar = -1;

  List<Map<String, dynamic>> teacherProperties = [
    {
      "icon": ImagesManager.flagIcon,
      "title": LocaleKeys.education_level.tr,
    },
    {
      "icon": ImagesManager.bagIcon,
      "title": LocaleKeys.major.tr,
    },
    {
      "icon": ImagesManager.bookIcon,
      "title": LocaleKeys.subjects.tr,
    },
    {
      "icon": ImagesManager.classIcon,
      "title": LocaleKeys.classes.tr,
    },
    {
      "icon": ImagesManager.skillIcon,
      "title": LocaleKeys.skill.tr,
    },
  ];

  void changeCurrentStar(int value) {
    currentStar = value;
    update();
  }

  @override
  void onClose() {}
}
