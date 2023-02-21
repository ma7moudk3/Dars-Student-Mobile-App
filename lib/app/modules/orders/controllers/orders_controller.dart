import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hessa_student/app/modules/home/data/models/hessa_order.dart';
import 'package:hessa_student/app/modules/orders/data/repos/orders_repo.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/helper_functions.dart';
import '../data/repos/orders_repo_implement.dart';

class OrdersController extends GetxController {
  RxBool isInternetConnected = true.obs;
  static const _pageSize = 6; // 6 orders per page
  List<HessaOrder> orders = [];
  PagingController<int, HessaOrder> pagingController =
      PagingController(firstPageKey: 1);
  final OrdersRepo _ordersRepo = OrdersRepoImplement();
  Future checkInternet() async {
    await checkInternetConnection(timeout: 5).then((bool internetStatus) {
      isInternetConnected.value = internetStatus;
    });
  }

  void refreshOrdersPagingController() {
    pagingController.refresh();
    update();
  }

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      await getHessaOrders(page: pageKey);
    });
  }

  Future getHessaOrders({
    required int page,
  }) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        orders = await _ordersRepo.getHessaOrders(
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
      log("getHessaOrders DioError ${e.message}");
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
