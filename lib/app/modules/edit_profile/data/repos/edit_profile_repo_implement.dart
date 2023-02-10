import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/network_helper/dio_helper.dart';
import 'edit_profile_repo.dart';

class EditProfileRepoImplement extends EditProfileRepo {
  @override
  Future updateProfilePicture({required File image}) async {
    try {
      Uuid uuid = const Uuid();
      String fileName = image.path.split("/").last;
      dynamic data = dio.FormData.fromMap({
        "FileType": lookupMimeType(image.path),
        // "FileName": 'ProfilePicture: $fileName',
        "FileName": 'ProfilePicture',
        "FileToken": uuid.v1(),
        "file": await dio.MultipartFile.fromFile(image.path, filename: fileName)
      });
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.put(
        data: data,
        headers: headers,
        Links.updateProfilePicture,
        onSuccess: (response) async {
          if (response.statusCode == 200 && response.data['success'] == true) {
            await updateProfilePicture2(
                fileToken: response.data['result']['fileToken']);
          }
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("updateProfilePicture $e");
    }
  }

  @override
  Future updateProfilePicture2({required String fileToken}) async {
    Map<String, dynamic> data = {
      "fileToken": fileToken,
      "x": 0,
      "y": 0,
      "width": 0,
      "height": 0
    };
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
    };
    await DioHelper.put(
      data: data,
      headers: headers,
      Links.updateProfilePicture2,
      onSuccess: (response) {},
      onError: (error) {
        CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.error.tr,
          message: error.message,
        );
      },
    );
    try {} catch (e) {
      log("updateProfilePicture2 $e");
    }
  }

  @override
  Future<int> updateProfile({
    String? firstName,
    String? surname,
    String? email,
    String? phoneNumber,
    int? gender,
    int? paymentMethodId,
    required int id,
  }) async {
    int statusCode = 200;
    try {
      Map<String, dynamic> data = {
        "id": id,
      };
      if (firstName != null) {
        data["name"] = firstName;
      }
      if (surname != null) {
        data["surname"] = surname;
      }
      if (email != null) {
        data["emailAddress"] = email;
      }
      if (gender != null) {
        data["gender"] = gender;
      }
      if (paymentMethodId != null) {
        data["paymentMethodId"] = paymentMethodId;
      }
      if (phoneNumber != null) {
        data["phoneNumber"] = phoneNumber;
      }
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.post(
        data: data,
        headers: headers,
        Links.updateProfileData,
        onSuccess: (response) {
          statusCode = response.statusCode ?? 200;
        },
        onError: (error) {
          statusCode = error.statusCode ?? 400;
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      statusCode = 400;
      log("updateProfile $e");
    }
    return statusCode;
  }
}
