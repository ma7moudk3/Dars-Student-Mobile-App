import 'dart:developer';

import 'package:get/get.dart';
import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/technical_support/data/models/urgency_type/result.dart';
import 'package:hessa_student/app/modules/technical_support/data/models/urgency_type/urgency_type.dart';
import 'package:hessa_student/app/modules/technical_support/data/repos/technical_support_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../data/cache_helper.dart';

class TechnicalSupportRepoImplement extends TechnicalSupportRepo {
  @override
  Future<int> sendTechnicalSupportMessage({
    required String fullName,
    required String email,
    required String message,
    required Result urgencyType,
  }) async {
    int statusCode = 200;
    try {
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      Map<String, dynamic> data = {
        'ticketSource': "3",
        'ticketSourceDetails': "",
        'fullName': fullName,
        'email': email,
        'title': urgencyType.displayName ?? "",
        'details': message,
        'urgencyId':
            urgencyType.id ?? 2, // 2 is a problem in hessa message type
      };
      await DioHelper.post(data: data, headers: headers, Links.contactUs,
          onSuccess: (response) {
        statusCode = response.statusCode ?? 200;
        if (Get.isDialogOpen!) {
          Get.back();
        }
      }, onError: (error) {
        statusCode = error.statusCode ?? 400;
        log("TechnicalSupportRepoImplement error: $error");
        if (Get.isDialogOpen!) {
          Get.back();
        }
        CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.error.tr,
          message: error.message,
        );
      });
    } catch (e) {
      statusCode = 400;
      log("TechnicalSupportRepoImplement error: $e");
    }
    return statusCode;
  }

  @override
  Future<UrgencyType> getUrgencyTypes() async {
    UrgencyType urgencyType = UrgencyType();
    try {
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        headers: headers,
        Links.urgencyTypesForDropDown,
        onSuccess: (response) {
          urgencyType = UrgencyType.fromJson(response.data);
        },
        onError: (error) {
          log("getUrgencyTypes error: $error");
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("getUrgencyTypes error: $e");
    }
    return urgencyType;
  }
}
