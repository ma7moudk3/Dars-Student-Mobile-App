import 'package:get/get.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/static_page/data/repos/static_page_repo.dart';

import '../data/models/content_management.dart';
import '../data/repos/static_page_repo_implement.dart';

class StaticPageController extends GetxController {
  String pageTitle =
      Get.arguments != null ? Get.arguments['pageTitle'] ?? "" : "";
  int staticPageId =
      Get.arguments != null ? Get.arguments['staticPageId'] ?? 0 : 0;
  String pageSubTitle =
      Get.arguments != null ? Get.arguments['pageSubTitle'] ?? "" : "";
  final StaticPageRepo _staticPageRepo = StaticPageRepoImplement();
  ContentManagement contentManagement = ContentManagement();
  RxBool isLoading = true.obs, isInternetConnected = true.obs;

  @override
  void onInit() async {
    await checkInternet();
    super.onInit();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        await Future.wait([_getStaticPage()])
            .then((value) => isLoading.value = false);
      }
    });
  }

  Future _getStaticPage() async {
    contentManagement = await _staticPageRepo.getStaticPage(
      staticPageId: staticPageId,
    );
  }

  @override
  void onClose() {}
}
