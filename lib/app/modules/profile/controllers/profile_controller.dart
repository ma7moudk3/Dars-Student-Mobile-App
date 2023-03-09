import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo_implement.dart';
import 'package:hessa_student/app/modules/profile/data/repos/profile_repo.dart';
import 'package:hessa_student/app/modules/profile/data/repos/profile_repo_implement.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../login/data/models/current_user_info/current_user_info.dart';
import '../../login/data/models/current_user_profile_info/current_user_profile_info.dart';

class ProfileController extends GetxController {
  bool isNotified =
      CacheHelper.instance.getFcmToken().isNotEmpty ? true : false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? userPicture;
  Rx<CurrentUserInfo?> currentUserInfo =
      CacheHelper.instance.getCachedCurrentUserInfo().obs;
  Rx<CurrentUserProfileInfo?> currentUserProfileInfo =
      CacheHelper.instance.getCachedCurrentUserProfileInfo().obs;
  final LoginRepo _loginRepo = LoginRepoImplement();
  final ProfileRepo _profileRepo = ProfileRepoImplement();
  Future<void> toggleNotifications(bool value) async {
    isNotified = value;
    showLoadingDialog();
    if (isNotified) {
      await sendFcmToken().then((value) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
      });
    } else {
      await FirebaseMessaging.instance.deleteToken().then((value) async {
        await CacheHelper.instance.setFcmToken("").then((value) {
          if (Get.isDialogOpen!) {
            Get.back();
          }
        });
      });
    }
    update();
  }

  Future sendFcmToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      if (token != null) {
        log("token : $token");
        await _profileRepo
            .sendFcmToken(
          fcmToken: token,
        )
            .then((value) async {
          await CacheHelper.instance.setFcmToken(token);
        });
      }
    } catch (e) {
      log('sendFcmToken Exception error {{2}} $e');
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }

  Future getCurrentUserInfo() async {
    await _loginRepo
        .getCurrentUserInfo()
        .then((CurrentUserInfo currentUserInfo) async {
      this.currentUserInfo.value = currentUserInfo;
      await CacheHelper.instance.cacheCurrentUserInfo(currentUserInfo.toJson());
    });
    update();
  }

  Future getCurrentUserProfileInfo() async {
    await _loginRepo
        .getCurrentUserProfileInfo()
        .then((CurrentUserProfileInfo currentUserProfileInfo) async {
      this.currentUserProfileInfo.value = currentUserProfileInfo;
      await CacheHelper.instance
          .cacheCurrentUserProfileInfo(currentUserProfileInfo.toJson());
    });
    update();
  }

  void changeUserPictureIfErrorHappens() {
    userPicture =
        "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
    update();
  }

  @override
  void onInit() {
    userPicture =
        "${Links.baseLink}${Links.profileImageById}?userid=${currentUserProfileInfo.value?.result?.requester?.userId ?? -1}";
    super.onInit();
  }

  @override
  void onClose() {}
}
