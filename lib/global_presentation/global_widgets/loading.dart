import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../app/constants/exports.dart';

Future<dynamic> showLoadingDialog() async {
  if (Get.isSnackbarOpen) {
    return;
  }
  return await Get.dialog(
    Container(
      color: ColorManager.black.withOpacity(0.4),
      height: 140.h,
      width: 140.w,
      child: Center(
        child: Container(
          height: 90.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: SpinKitCircle(
              duration: const Duration(milliseconds: 1300),
              size: 50,
              color: ColorManager.primary,
            ),
          ),
        ),
      ),
    ),
  );
}
