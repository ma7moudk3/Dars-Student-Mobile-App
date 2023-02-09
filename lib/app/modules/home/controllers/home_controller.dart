import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_profile_info/current_user_profile_info.dart';
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
  RxBool isInternetConnected = true.obs;
  
  @override
  void onInit() async {
    await checkInternet();
    if (currentUserProfileInfo.result != null &&
        currentUserProfileInfo.result!.requester != null &&
        currentUserProfileInfo.result!.requester!.id != null) {}
    super.onInit();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 5).then((bool internetStatus) {
      isInternetConnected.value = internetStatus;
    });
  }
}
