import 'dart:developer';

import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';
import 'package:hessa_student/app/data/models/skills/skills.dart';
import 'package:hessa_student/app/data/models/classes/classes.dart';
import 'package:hessa_student/app/modules/order_hessa/data/repos/order_hessa_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../../../../data/network_helper/dio_helper.dart';

class OrderHessaRepoImplement extends OrderHessaRepo {
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
  Future<int> addOrEditOrderHessa({
    required int targetGenderId,
    String? notes,
    required String preferredStartDate,
    required String preferredEndDate,
    required int sessionTypeId,
    required int productId,
    int? providerId,
    int? preferredProviderId,
    required int addressId,
    required List<int> orderStudentsIDs,
    required List<int> orderTopicsOrSkillsIDs,
    int? id,
    int? paymentMethodId,
    double? rate,
    String? rateNotes,
    int? currencyId,
  }) async {
    int statusCode = 200;
    try {
      Map<String, dynamic> data = {
        "targetGenderId": targetGenderId,
        "currentStatusId": 0,
        "predictionCost": 0,
        "actualCost": 0,
        "totalPayments": 0,
        "preferredStartDate": preferredStartDate,
        "preferredEndDate": preferredEndDate,
        "sessionTypeId": sessionTypeId,
        "productId": productId,
        "providerId": 0, // all
        "requesterId": 0,
        "addressId": addressId,
        "orderStudentId": orderStudentsIDs,
        "orderTopicOrSkillId": orderTopicsOrSkillsIDs,
      };
      if (paymentMethodId != null) {
        data["paymentMethodId"] = paymentMethodId;
      }
      if (notes != null) {
        data["notes"] = notes;
      }
      if (providerId != null) {
        data["providerId"] = providerId;
      }
      if (rate != null) {
        data["rate"] = rate;
      }
      if (rateNotes != null) {
        data["rateNotes"] = rateNotes;
      }
      if (currencyId != null) {
        data["currencyId"] = currencyId;
      }
      if (id != null) {
        data["id"] = id; // if editing an existing order hessa
      }
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.post(
        headers: headers,
        Links.addOrEditOrderHessa,
        onSuccess: (response) {
          statusCode = response.statusCode ?? 200;
        },
        onError: (error) {
          statusCode = error.response?.statusCode ?? 200;
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("addOrEditOrderHessa error $e");
    }
    return statusCode;
  }
}
