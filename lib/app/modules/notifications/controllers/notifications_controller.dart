import 'package:get/get.dart';

import '../../../core/helper_functions.dart';

class NotificationsController extends GetxController {
  RxBool isInternetConnected = true.obs;
  // PagingController<int, NotificationContent> pagingController =
  //     PagingController(firstPageKey: 1);

  // void _initPageRequestListener() {
  //   pagingController.addPageRequestListener((int pageKey) async {
  //     getNotifications(page: pageKey);
  //   });
  // }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      if (internetStatus) {
        isInternetConnected.value = true;
      } else {
        isInternetConnected.value = false;
      }
    });
  }

  @override
  void onInit() async {
    super.onInit();
    // _initPageRequestListener();
    await checkInternet();
  }

  // Future getNotifications({
  //   required int page,
  // }) async {
  //   try {
  //     if (await checkInternetConnection(timeout: 10)) {
  //       notifications = await _notificationsRepo.getNotifications(
  //         page: page,
  //         perPage: _pageSize,
  //       );
  //       final isLastPage = notifications.length < _pageSize;
  //       if (isLastPage) {
  //         pagingController.appendLastPage(notifications);
  //       } else {
  //         final nextPageKey = page + 1;
  //         pagingController.appendPage(notifications, nextPageKey);
  //       }
  //     } else {
  //       isInternetConnected.value = false;
  //     }
  //   } on DioError catch (e) {
  //     log("getNotifications DioError ${e.message}");
  //   }
  //   update();
  // }

  @override
  void onClose() {}
}
