import 'package:get/get.dart';
import 'package:hessa_student/app/data/cache_helper.dart';

class ProfileController extends GetxController {
  bool isNotified =
      CacheHelper.instance.getFcmToken().isNotEmpty ? true : false;

  Future<void> toggleNotifications(bool value) async {
    isNotified = value;
    if (isNotified) {
      // await sendFcmToken().then((value) {
      //   if (Get.isDialogOpen!) {
      //     Get.back();
      //   }
      // });
    } else {
      // await FirebaseMessaging.instance.deleteToken().then((value) async {
      //   await CacheController.instance.setFcmToken("").then((value) {
      //     if (Get.isDialogOpen!) {
      //       Get.back();
      //     }
      //   });
      // });
    }
    update();
  }

  @override
  void onClose() {}
}
