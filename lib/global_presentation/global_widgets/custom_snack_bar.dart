import 'package:hessa_student/app/constants/exports.dart';

class CustomSnackBar {
  static showCustomSnackBar(
      {required String title, required String message, Duration? duration}) {
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      titleText: PrimaryText(
        title.tr,
        color: Colors.white,
        fontSize: 14.sp,
      ),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 25,
      messageText: PrimaryText(
        message.tr,
        color: ColorManager.white,
        fontSize: 13.sp,
        fontWeight: FontWeightManager.softLight,
      ),
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
    );
    // Get.snackbar(
    //   title.tr,
    //   message.tr,
    //   duration: duration ?? const Duration(seconds: 3),
    //   margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
    //   colorText: Colors.white,
    //   backgroundColor: Colors.green,
    //   icon: const Icon(
    //     Icons.check_circle,
    //     color: Colors.white,
    //   ),
    // );
  }

  static showCustomInfoSnackBar(
      {required String title, required String message, Duration? duration}) {
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      titleText: PrimaryText(
        title.tr,
        color: Colors.white,
        fontSize: 14.sp,
      ),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 25,
      messageText: PrimaryText(
        message.tr,
        color: ColorManager.white,
        fontSize: 13.sp,
        fontWeight: FontWeightManager.softLight,
      ),
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      backgroundColor: ColorManager.primary,
      shouldIconPulse: false,
      icon:  const Icon(
        Icons.info_rounded,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  static showCustomErrorSnackBar(
      {required String title,
      required String message,
      Color? color,
      Duration? duration}) {
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      titleText: PrimaryText(
        title.tr,
        color: Colors.white,
        fontSize: 14.sp,
      ),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 25,
      messageText: PrimaryText(
        message.tr,
        color: ColorManager.white,
        fontSize: 13.sp,
        fontWeight: FontWeightManager.softLight,
      ),
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      backgroundColor: color ?? Colors.redAccent,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }

  static showCustomToast(
      {String? title,
      required String message,
      Color? color,
      Duration? duration}) {
    Get.rawSnackbar(
      title: title,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.green,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }

  static showCustomErrorToast(
      {String? title,
      required String message,
      Color? color,
      Duration? duration}) {
    Get.rawSnackbar(
      title: title,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.redAccent,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }
}
