import 'dart:developer';
import 'dart:io';

import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:hessa_student/app/modules/home/data/models/dars_order.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_profile_info/current_user_profile_info.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo_implement.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../data/cache_helper.dart';
import '../../../routes/app_pages.dart';
import '../../login/data/repos/login_repo.dart';
import '../data/repos/home_repo.dart';
import '../data/repos/home_repo_implement.dart';

class HomeController extends GetxController {
  CurrentUserInfo currentUserInfo =
      CacheHelper.instance.getCachedCurrentUserInfo() ?? CurrentUserInfo();
  CurrentUserProfileInfo currentUserProfileInfo =
      CacheHelper.instance.getCachedCurrentUserProfileInfo() ??
          CurrentUserProfileInfo();
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  final LoginRepo _loginRepo = LoginRepoImplement();
  List<DarsOrder> recentDarsOrders = [];
  final HomeRepo _homeRepo = HomeRepoImplement();
  @override
  void onReady() async {
    if (CacheHelper.instance.getIsWelcomeBack()) {
      await welcomeBack();
      await CacheHelper.instance.setIsWelcomeBack(false);
    }
    super.onReady();
  }

  @override
  void onInit() async {
    final customInstance = InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 3), // Custom check timeout
      checkInterval: const Duration(seconds: 5), // Custom check interval
      addresses: [
        AddressCheckOptions(
          address: InternetAddress(
            '8.8.4.4', // Google
            type: InternetAddressType.IPv4,
          ),
        ),
        AddressCheckOptions(
          address: InternetAddress(
            '2001:4860:4860::8888', // Google
            type: InternetAddressType.IPv6,
          ),
        ),
        AddressCheckOptions(
          address: InternetAddress(
            '208.67.222.222', // OpenDNS
            type: InternetAddressType.IPv4,
          ), // OpenDNS
        ),
        AddressCheckOptions(
          address: InternetAddress(
            '2620:0:ccc::2', // OpenDNS
            type: InternetAddressType.IPv6,
          ), // OpenDNS
        ),
      ],
    );
    // Register it with any dependency injection framework. For example GetIt.
    Get.put<InternetConnectionChecker>(
      customInstance,
    );
    bool result = await InternetConnectionChecker().hasConnection;
    InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            if (CacheHelper.instance.authenticated()) {
              if (Get.currentRoute != Routes.BOTTOM_NAV_BAR) {
                await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
              }
            } else {
              await Get.offAllNamed(Routes.LOGIN);
            }
            break;
          case InternetConnectionStatus.disconnected:
            await Get.offAllNamed(Routes.CONNECTION_FAILED);
            log('You are disconnected from the internet.');
            break;
        }
      },
    );
    await checkInternet();
    super.onInit();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 5).then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        final BottomNavBarController bottomNavBarController =
            Get.find<BottomNavBarController>();
        await Future.wait([
          _loginRepo.getCurrentUserProfilePicture(),
          getMyOrders(),
          bottomNavBarController.getUnReadNotificationsCount(),
          // bottomNavBarController.getUnreadMessages(), // to be done later if needed
        ]).then(
          (value) => isLoading.value = false,
        );
      }
    });
  }

  Future getMyOrders() async {
    recentDarsOrders = await _homeRepo.getRecentDarsOrders();
    update();
  }
}
