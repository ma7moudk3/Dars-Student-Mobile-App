import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/helper_functions.dart';
import '../../bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import '../data/models/notification_data/item.dart';
import '../data/repos/notification_repo_implement.dart';
import '../data/repos/notifications_repo.dart';

class NotificationsController extends GetxController {
  RxBool isInternetConnected = true.obs;
  PagingController<int, Item> pagingController =
      PagingController(firstPageKey: 1);
  List<Item> notifications = [];
  static const _pageSize = 6; // 6 notifications per page

  final NotificationsRepo _notificationsRepo = NotificationsRepoImplement();

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      getNotifications(page: pageKey);
    });
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      await Future.wait([setAllNotificationsAsRead()]);
    });
  }

  @override
  void onInit() async {
    super.onInit();
    _initPageRequestListener();
    await checkInternet();
  }

  Future setAllNotificationsAsRead() async {
    try {
      int statusCode = await _notificationsRepo.setAllNotificationsAsRead();
      if (statusCode == 200) {
        final BottomNavBarController bottomNavBarController =
            Get.find<BottomNavBarController>();
        bottomNavBarController.setNotificationCount(0);
      }
    } on DioError catch (e) {
      log("setAllNotificationsAsRead DioError ${e.message}");
    }
    update();
  }

  Future getNotifications({
    required int page,
  }) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        notifications = await _notificationsRepo.getNotifications(
          page: page,
          perPage: _pageSize,
        );
        final isLastPage = notifications.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(notifications);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(notifications, nextPageKey);
        }
      } else {
        isInternetConnected.value = false;
      }
    } on DioError catch (e) {
      log("getNotifications DioError ${e.message}");
    }
    update();
  }

  @override
  void onClose() {}
}
