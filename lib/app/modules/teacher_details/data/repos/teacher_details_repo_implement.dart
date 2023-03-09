import 'dart:developer';

import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/teacher_details/data/models/teacher_details/dars_teacher_details.dart';
import 'package:hessa_student/app/modules/teacher_details/data/repos/teacher_details_repo.dart';

import '../../../../constants/constants.dart';
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

  @override
  Future<int> acceptCandidateProviderForOrder({
    required int candidateProviderId,
    required int orderId,
  }) async {
    int statusCode = 200;
    try {
      Map<String, dynamic> queryParameters = {
        "OrderId": orderId,
        "ProviderId": candidateProviderId,
      };
      await DioHelper.post(
        queryParameters: queryParameters,
        headers: headers,
        Links.acceptCandidateProviderToOrder,
        onSuccess: (response) {
          statusCode = response.statusCode ?? 200;
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
        },
        onError: (error) {
          statusCode = error.response?.statusCode ?? 400;
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
        },
      );
    } catch (e) {
      statusCode = 400;
      log("acceptCandidateProviderForOrder error: $e");
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
    return statusCode;
  }
}
