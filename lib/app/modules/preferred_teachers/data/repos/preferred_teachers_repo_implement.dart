import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/preferred_teachers/data/models/preferred_teacher/preferred_teacher.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import 'preferred_teachers_repo.dart';

class PreferredTeachersRepoImplement extends PreferredTeachersRepo {
  @override
  Future<List<PreferredTeacher>> getPreferredTeachers(
      {required int page, required int perPage, String? searchValue}) async {
    List<PreferredTeacher> preferredTeachers = [];
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
    };
    Map<String, dynamic> queryParameters = {
      "MaxResultCount": perPage,
      "SkipCount": (page - 1) * perPage,
    };
    if (searchValue != null) {
      queryParameters["Filter"] = searchValue;
    }
    await DioHelper.get(
      headers: headers,
      Links.preferredTeachers,
      queryParameters: queryParameters,
      onSuccess: (response) {
        var result = response.data;
        if (result != null &&
            result["result"] != null &&
            result["result"]["items"] != null) {
          for (var teacher in result["result"]["items"]) {
            preferredTeachers.add(PreferredTeacher.fromJson(teacher));
          }
        }
      },
      onError: (error) {
        CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.error.tr,
          message: error.response?.data["error"]?["message"] ?? error.message,
        );
      },
    );
    return preferredTeachers;
  }
}
