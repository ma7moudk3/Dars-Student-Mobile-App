import 'dart:developer';

import 'package:hessa_student/app/constants/links.dart';
import 'package:hessa_student/app/data/network_helper/dio_helper.dart';
import 'package:hessa_student/app/modules/static_page/data/repos/static_page_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../models/content_management.dart';

class StaticPageRepoImplement extends StaticPageRepo {
  @override
  Future<ContentManagement> getStaticPage({required int staticPageId}) async {
    ContentManagement contentManagement = ContentManagement();
    try {
      Map<String, dynamic> headers = {
            'Accept-Language':
                Get.locale != null ? Get.locale!.languageCode : 'ar',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // we don't need to send the token here
          },
          queryParameters = {
            'id': staticPageId,
          };

      await DioHelper.get(
        Links.staticPage,
        queryParameters: queryParameters,
        headers: headers,
        onSuccess: (response) {
          var result = response.data;
          contentManagement =
              ContentManagement.fromJson(result["result"]["contentManagement"]);
        },
        onError: (error) {
          log("Error in getStaticPage: $error");
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getStaticPage: $e");
    }
    return contentManagement;
  }
}
