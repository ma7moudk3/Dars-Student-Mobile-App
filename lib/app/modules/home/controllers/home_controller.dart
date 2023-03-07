import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:hessa_student/app/modules/home/data/models/dars_order.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_profile_info/current_user_profile_info.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo_implement.dart';
import '../../../data/cache_helper.dart';
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
