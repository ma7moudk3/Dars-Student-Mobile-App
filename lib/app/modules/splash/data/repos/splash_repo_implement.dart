import 'dart:developer';

import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/splash/data/models/user_token/user_token.dart';
import 'package:hessa_student/app/modules/splash/data/repos/splash_repo.dart';

class SplashRepoImplement extends SplashRepo {
  @override
  Future<UserToken> refreshToken() async {
    UserToken userToken = UserToken();
    try {
      Map<String, dynamic> queryParameters = {
        "refreshToken": CacheHelper.instance.getRefreshToken(),
      };
      await DioHelper.post(queryParameters: queryParameters, Links.refreshToken,
          onSuccess: (response) async {
        var result = response.data;
        userToken = UserToken.fromJson(result);
        await CacheHelper.instance
            .setAccessToken(userToken.result!.accessToken ?? '');
        await CacheHelper.instance
            .setEncryptedToken(userToken.result!.encryptedAccessToken ?? "");
      }, onError: (error) {});
    } catch (e) {
      log("refreshToken error $e");
    }
    return userToken;
  }
}
