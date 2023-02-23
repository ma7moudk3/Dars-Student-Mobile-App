import 'dart:developer';
import 'dart:math' as math;

import '../../../../../global_presentation/global_widgets/loading.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/network_helper/dio_helper.dart';
import 'sign_up_repo.dart';

class SignUpRepoImplement extends SignUpRepo {
  @override
  Future<int?> register({
    required int gender,
    required String fullName,
    required String phoneNumber,
    required String emailAddress,
    required String dateOfBirth,
    required String password,
    required String captchaResponse,
  }) async {
    int? statusCode;
    showLoadingDialog();
    int randomUserName = math.Random().nextInt(100000);
    String firstName = fullName.split(" ")[0];
    String lastName =
        fullName.split(" ").length > 1 ? fullName.split(" ")[1] : "";
    String userName = emailAddress.split("@")[0] + randomUserName.toString();
    Map<String, dynamic> data = {
      "name": firstName,
      "password": password,
      "surname": lastName, // last name
      "gender": gender,
      "userName": userName,
      "phoneNumber": phoneNumber,
      "doB": dateOfBirth,
      "emailAddress": emailAddress,
      "userType": 2, // 2 => Student , 1 => Teacher
      "captchaResponse": captchaResponse
    };
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    await DioHelper.post(headers: headers, Links.register, data: data,
        onSuccess: (response) async {
      statusCode = response.statusCode;
      log(response.data.toString());
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }, onError: (response) {
      statusCode = response.statusCode;
      if (Get.isDialogOpen!) {
        Get.back();
      }
    });
    return statusCode;
  }
}
