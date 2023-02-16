import 'dart:developer';

import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/global_presentation/global_widgets/custom_snack_bar.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../constants/exports.dart';
import '../../../../data/cache_helper.dart';
import '../models/address_result/address_result.dart';
import 'addresses.repo.dart';

class AddressesRepoImplement extends AddressesRepo {
  @override
  Future<List<AddressResult>> getAllMyAddresses({
    required int page,
    required int perPage,
  }) async {
    List<AddressResult> addresses = [];
    try {
      Map<String, dynamic> queryParameters = {
        // "MaxResultCount": perPage,
        // "SkipCount": (page - 1) * perPage,
      };
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        headers: headers,
        queryParameters: queryParameters,
        Links.allMyAddresses,
        onSuccess: (response) {
          var result = response.data;
          if (result != null && result["result"] != null) {
            for (var address in result["result"]) {
              addresses.add(AddressResult.fromJson(address));
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
    } catch (e) {
      log("getAllMyAddresses DioError $e");
    }
    return addresses;
  }

  @override
  Future<int> deleteAddress({required int addressId}) async {
    int statusCode = 200;
    try {
      Map<String, dynamic> queryParameters = {
        "id": addressId,
      };
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.delete(
        Links.deleteAddress,
        headers: headers,
        queryParameters: queryParameters,
        onSuccess: (response) {
          statusCode = response.statusCode ?? 200;
          if (Get.isDialogOpen!) {
            Get.back();
          }
        },
        onError: (error) {
          statusCode = error.response?.statusCode ?? 500;
          if (Get.isDialogOpen!) {
            Get.back();
          }
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.response?.data["error"]?["message"] ?? error.message,
          );
        },
      );
    } catch (e) {
      statusCode = 500;
      if (Get.isDialogOpen!) {
        Get.back();
      }
      log("deleteAddress DioError $e");
    }
    return statusCode;
  }
}
