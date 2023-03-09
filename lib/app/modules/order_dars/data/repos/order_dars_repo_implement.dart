import 'dart:developer';

import 'package:hessa_student/app/constants/constants.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';
import 'package:hessa_student/app/data/models/skills/skills.dart';
import 'package:hessa_student/app/data/models/classes/classes.dart';
import 'package:hessa_student/app/modules/order_dars/data/models/order_dars_to_edit/order_dars_to_edit.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../../../../data/network_helper/dio_helper.dart';
import 'order_dars_repo.dart';

class OrderDarsRepoImplement extends OrderDarsRepo {
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
  Future<int> addOrEditOrderDars({
    required int targetGenderId,
    String? notes,
    required String preferredStartDate,
    required String preferredEndDate,
    required int sessionTypeId,
    required int productId,
    int? providerId = 0,
    int? preferredProviderId,
    required int addressId,
    required List<int> orderStudentsIDs,
    required List<int> orderTopicsOrSkillsIDs,
    int? id,
    int? paymentMethodId,
    int? rate,
    String? rateNotes,
    int? currencyId,
  }) async {
    int statusCode = 200;
    try {
      /*
      session status = dars status
      enum SessionStatus {
        notStarted,
        inProgress,
        paused,
        completed,
        cancelled
      }
      currentStatusId = 0 >> notStarted
      */
      Map<String, dynamic> data = {
        "targetGenderId": targetGenderId,
        "currentStatusId": 0,
        // "predictionCost": 0,
        // "actualCost": 0,
        // "totalPayments": 0,
        "preferredStartDate": preferredStartDate,
        "preferredEndDate": preferredEndDate,
        "sessionTypeId": sessionTypeId,
        "productId": productId,
        "providerId": providerId, // all
        "requesterId": (CacheHelper.instance.getCachedCurrentUserInfo() != null
            ? CacheHelper.instance.getCachedCurrentUserInfo()!.result != null &&
                    CacheHelper.instance
                            .getCachedCurrentUserInfo()!
                            .result!
                            .id !=
                        null
                ? CacheHelper.instance.getCachedCurrentUserInfo()!.result!.id
                : 0
            : 0),
        "paymentMethodId":
            1, // 1 cash, 2 payment gateways, when a payment method is selected, the payment gateway id will be sent
        "addressId": addressId,
        "orderStudentId": orderStudentsIDs,
        "orderTopicOrSkillId": orderTopicsOrSkillsIDs,
      };
      if (preferredProviderId != null && preferredProviderId != -1) {
        data["preferredProviderId"] = preferredProviderId;
      }
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
        data["id"] = id; // if editing an existing order dars
      }
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.post(
        headers: headers,
        data: data,
        Links.addOrEditOrderDars,
        onSuccess: (response) {
          statusCode = response.statusCode ?? 200;
          if (Get.isDialogOpen!) {
            Get.back();
          }
        },
        onError: (error) {
          statusCode = error.response?.statusCode ?? 200;
          if (Get.isDialogOpen!) {
            Get.back();
          }
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("addOrEditOrderDars error $e");
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
    return statusCode;
  }

  @override
  Future<OrderDarsToEdit> getOrderDarsToEdit(
      {required int orderDarsToEditId}) async {
    OrderDarsToEdit orderDarsToEdit = OrderDarsToEdit();
    try {
      Map<String, dynamic> queryParameters = {
        "Id": orderDarsToEditId,
      };
      await DioHelper.get(
        queryParameters: queryParameters,
        headers: headers,
        Links.getOrderForEdit,
        onSuccess: (response) {
          var result = response.data;
          orderDarsToEdit = OrderDarsToEdit.fromJson(result);
        },
        onError: (error) {
          if (Get.isDialogOpen!) {
            Get.back();
          }
        },
      );
    } catch (e) {
      log("getOrderDarsToEdit error $e");
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
    return orderDarsToEdit;
  }
}
