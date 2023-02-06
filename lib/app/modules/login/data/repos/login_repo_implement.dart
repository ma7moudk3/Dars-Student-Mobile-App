import 'dart:developer';

import 'package:hessa_student/app/modules/login/data/models/login_info/login_info.dart';

import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../../../../data/network_helper/dio_helper.dart';
import '../models/current_user_info/current_user_info.dart';
import 'login_repo.dart';

class LoginRepoImplement extends LoginRepo {
  @override
  Future<int> login({
    required String login,
    required String password,
  }) async {
    int statusCode = 200;
    Map<String, dynamic> data = {
      "userNameOrEmailAddress": login,
      "password": password,
    };
    await DioHelper.post(Links.login, data: data, onSuccess: (response) async {
      statusCode = response.statusCode ?? 200;
      LoginInfo loginInfo = LoginInfo.fromJson(response.data);
      if (loginInfo.result != null &&
          loginInfo.result!.accessToken != null &&
          loginInfo.result!.refreshToken != null) {
        await CacheHelper.instance.setAuthed(true);
        log(loginInfo.result!.accessToken ?? 'null');
        await CacheHelper.instance
            .setAccessToken(loginInfo.result!.accessToken!);
        await CacheHelper.instance
            .setRefreshToken(loginInfo.result!.refreshToken!);
      }
      if (Get.isDialogOpen!) {
        Get.back();
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
}
