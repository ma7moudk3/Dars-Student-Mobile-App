import 'dart:developer';

import 'package:hessa_student/app/constants/constants.dart';
import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/order_details/data/models/candidate_providers/candidate_providers.dart';
import 'package:hessa_student/app/modules/order_details/data/models/order_details/order_details.dart';
import 'package:hessa_student/app/modules/order_details/data/repos/order_details_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../data/cache_helper.dart';

class OrderDetailsRepoImplement extends OrderDetailsRepo {
  @override
  Future<OrderDetails> getDarsOrderDetails({
    required int darsOrder,
  }) async {
    OrderDetails darsOrderDetails = OrderDetails();
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
          darsOrderDetails = OrderDetails.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("OrderDetailsRepoImplement.getDarsOrderDetails: $e");
    }
    return darsOrderDetails;
  }

  @override
  Future<CandidateProviders> getCandidateProviders(
      {required int darsOrder}) async {
    CandidateProviders candidateProviders = CandidateProviders();
    // try {
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
    };
    Map<String, dynamic> queryParameters = {
      'orderId': darsOrder,
    };
    await DioHelper.get(
      headers: headers,
      queryParameters: queryParameters,
      Links.getCandidateProvidersForOrder,
      onSuccess: (response) {
        var result = response.data;
        candidateProviders = CandidateProviders.fromJson(result);
      },
      onError: (error) {},
    );
    // } catch (e) {
    //   log("OrderDetailsRepoImplement.getCandidateProviders: $e");
    // }
    return candidateProviders;
  }

  @override
  Future<int> cancelDarsOrder(
      {required int darsOrderId, required String reason}) async {
    int statusCode = 200;
    try {
      await DioHelper.post(
        headers: headers,
        Links.cancelOrder,
        data: {
          "notes": reason,
          "orderId": darsOrderId,
        },
        onSuccess: (response) {
          statusCode = response.statusCode ?? 200;
          if (Get.isDialogOpen!) {
            Get.back();
          }
        },
        onError: (error) {
          statusCode = error.statusCode ?? 400;
          if (Get.isDialogOpen!) {
            Get.back();
          }
        },
      );
    } catch (e) {
      statusCode = 400;
      log("OrderDetailsRepoImplement.cancelDarsOrder: $e");
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
    return statusCode;
  }
}
