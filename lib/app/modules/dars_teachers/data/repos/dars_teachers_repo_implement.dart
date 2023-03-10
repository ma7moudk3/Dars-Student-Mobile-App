import 'dart:developer';

import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/data/models/classes/classes.dart';
import 'package:hessa_student/app/data/models/countries/countries.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';
import 'package:hessa_student/app/data/models/skills/skills.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../models/dars_teacher.dart';
import 'dars_teachers_repo.dart';

class DarsTeachersRepoImplement extends DarsTeachersRepo {
  @override
  Future<List<DarsTeacher>> getDarsTeachers({
    String? searchValue,
    String? sortingField,
    String? sortingOrder,
    int? genderId,
    int? countryId,
    int? governorateId,
    int? levelId,
    int? topicId,
    int? skillId,
    required int page,
    required int perPage,
  }) async {
    List<DarsTeacher> darsTeachers = [];
    String? sorting;
    Map<String, dynamic> queryParameters = {
      "OrderId": 0,
      "SkipCount": (page - 1) * perPage,
      "MaxResultCount": perPage,
    };
    if (searchValue != null && searchValue.isNotEmpty) {
      queryParameters["Filter"] = searchValue;
    }
    if (sortingField != null && sortingOrder != null) {
      sorting = "$sortingField $sortingOrder"; // example: "rate DESC"
      queryParameters["Sorting"] = sorting;
    }
    if (genderId != null) {
      queryParameters["GenderId"] = genderId;
    }
    if (levelId != null) {
      queryParameters["LevelId"] = levelId;
    }
    if (topicId != null) {
      queryParameters["TopicId"] = topicId;
    }
    if (skillId != null) {
      queryParameters["SkillId"] = skillId;
    }
    if (countryId != null) {
      queryParameters["CountryId"] = countryId;
    }
    if (governorateId != null) {
      queryParameters["GovernorateId"] = governorateId;
    }
    Map<String, dynamic> headers = {
      "Accpet": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
    };
    await DioHelper.get(
      Links.getAllDarsTeachers,
      queryParameters: queryParameters,
      headers: headers,
      onSuccess: (response) {
        var result = response.data;
        if (result != null &&
            result["result"] != null &&
            result["result"]["items"] != null) {
          for (var teacher in result["result"]["items"]) {
            darsTeachers.add(DarsTeacher.fromJson(teacher));
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
    return darsTeachers;
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

  @override
  Future<Classes> getClasses() async {
    Classes classes = Classes();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        Links.classesForDropDown,
        headers: headers,
        onSuccess: (response) {
          var result = response.data;
          classes = Classes.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getClasses: $e");
    }
    return classes;
  }

  @override
  Future<Skills> getSkills() async {
    Skills skills = Skills();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        Links.skillsForDropDown,
        headers: headers,
        onSuccess: (response) {
          var result = response.data;
          skills = Skills.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getSkills: $e");
    }
    return skills;
  }

  @override
  Future<Topics> getTopics() async {
    Topics topics = Topics();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        Links.topicsForDropDown,
        headers: headers,
        onSuccess: (response) {
          var result = response.data;
          topics = Topics.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getTopics: $e");
    }
    return topics;
  }
}
