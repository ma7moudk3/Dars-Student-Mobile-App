
import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/hessa_details/data/models/hessa_order_details/hessa_order_details.dart';
import 'package:hessa_student/app/modules/hessa_details/data/repos/hessa_details_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../data/cache_helper.dart';

class HessaDetailsRepoImplement extends HessaDetailsRepo {
  @override
  Future<HessaOrderDetails> getHessaOrderDetails({
    required int hessaOrderId,
  }) async {
    HessaOrderDetails hessaOrderDetails = HessaOrderDetails();
    // try {
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      Map<String, dynamic> queryParameters = {
        'id': hessaOrderId,
      };
      await DioHelper.get(
        headers: headers,
        queryParameters: queryParameters,
        Links.getHessaOrderDetails,
        onSuccess: (response) {
          var result = response.data;
          hessaOrderDetails = HessaOrderDetails.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    // } catch (e) {
    //   log("HessaDetailsRepoImplement.getHessaOrderDetails: $e");
    // }
    return hessaOrderDetails;
  }
}
