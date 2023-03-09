import 'dart:developer';

import 'package:get/get.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/order_details/controllers/order_details_controller.dart';
import 'package:hessa_student/app/modules/teacher_details/data/models/teacher_details/dars_teacher_details.dart';
import 'package:hessa_student/app/modules/teacher_details/data/models/teacher_details/provider_skill.dart';
import 'package:hessa_student/app/modules/teacher_details/data/repos/teacher_details_repo.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/images_manager.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../data/models/teacher_details/provider_teaching_topic.dart';
import '../data/repos/teacher_details_repo_implement.dart';

class TeacherDetailsController extends GetxController {
  int currentStar = -1;
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  bool? isFavorite;
  int teacherId = Get.arguments["teacherId"] ?? -1;
  // accept candidate provider (teacher) for order
  int? orderIdForAccept = Get.arguments?["orderId"];
  final TeacherDetailsRepo _teacherDetailsRepo = TeacherDetailsRepoImplement();
  DarsTeacherDetails darsTeacherDetails = DarsTeacherDetails();
  List<Map<String, dynamic>> teacherProperties = [
    // {
    //   "icon": ImagesManager.flagIcon,
    //   "title": LocaleKeys.education_level.tr,
    // },
    // {
    //   "icon": ImagesManager.bagIcon,
    //   "title": LocaleKeys.major.tr,
    // },
    {
      "icon": ImagesManager.bookIcon,
      "title": LocaleKeys.subjects.tr, // subject= topic
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
          if (darsTeacherDetails.result != null &&
              darsTeacherDetails.result!.providerSkill != null) {
            teacherProperties[0]["content"] = darsTeacherDetails
                .result!.providerTeachingTopic!
                .map((ProviderTeachingTopic providerTeachingTopic) =>
                    providerTeachingTopic.topicName ?? "")
                .toSet()
                .toList()
                .join(", ");
            teacherProperties[1]["content"] = darsTeacherDetails
                .result!.providerTeachingTopic!
                .map((ProviderTeachingTopic providerTeachingTopic) =>
                    providerTeachingTopic.levelName ?? "")
                .toSet()
                .toList()
                .join(", ");
            teacherProperties[2]["content"] = darsTeacherDetails
                .result!.providerSkill!
                .map((ProviderSkill providerSkill) =>
                    providerSkill.skillName ?? "")
                .toSet()
                .toList()
                .join(", ");
          }
          isLoading.value = false;
        });
      }
    });
    update();
  }

  Future<void> toggleFavorite() async {
    if (CacheHelper.instance.authenticated()) {
      isFavorite = !isFavorite!;
      update();
      if (isFavorite == true) {
        await _teacherDetailsRepo.addTeacherToFavorite(
          teacherId: teacherId,
        );
      } else {
        await _teacherDetailsRepo.removeTeacherFromFavorite(
          teacherId: teacherId,
        );
      }
    }
  }

  Future acceptCandidateProvider() async {
    if (orderIdForAccept != null && orderIdForAccept != -1 && teacherId != -1) {
      showLoadingDialog();
      await _teacherDetailsRepo
          .acceptCandidateProviderForOrder(
        orderId: orderIdForAccept!,
        candidateProviderId: teacherId,
      )
          .then((int statusCode) async {
        if (statusCode == 200) {
          OrderDetailsController orderDetailsController =
              Get.find<OrderDetailsController>();
          await orderDetailsController.getOrderDetails().then((value) {
            Get.back();
            CustomSnackBar.showCustomSnackBar(
              title: LocaleKeys.success.tr,
              message: LocaleKeys.candidate_provider_approved_successfully.tr,
            );
          });
        }
      });
    }
  }

  Future getTeacherDetails() async {
    try {
      darsTeacherDetails = await _teacherDetailsRepo.getTeacherDetails(
        teacherId: teacherId,
      );
      if (darsTeacherDetails.result != null) {
        isFavorite = darsTeacherDetails.result!.isPreferred ?? false;
      }
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
