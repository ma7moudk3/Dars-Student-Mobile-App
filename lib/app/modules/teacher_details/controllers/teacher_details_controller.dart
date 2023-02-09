import 'dart:developer';

import 'package:get/get.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/hessa_teachers/data/models/hessa_teacher.dart';
import 'package:hessa_student/app/modules/teacher_details/data/models/hessa_teacher_details/hessa_teacher_details.dart';
import 'package:hessa_student/app/modules/teacher_details/data/models/hessa_teacher_details/provider_skill.dart';
import 'package:hessa_student/app/modules/teacher_details/data/repos/teacher_details_repo.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/images_manager.dart';
import '../data/models/hessa_teacher_details/provider_teaching_topic.dart';
import '../data/repos/teacher_details_repo_implement.dart';

class TeacherDetailsController extends GetxController {
  int currentStar = -1;
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  HessaTeacher hessaTeacher = Get.arguments != null
      ? Get.arguments["teacher"] ?? HessaTeacher()
      : HessaTeacher();
  int teacherId = int.parse(Get.arguments != null
      ? Get.arguments["teacher"] != null
          ? Get.arguments["teacher"].id.toString()
          : "-1"
      : "-1");
  final TeacherDetailsRepo _teacherDetailsRepo = TeacherDetailsRepoImplement();
  HessaTeacherDetails hessaTeacherDetails = HessaTeacherDetails();
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
      "title": LocaleKeys.skills.tr,
    },
  ];

  @override
  void onInit() async {
    await checkInternet();
    super.onInit();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        await getTeacherDetails().then((value) {
          if (hessaTeacherDetails.result != null &&
              hessaTeacherDetails.result!.providerSkill != null) {
            teacherProperties[2]["content"] = hessaTeacherDetails
                .result!.providerTeachingTopic!
                .map((ProviderTeachingTopic providerTeachingTopic) =>
                    providerTeachingTopic.topicName ?? "")
                .join(", ");
            teacherProperties[3]["content"] = hessaTeacherDetails
                .result!.providerTeachingTopic!
                .map((ProviderTeachingTopic providerTeachingTopic) =>
                    providerTeachingTopic.levelName ?? "")
                .join(", ");
            teacherProperties[4]["content"] = hessaTeacherDetails
                .result!.providerSkill!
                .map((ProviderSkill providerSkill) =>
                    providerSkill.skillName ?? "")
                .join(", ");
          }
          isLoading.value = false;
        });
      }
    });
    update();
  }

  Future getTeacherDetails() async {
    try {
      hessaTeacherDetails = await _teacherDetailsRepo.getTeacherDetails(
        teacherId: teacherId,
      );
    } catch (e) {
      log("getTeacherDetails error: $e");
    }
    update();
  }

  void changeCurrentStar(int value) {
    currentStar = value;
    update();
  }

  @override
  void onClose() {}
}
