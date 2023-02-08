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
    if (currentUserProfileInfo.result != null &&
        currentUserProfileInfo.result!.requester != null &&
        currentUserProfileInfo.result!.requester!.id != null) {
      userPicture =
          "${Links.baseLink}${Links.profileImageById}?userId=${currentUserProfileInfo.result!.requester!.id}";
    }
    super.onInit();
  }

  void changeUserPictureIfErrorHappens() {
    userPicture =
        "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
    update();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 5).then((bool internetStatus) {
      isInternetConnected.value = internetStatus;
    });
  }
}
