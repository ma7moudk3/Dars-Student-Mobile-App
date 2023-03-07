import 'dart:developer';

import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/teacher_details/data/models/teacher_details/dars_teacher_details.dart';
import 'package:hessa_student/app/modules/teacher_details/data/repos/teacher_details_repo.dart';

import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';

class TeacherDetailsRepoImplement extends TeacherDetailsRepo {
  @override
  Future<DarsTeacherDetails> getTeacherDetails({
    required int teacherId,
  }) async {
    DarsTeacherDetails darsTeacherDetails = DarsTeacherDetails();
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
      Links.getDarsTeacher,
      queryParameters: queryParameters,
      headers: headers,
      onSuccess: (response) {
        darsTeacherDetails = DarsTeacherDetails.fromJson(response.data);
      },
      onError: (error) {
        log("getTeacherDetails error: $error");
      },
    );
    return darsTeacherDetails;
  }

  @override
  Future<int> addTeacherToFavorite({required int teacherId}) async {
    int statusCode = 200;
    Map<String, dynamic> data = {
      "providerId": teacherId,
      "id": 0,
    };
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
    };
    await DioHelper.post(
      Links.addTeacherToFavorite,
      data: data,
      headers: headers,
      onSuccess: (response) {
        statusCode = response.statusCode ?? 200;
      },
      onError: (error) {
        statusCode = error.response?.statusCode ?? 400;
        log("addTeacherToFavorite error: $error");
      },
    );
    return statusCode;
  }

  @override
  Future<int> removeTeacherFromFavorite({required int teacherId}) async {
    int statusCode = 200;
    Map<String, dynamic> queryParameters = {
      "providerId": teacherId,
    };
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
    };
    await DioHelper.delete(
        queryParameters: queryParameters,
        headers: headers,
        Links.removeTeacherFromFavorite, onSuccess: (response) {
      statusCode = response.statusCode ?? 200;
    }, onError: (error) {
      statusCode = error.response?.statusCode ?? 400;
      log("removeTeacherFromFavorite error: $error");
    });
    return statusCode;
  }
}
