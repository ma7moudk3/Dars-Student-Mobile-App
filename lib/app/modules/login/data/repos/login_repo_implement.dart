import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hessa_student/app/modules/login/data/models/login_info/login_info.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../../../../data/network_helper/dio_helper.dart';
import '../models/current_user_info/current_user_info.dart';
import '../models/current_user_profile_info/current_user_profile_info.dart';
import 'login_repo.dart';

class LoginRepoImplement extends LoginRepo {
  @override
  Future<int> login({
    required String login,
    required String password,
  }) async {
    int statusCode = 200;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    Map<String, dynamic> data = {
      "userNameOrEmailAddress": login,
      "password": password,
    };
    if (token != null) {
      data['fcmtoken'] = token;
      await CacheHelper.instance.setFcmToken(token);
    }
    await DioHelper.post(Links.login, data: data, onSuccess: (response) async {
      statusCode = response.statusCode ?? 200;
      LoginInfo loginInfo = LoginInfo.fromJson(response.data);
      if (loginInfo.result != null &&
          loginInfo.result!.accessToken != null &&
          loginInfo.result!.refreshToken != null &&
          loginInfo.result!.userId != null) {
        await CacheHelper.instance.setAuthed(true);
        await CacheHelper.instance
            .setAccessToken(loginInfo.result!.accessToken!);
        await CacheHelper.instance
            .setRefreshToken(loginInfo.result!.refreshToken!);
        await CacheHelper.instance.setUserId(loginInfo.result!.userId!);
      }
    }, onError: (response) {
      statusCode = response.statusCode ?? 400;
    });
    return statusCode;
  }

  @override
  Future<CurrentUserInfo> getCurrentUserInfo() async {
    CurrentUserInfo currentUserInfo = CurrentUserInfo();
    String accessToken = CacheHelper.instance.getAccessToken();
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    await DioHelper.get(headers: headers, Links.getCurrentUserInfo,
        onSuccess: (response) async {
      currentUserInfo = CurrentUserInfo.fromJson(response.data);
      if (currentUserInfo.result != null) {
        await CacheHelper.instance.setIsPhoneConfirmed(
            currentUserInfo.result!.isPhoneNumberConfirmed ?? false);
        await CacheHelper.instance.setIsEmailConfirmed(
            currentUserInfo.result!.isEmailConfirmed ?? false);
      }
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }, onError: (response) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    });
    return currentUserInfo;
  }

  @override
  Future<CurrentUserProfileInfo> getCurrentUserProfileInfo() async {
    CurrentUserProfileInfo currentUserProfileInfo = CurrentUserProfileInfo();
    String accessToken = CacheHelper.instance.getAccessToken();
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    await DioHelper.get(headers: headers, Links.getCurrentUserProfileInfo,
        onSuccess: (response) async {
      currentUserProfileInfo = CurrentUserProfileInfo.fromJson(response.data);
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }, onError: (response) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    });
    return currentUserProfileInfo;
  }

  @override
  Future<int> googleLogin({
    required String accessToken,
    required String providerKey,
  }) async {
    int statusCode = 200;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    Map<String, dynamic> data = {
      "authProvider": "Google",
      "providerAccessCode": accessToken,
      "providerKey": providerKey,
      "returnUrl": "",
      "singleSignIn": false,
      "userType": 2 // student
    };
    if (token != null) {
      data['fcmtoken'] = token;
      await CacheHelper.instance.setFcmToken(token);
    }
    await DioHelper.post(Links.externalAuthenticate, data: data,
        onSuccess: (response) async {
      statusCode = response.statusCode ?? 200;
      LoginInfo loginInfo = LoginInfo.fromJson(response.data);
      if (loginInfo.result != null &&
          loginInfo.result!.accessToken != null &&
          loginInfo.result!.refreshToken != null &&
          loginInfo.result!.userId != null) {
        await CacheHelper.instance.setAuthed(true);
        await CacheHelper.instance
            .setAccessToken(loginInfo.result!.accessToken!);
        await CacheHelper.instance
            .setRefreshToken(loginInfo.result!.refreshToken!);
        await CacheHelper.instance.setUserId(loginInfo.result!.userId!);
      }
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }, onError: (response) {
      statusCode = response.statusCode ?? 400;
      if (response.response != null) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.error.tr,
          message: response.response!.data['error']['message'] ??
              LocaleKeys.something_went_wrong.tr,
        );
      }
    });

    return statusCode;
  }

  @override
  Future<String> getCurrentUserProfilePicture() async {
    String userPicture = "";
    try {
      Map<String, dynamic> headers = {
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}",
      };
      await DioHelper.get(Links.userProfileImage, headers: headers,
          onSuccess: (response) async {
        userPicture = response.data['result']['profilePicture'];
        await CacheHelper.instance.setUserProfilePicture(userPicture);
      }, onError: (response) {
        log("getCurrentUserProfilePicture error: ${response.response}");
      });
    } catch (e) {
      log("getCurrentUserProfilePicture error: $e");
    }
    return userPicture;
  }
}
