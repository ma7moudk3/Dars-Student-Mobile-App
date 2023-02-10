import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/settings/data/repos/settings_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../data/cache_helper.dart';

class SettingsRepoImplement extends SettingsRepo {
  @override
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    bool result = false;
    Map<String, dynamic> data = {
      'currentPassword': oldPassword,
      'newPassword': newPassword,
    };
    Map<String, dynamic> headers = {
      'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
    };
    await DioHelper.post(
      headers: headers,
      Links.changePassword,
      data: data,
      onSuccess: (response) {
        result = true;
        if (Get.isDialogOpen!) {
          Get.back();
        }
      },
      onError: (error) {
        result = false;
        if (Get.isDialogOpen!) {
          Get.back();
        }
        CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.error.tr,
          message: error.response != null
              ? error.response!.data["error"]["message"] ?? error.message
              : error.message,
        );
      },
    );

    return result;
  }
}
