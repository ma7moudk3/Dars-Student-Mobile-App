import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hessa_student/app/modules/home/data/models/dars_order.dart';
import 'package:hessa_student/app/modules/orders/data/repos/orders_repo.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../constants/constants.dart';
import '../../../core/helper_functions.dart';
import '../data/repos/orders_repo_implement.dart';

class OrdersController extends GetxController {
  RxBool isInternetConnected = true.obs;
  static const _pageSize = 6; // 6 orders per page
  List<DarsOrder> orders = [];
  PagingController<int, DarsOrder> pagingController =
      PagingController(firstPageKey: 1);
  final OrdersRepo _ordersRepo = OrdersRepoImplement();
  Future checkInternet() async {
    await checkInternetConnection(timeout: 5).then((bool internetStatus) {
      isInternetConnected.value = internetStatus;
    });
  }

  String getSessionString(int sessionCount, OrderStatus orderStatus) {
    if (Get.locale!.languageCode == "ar") {
      if (sessionCount == 0) {
        return orderStatus == OrderStatus.cancelled
            ? LocaleKeys.no_sessions.tr
            : LocaleKeys.no_sessions_yet.tr;
      } else if (sessionCount == 1) {
        return LocaleKeys.one_session.tr;
      } else if (sessionCount == 2) {
        return LocaleKeys.two_sessions.tr;
      } else if (sessionCount >= 3 && sessionCount <= 10) {
        return "$sessionCount ${LocaleKeys.sessions.tr}";
      } else {
        return "$sessionCount ${LocaleKeys.session_number.tr}";
      }
    } else {
      if (sessionCount == 0) {
        return orderStatus == OrderStatus.cancelled
            ? LocaleKeys.no_sessions.tr
            : LocaleKeys.no_sessions_yet.tr;
      } else if (sessionCount == 1) {
        return LocaleKeys.one_session.tr;
      } else {
        return "$sessionCount ${LocaleKeys.session.tr}";
      }
    }
  }

  void refreshPagingController() {
    pagingController.refresh();
    update();
  }

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      await getDarsOrders(page: pageKey);
    });
  }

  Future getDarsOrders({
    required int page,
  }) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        orders = await _ordersRepo.getDarsOrders(
          page: page,
          perPage: _pageSize,
        );
        final isLastPage = orders.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(orders);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(orders, nextPageKey);
        }
      } else {
        isInternetConnected.value = false;
      }
    } on DioError catch (e) {
      log("getDarsOrders DioError ${e.message}");
    }
    update();
  }

  @override
  void onInit() async {
    _initPageRequestListener();
    await checkInternet();
    super.onInit();
  }

  @override
  void onClose() {}
}
