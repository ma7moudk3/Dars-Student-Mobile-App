import 'dart:developer';

import 'package:hessa_student/app/modules/home/data/models/hessa_order.dart';
import 'package:hessa_student/app/modules/home/data/repos/home_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../../../../data/network_helper/dio_helper.dart';

class HomeRepoImplement extends HomeRepo {
  @override
  Future<List<HessaOrder>> getRecentHessaOrders() async {
    List<HessaOrder> recentHessaOrders = [];
    try {
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      Map<String, dynamic> queryParameters = {
        "Sorting": "id DESC",
        "MaxResultCount": 4,
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
            for (var hessaOrder in result["result"]["items"]) {
              recentHessaOrders.add(HessaOrder.fromJson(hessaOrder));
            }
          }
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.response?.data["error"]["message"] ?? error.message,
          );
        },
      );
    } catch (e) {
      log("Error in HomeRepoImplement.getRecentHessaOrders: $e");
    }
    return recentHessaOrders;
  }
}
