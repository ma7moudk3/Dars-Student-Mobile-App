import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/addresses/data/models/address/address.dart';
import 'package:hessa_student/app/modules/addresses/data/repos/addresses.repo.dart';
import 'package:hessa_student/app/modules/addresses/data/repos/addresses_repo_implement.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../constants/exports.dart';

class AddressesController extends GetxController {
  static const _pageSize = 6; // 6 addresses per page
  PagingController<int, Address> pagingController = // item = address
      PagingController(firstPageKey: 1);
  List<Address> addresses = [];
  RxBool isInternetConnected = true.obs;
  final AddressesRepo _addressesRepo = AddressesRepoImplement();
  @override
  void onInit() async {
    _initPageRequestListener();
    await checkInternet();
    super.onInit();
  }

  void refreshPagingController() {
    pagingController.refresh();
    update();
  }

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      await getMyAddresses(page: pageKey);
    });
  }

  Future getMyAddresses({required int page}) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        addresses = await _addressesRepo.getAllMyAddresses(
          page: page,
          perPage: _pageSize,
        );
        final isLastPage = addresses.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(addresses);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(addresses, nextPageKey);
        }
      } else {
        isInternetConnected.value = false;
      }
    } on DioError catch (e) {
      log("getMyAddresses DioError ${e.message}");
    }
    update();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10).then((bool internetStatus) {
      isInternetConnected.value = internetStatus;
    });
  }
}
