import 'dart:developer';

import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/modules/orders/data/repos/orders_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../../../../data/network_helper/dio_helper.dart';
import '../../../home/data/models/dars_order.dart';

class OrdersRepoImplement extends OrdersRepo {
  @override
  Future<List<DarsOrder>> getDarsOrders({
    required int page,
    required int perPage,
  }) async {
    List<DarsOrder> recentDarsOrders = [];
    try {
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      Map<String, dynamic> queryParameters = {
        "Sorting": "id DESC",
        "SkipCount": (page - 1) * perPage,
        "MaxResultCount": perPage,
      };
      await DioHelper.get(
        headers: headers,
        queryParameters: queryParameters,
        Links.getMyOrders,
        onSuccess: (response) {
          var result = response.data;
          if (result != null &&
              result["result"] != null &&
              result["result"]["items"] != null) {
            for (var darsOrder in result["result"]["items"]) {
              recentDarsOrders.add(DarsOrder.fromJson(darsOrder));
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
      log("Error in OrdersRepoImplement.getDarsOrders: $e");
    }
    return recentDarsOrders;
  }
}
