import 'package:get/get.dart';

import '../../../core/helper_functions.dart';
import '../../static_page/data/models/content_management.dart';
import '../../static_page/data/repos/static_page_repo.dart';
import '../../static_page/data/repos/static_page_repo_implement.dart';

class AboutHessaController extends GetxController {
  int staticPageId =
      Get.arguments != null ? Get.arguments['staticPageId'] ?? -1 : -1;
  final StaticPageRepo _staticPageRepo = StaticPageRepoImplement();
  ContentManagement aboutHessa = ContentManagement(),
      socialMedia = ContentManagement();
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
        await Future.wait([_getStaticPage(), _getSocialMediaContactMethods()])
            .then((value) => isLoading.value = false);
      }
    });
  }

  Future _getStaticPage() async {
    aboutHessa = await _staticPageRepo.getStaticPage(
      staticPageId: staticPageId,
    );
  }

  Future _getSocialMediaContactMethods() async {
    socialMedia = await _staticPageRepo.getStaticPage(
      staticPageId: 8,
    );
  }

  @override
  void onClose() {}
}
