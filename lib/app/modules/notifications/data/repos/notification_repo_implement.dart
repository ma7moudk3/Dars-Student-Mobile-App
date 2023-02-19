import 'dart:developer';

import 'package:get/get.dart';
import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../data/cache_helper.dart';
import '../models/notification_data/item.dart';
import 'notifications_repo.dart';

class NotificationsRepoImplement extends NotificationsRepo {
  @override
  Future<List<Item>> getNotifications({
    required int perPage,
    required int page,
  }) async {
    List<Item> notifications = [];
    try {
      Map<String, dynamic> queryParameters = {
        "SkipCount": (page - 1) * perPage,
        "MaxResultCount": perPage,
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
        Links.getAllNotifications,
        onSuccess: (response) {
          var result = response.data;
          if (result != null &&
              result["result"] != null &&
              result["result"]["items"] != null) {
            for (var notificationItem in result["result"]["items"]) {
              notifications.add(Item.fromJson(notificationItem));
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
      log("getNotifications DioError $e");
    }
    return notifications;
  }

  @override
  Future<int> getUnReadNotificationsCount() async {
    int unReadNotificationsCount = 0;
    try {
      Map<String, dynamic> queryParameters = {
        "MaxResultCount": 1,
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
        Links.getAllNotifications,
        onSuccess: (response) {
          var result = response.data;
          if (result != null &&
              result["result"] != null &&
              result["result"]["unreadCount"] != null) {
            unReadNotificationsCount = result["result"]["unreadCount"];
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
      log("getUnReadNotificationsCount DioError $e");
    }
    return unReadNotificationsCount;
  }

  @override
  Future<int> setAllNotificationsAsRead() async {
    int statusCode = 200;
    try {
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.post(
        headers: headers,
        Links.setAllNotificationsAsRead,
        onSuccess: (response) {
          statusCode = response.statusCode ?? 200;
        },
        onError: (error) {
          statusCode = error.response?.statusCode ?? 400;
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.response?.data["error"]?["message"] ?? error.message,
          );
        },
      );
    } catch (e) {
      log("setAllNotificationsAsRead DioError $e");
    }
    return statusCode;
  }
}
