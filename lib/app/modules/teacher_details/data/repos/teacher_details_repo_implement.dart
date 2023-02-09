import 'dart:developer';

import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/teacher_details/data/models/hessa_teacher_details/hessa_teacher_details.dart';
import 'package:hessa_student/app/modules/teacher_details/data/repos/teacher_details_repo.dart';

import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';

class TeacherDetailsRepoImplement extends TeacherDetailsRepo {
  @override
  Future<HessaTeacherDetails> getTeacherDetails({
    required int teacherId,
  }) async {
    HessaTeacherDetails hessaTeacherDetails = HessaTeacherDetails();
    Map<String, dynamic> queryParameters = {
          "id": teacherId,
        },
        headers = {
          'Accept-Language':
              Get.locale != null ? Get.locale!.languageCode : 'ar',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.instance.getAccessToken()}',
        };
    await DioHelper.get(
      Links.getHessaTeacher,
      queryParameters: queryParameters,
      headers: headers,
      onSuccess: (response) {
        hessaTeacherDetails = HessaTeacherDetails.fromJson(response.data);
      },
      onError: (error) {
        log("getTeacherDetails error: $error");
      },
    );
    return hessaTeacherDetails;
  }
}
