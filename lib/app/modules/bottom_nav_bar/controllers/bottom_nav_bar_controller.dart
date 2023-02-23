import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/orders/views/orders_view.dart';
import 'package:hessa_student/app/modules/home/views/home_view.dart';
import 'package:hessa_student/app/modules/messages/views/messages_view.dart';
import 'package:hessa_student/app/modules/profile/views/profile_view.dart';
import 'package:hessa_student/generated/locales.g.dart';

import '../../../core/helper_functions.dart';
import '../../notifications/data/repos/notification_repo_implement.dart';
import '../../notifications/data/repos/notifications_repo.dart';

class BottomNavBarController extends GetxController
    with GetTickerProviderStateMixin {
  RxInt bottomNavIndex = 0.obs;
  final NotificationsRepo _notificationsRepo = NotificationsRepoImplement();
  RxInt unReadNotificationsCount = 0.obs;
  List<Widget> screens = [
    const HomeView(),
    const OrdersView(),
    const MessagesView(),
    const ProfileView(),
  ];
  late AnimationController hideBottomBarAnimationController;
  @override
  void onInit() async {
    super.onInit();
    hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    log("UserId: ${CacheHelper.instance.getUserId()}");
    log("FcmToken: ${await FirebaseMessaging.instance.getToken()}");
    await getUnReadNotificationsCount();
  }

  void setNotificationCount(int count) {
    unReadNotificationsCount.value = count;
  }

  Future getUnReadNotificationsCount() async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        unReadNotificationsCount.value =
            await _notificationsRepo.getUnReadNotificationsCount();
      }
    } on DioError catch (e) {
      log("getUnReadNotificationsCount DioError ${e.message}");
    }
    update();
  }

  List<Map<String, dynamic>> icons = [
    {
      "icon_path": ImagesManager.homeIcon,
      "label": LocaleKeys.home.tr,
    },
    {
      "icon_path": ImagesManager.ordersIcon,
      "label": LocaleKeys.orders.tr,
    },
    {
      "icon_path": ImagesManager.chatIcon,
      "label": LocaleKeys.messages.tr,
    },
    {
      "icon_path": ImagesManager.profileIcon,
      "label": LocaleKeys.profile.tr,
    },
  ];
}
