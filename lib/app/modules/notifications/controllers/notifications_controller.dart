import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import '../data/models/notification_data/item.dart';
import '../data/repos/notification_repo_implement.dart';
import '../data/repos/notifications_repo.dart';

class NotificationsController extends GetxController {
  RxBool isInternetConnected = true.obs;
  PagingController<int, Item> pagingController =
      PagingController(firstPageKey: 1);
  List<Item> notifications = [];
  int unReadNotificationsCount = 0;
  static const _pageSize = 6; // 6 notifications per page
  final BottomNavBarController bottomNavBarController =
      Get.find<BottomNavBarController>();
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
      await Future.wait(
          [_getUnReadNotificationsCount(), _setAllNotificationsAsRead()]);
    });
  }

  @override
  void onInit() async {
    super.onInit();
    _initPageRequestListener();
    await checkInternet();
  }

  Future _getUnReadNotificationsCount() async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        unReadNotificationsCount =
            await _notificationsRepo.getUnReadNotificationsCount();
      }
    } on DioError catch (e) {
      log("getUnReadNotificationsCount DioError ${e.message}");
    }
    update();
  }

  Future _setAllNotificationsAsRead() async {
    if (bottomNavBarController.unReadNotificationsCount > 0) {
      // there are unread notifications, so set them as read
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
    }

    update();
  }

  Future deleteNotification({required String notificationId}) async {
    if (notificationId.isNotEmpty) {
      if (await checkInternetConnection(timeout: 10)) {
        showLoadingDialog();
        await _notificationsRepo
            .deleteNotification(notificationId: notificationId)
            .then((int statusCode) {
          if (statusCode == 200) {
            CustomSnackBar.showCustomSnackBar(
              title: LocaleKeys.success.tr,
              message: LocaleKeys.notification_deleted_successfully.tr,
            );
            pagingController.refresh();
          }
        });
      } else {
        await Get.toNamed(Routes.CONNECTION_FAILED);
      }
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
        title: LocaleKeys.error.tr,
        message: LocaleKeys.please_choose_a_valid_notification_to_delete.tr,
      );
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
