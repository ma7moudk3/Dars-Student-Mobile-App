import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_profile_info/current_user_profile_info.dart';

import '../../../constants/links.dart';
import '../../../data/cache_helper.dart';

class HomeController extends GetxController {
  List<String> orders = [
    "",
    "",
    "",
    "",
  ];
  CurrentUserInfo currentUserInfo =
      CacheHelper.instance.getCachedCurrentUserInfo() ?? CurrentUserInfo();
  CurrentUserProfileInfo currentUserProfileInfo =
      CacheHelper.instance.getCachedCurrentUserProfileInfo() ??
          CurrentUserProfileInfo();
  String? userPicture;
  RxBool isInternetConnected = true.obs;

  @override
  void onInit() async {
    await checkInternet();
    userPicture =
        "${Links.baseLink}${Links.profileImageById}?userId=${currentUserInfo.result!.id}";
    super.onInit();
  }

  void changeUserPictureIfErrorHappens() {
    userPicture = ImagesManager.guest;
    update();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 5).then((bool internetStatus) {
      isInternetConnected.value = internetStatus;
    });
  }
}
