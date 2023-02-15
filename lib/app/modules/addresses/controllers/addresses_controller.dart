import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/addresses/data/repos/addresses.repo.dart';
import 'package:hessa_student/app/modules/addresses/data/repos/addresses_repo_implement.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../data/models/address_result/address_result.dart';

class AddressesController extends GetxController {
  static const _pageSize = 6; // 6 addresses per page
  PagingController<int, AddressResult> pagingController = // item = address
      PagingController(firstPageKey: 1);
  List<AddressResult> addresses = [];
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
          page: 1,
          perPage: 1000,
        );
        // we commented the code below because there's no pagination in the api
        pagingController.appendLastPage(addresses);
        // final isLastPage = addresses.length < _pageSize;
        // if (isLastPage) {
        //   pagingController.appendLastPage(addresses);
        // } else {
        //   final nextPageKey = page + 1;
        //   pagingController.appendPage(addresses, nextPageKey);
        // }
      } else {
        isInternetConnected.value = false;
      }
    } on DioError catch (e) {
      log("getMyAddresses DioError ${e.message}");
    }
    update();
  }

  Future deleteAddress({
    required int addressId,
  }) async {
    if (addressId != -1) {
      if (await checkInternetConnection(timeout: 10)) {
        showLoadingDialog();
        await _addressesRepo
            .deleteAddress(addressId: addressId)
            .then((int statusCode) {
          CustomSnackBar.showCustomSnackBar(
            title: LocaleKeys.success.tr,
            message: LocaleKeys.address_deleted_successfully.tr,
          );
          refreshPagingController();
        });
      } else {
        await Get.toNamed(Routes.CONNECTION_FAILED);
      }
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
        title: LocaleKeys.error.tr,
        message: LocaleKeys.please_choose_a_valid_address_to_delete.tr,
      );
    }
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10).then((bool internetStatus) {
      isInternetConnected.value = internetStatus;
    });
  }
}
