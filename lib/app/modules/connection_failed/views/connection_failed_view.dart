import 'package:flutter/services.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/connection_failed_controller.dart';

class ConnectionFailedView extends GetView<ConnectionFailedController> {
  const ConnectionFailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await checkInternetConnection(timeout: 10)) {
          return true;
        } else {
          SystemNavigator.pop();
          return false;
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              ImagesManager.noInernetConnection,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: Get.height * 0.23,
              left: Get.width * 0.15,
              right: Get.width * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PrimaryText(
                    LocaleKeys.connection_failed.tr,
                    hasSpecificColor: true,
                    color: HexColor.fromHex("#32334d"),
                    fontSize: 22,
                  ),
                  SizedBox(height: 10.h),
                  PrimaryText(
                    LocaleKeys.check_connection_then_try.tr,
                    hasSpecificColor: true,
                    color: HexColor.fromHex("#32334d").withOpacity(0.7),
                    textAlign: TextAlign.center,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: Get.height * 0.13,
              left: Get.width * 0.3,
              right: Get.width * 0.3,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 13),
                          blurRadius: 25,
                          color: const Color(0xFF5666C2).withOpacity(0.17),
                        ),
                      ],
                    ),
                    child: PrimaryButton(
                      onPressed: () async {
                        if (await checkInternetConnection(timeout: 10)) {
                          Get.back();
                        }
                      },
                      title: LocaleKeys.retry.tr,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
