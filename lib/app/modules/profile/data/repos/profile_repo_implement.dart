import 'dart:developer';

import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/profile/data/repos/profile_repo.dart';

import '../../../../constants/links.dart';
import '../../../../data/network_helper/dio_helper.dart';

class ProfileRepoImplement extends ProfileRepo {
  @override
  Future sendFcmToken({
    required String fcmToken,
  }) async {
    try {
      await DioHelper.put(Links.sendFCMToken, data: {
        "fcmToken": fcmToken
      }, headers: {
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      }, onSuccess: (response) async {
        log("success");
      }, onError: (response) {
        log("error");
      });
    } catch (e) {
      log("sendFcmToken Exception error $e");
    }
  }
}
