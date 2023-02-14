import 'dart:developer';

import 'package:hessa_student/app/data/models/countries/countries.dart';
import 'package:hessa_student/app/data/models/governorates/governorates.dart';
import 'package:hessa_student/app/data/models/localities/localities.dart';
import 'package:hessa_student/app/modules/add_new_address/data/repos/add_new_address_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../../../../data/network_helper/dio_helper.dart';

class AddNewAddressRepoImplement extends AddNewAddressRepo {
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
            message: error.response?.data["error"]?["message"] ?? error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getCountries: $e");
    }
    return countries;
  }

  @override
  Future<Governorates> getGovernorates({required int countryId}) async {
    Governorates governorates = Governorates();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      Map<String, dynamic> queryParameters = {"Id": countryId};
      await DioHelper.get(
        Links.governoratesForDropDown,
        headers: headers,
        queryParameters: queryParameters,
        onSuccess: (response) {
          if (Get.isDialogOpen!) {
            Get.back();
          }
          var result = response.data;
          governorates = Governorates.fromJson(result);
        },
        onError: (error) {
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
      if (Get.isDialogOpen!) {
        Get.back();
      }
      log("Error in getGovernorates: $e");
    }
    return governorates;
  }

  @override
  Future<Localities> getLocalities({required int governorateId}) async {
    Localities localities = Localities();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      Map<String, dynamic> queryParameters = {"Id": governorateId};
      await DioHelper.get(
        Links.localitiesForDropDown,
        headers: headers,
        queryParameters: queryParameters,
        onSuccess: (response) {
          if (Get.isDialogOpen!) {
            Get.back();
          }
          var result = response.data;
          localities = Localities.fromJson(result);
        },
        onError: (error) {
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
      if (Get.isDialogOpen!) {
        Get.back();
      }
      log("Error in getLocalities: $e");
    }
    return localities;
  }

  @override
  Future<int> addNewAddress({
    required String address,
    required String addressDescription,
    required int countryId,
    required int governorateId,
    required int localityId,
  }) async {
    int statusCode = 200;
    try {
      Map<String, dynamic> data = {
        "address1": addressDescription,
        "countryId": countryId,
        "governorateId": governorateId,
        "localityId": localityId,
        "nameL": address,
        "nameF": address,
        "name": address,
        "isDefault": true,
      };
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.post(
        Links.addNewAddress,
        data: data,
        headers: headers,
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
            message: error.message,
          );
        },
      );
    } catch (error) {
      log("Error in addNewAddress: $error");
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
    return statusCode;
  }
}
