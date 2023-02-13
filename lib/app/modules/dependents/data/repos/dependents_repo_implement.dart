import 'package:hessa_student/app/modules/dependents/data/models/student/student.dart';
import 'package:hessa_student/app/modules/dependents/data/repos/dependents_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../../../../data/network_helper/dio_helper.dart';

class DependentsRepoImplement extends DependentsRepo {
  @override
  Future<List<Student>> getMyStudents({
    required int perPage,
    required int page,
  }) async {
    List<Student> myStudents = [];
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
    };
    Map<String, dynamic> queryParameters = {
      "SkipCount": (page - 1) * perPage,
      "MaxResultCount": perPage,
    };
    await DioHelper.get(
      headers: headers,
      Links.getAllMyStudents,
      queryParameters: queryParameters,
      onSuccess: (response) {
        var result = response.data;
        if (result != null &&
            result["result"] != null &&
            result["result"]["items"] != null) {
          for (var student in result["result"]["items"]) {
            myStudents.add(Student.fromJson(student));
          }
        }
      },
      onError: (error) {
        CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.error.tr,
          message: error.response?.data["error"]["message"] ?? error.message,
        );
      },
    );
    return myStudents;
  }
}
