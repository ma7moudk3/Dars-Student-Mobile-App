import 'dart:developer';

import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/dars_details/data/models/dars_order_details/dars_order_details.dart';
import 'package:hessa_student/app/modules/dars_details/data/repos/dars_details_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../data/cache_helper.dart';

class DarsDetailsRepoImplement extends DarsDetailsRepo {
  @override
  Future<DarsOrderDetails> getDarsOrderDetails({
    required int darsOrder,
  }) async {
    DarsOrderDetails darsOrderDetails = DarsOrderDetails();
    try {
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      Map<String, dynamic> queryParameters = {
        'id': darsOrder,
      };
      await DioHelper.get(
        headers: headers,
        queryParameters: queryParameters,
        Links.getDarsOrderDetails,
        onSuccess: (response) {
          var result = response.data;
          darsOrderDetails = DarsOrderDetails.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("DarsDetailsRepoImplement.getDarsOrderDetails: $e");
    }
    return darsOrderDetails;
  }
}
