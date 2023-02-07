import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/forgot_password/data/repos/forgot_password_repo.dart';

import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';

class ForgotPasswordRepoImplement extends ForgotPasswordRepo {
  @override
  Future<int> sendPasswordResetCode({
    required String emailAddress,
  }) async {
    int statusCode = 200;
    Map<String, dynamic> data = {"emailAddress": emailAddress};
    await DioHelper.post(
      data: data,
      Links.sendResetPasswordCode,
      onSuccess: (response) {
        statusCode = response.statusCode ?? 200;
      },
      onError: (error) {
        statusCode = error.response!.statusCode ?? 400;
      },
    );
    if (Get.isDialogOpen!) {
      Get.back();
    }
    return statusCode;
  }
}
