import 'dart:developer';

import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/data/models/countries/countries.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../models/hessa_teacher.dart';
import 'hessa_teachers_repo.dart';

class HessaTeachersRepoImplement extends HessaTeachersRepo {
  @override
  Future<List<HessaTeacher>> getHessaTeachers({
    String? searchValue,
    required int page,
    required int perPage,
  }) async {
    List<HessaTeacher> hessaTeachers = [];
    Map<String, dynamic> queryParameters = {
      "Filter": searchValue,
      "OrderId": 0,
      "SkipCount": (page - 1) * perPage,
      "MaxResultCount": perPage,
    };
    Map<String, dynamic> headers = {
      "Accpet": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
    };
    await DioHelper.get(
      Links.getAllHessaTeachers,
      queryParameters: queryParameters,
      headers: headers,
      onSuccess: (response) {
        var result = response.data;
        if (result != null &&
            result["result"] != null &&
            result["result"]["items"] != null) {
          for (var teacher in result["result"]["items"]) {
            hessaTeachers.add(HessaTeacher.fromJson(teacher));
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
    return hessaTeachers;
  }

  @override
  Future<Countries> getCountries() async {
    Countries countries = Countries();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        Links.countriesForDropDown,
        headers: headers,
        onSuccess: (response) {
          var result = response.data;
          countries = Countries.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.response?.data["error"]["message"] ?? error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getCountries: $e");
    }
    return countries;
  }
}
