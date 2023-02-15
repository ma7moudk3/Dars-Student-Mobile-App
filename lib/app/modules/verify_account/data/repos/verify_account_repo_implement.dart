import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/verify_account/data/repos/verify_account_repo.dart';
import 'package:hessa_student/app/modules/verify_otp/data/models/verify_otp_response/verify_otp_response.dart';
import 'package:hessa_student/generated/locales.g.dart';

import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../models/generate_otp_code/generate_otp_code.dart';

class VerifyAccountRepoImplement extends VerifyAccountRepo {
  @override
  Future<GenerateOtpCode> sendOTP({
    String? phoneNumber,
    String? emailAddress,
    bool isPhoneChanged = false,
    bool isEmailChanged = false,
  }) async {
    GenerateOtpCode generateOtpCode = GenerateOtpCode();
    Map<String, dynamic> data = emailAddress != null
        ? {
            "emailAddress": emailAddress,
            "operationType": isEmailChanged ? 6 : 5,
            "verificationMethod": 1,
          }
        : {
            "phoneNumber": phoneNumber,
            "operationType": isPhoneChanged ? 2 : 4,
            "verificationMethod": 0,
          };
    Map<String, dynamic> headers = {
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    await DioHelper.post(
      Links.generateOTPCode,
      data: data,
      headers: headers,
      onSuccess: (response) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        generateOtpCode = GenerateOtpCode.fromJson(response.data);
      },
      onError: (error) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.something_went_wrong.tr,
          message: error.response?.data["error"]["message"] ?? "Error",
        );
      },
    );
    return generateOtpCode;
  }

  @override
  Future<int> logout() async {
    int statusCode = 200;
    Map<String, dynamic> headers = {
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}",
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    await DioHelper.get(
      Links.logout,
      headers: headers,
      onSuccess: (response) {
        statusCode = response.statusCode ?? 200;
      },
      onError: (error) {
        statusCode = error.response?.statusCode ?? 400;
      },
    );
    return statusCode;
  }

  @override
  Future<VerifyOtpResponse> verifyOTP({
    String? phoneNumber,
    String? emailAddress,
    required String otpCode,
  }) async {
    VerifyOtpResponse verifyOtpResponse = VerifyOtpResponse();
    if (phoneNumber == null && emailAddress == null) {
      return verifyOtpResponse;
    }
    Map<String, dynamic> headers = {
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}",
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String link = emailAddress != null
        ? Links.verifyOTPCodeEmail
        : Links.verifyOTPCodeMobile;
    await DioHelper.post(
      link,
      headers: headers,
      queryParameters: {
        "SecurityCode": otpCode,
      },
      onSuccess: (response) {
        verifyOtpResponse = VerifyOtpResponse.fromJson(response.data);
      },
      onError: (error) {},
    );
    if (Get.isDialogOpen!) {
      Get.back();
    }
    return verifyOtpResponse;
  }
}
