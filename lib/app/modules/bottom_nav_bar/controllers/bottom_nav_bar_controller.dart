import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/modules/orders/views/orders_view.dart';
import 'package:hessa_student/app/modules/home/views/home_view.dart';
import 'package:hessa_student/app/modules/messages/views/messages_view.dart';
import 'package:hessa_student/app/modules/profile/views/profile_view.dart';
import 'package:hessa_student/generated/locales.g.dart';

class BottomNavBarController extends GetxController
    with GetTickerProviderStateMixin {
  RxInt bottomNavIndex = 0.obs;

  List<Widget> screens = [
    const HomeView(),
    const OrdersView(),
    const MessagesView(),
    const ProfileView(),
  ];
  late AnimationController hideBottomBarAnimationController;
  @override
  void onInit() {
    super.onInit();
    hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  List<Map<String, dynamic>> icons = [
    {
      "icon_path": ImagesManager.homeIcon,
      "label": LocaleKeys.home.tr,
    },
    {
      "icon_path": ImagesManager.ordersIcon,
      "label": LocaleKeys.orders.tr,
    },
    {
      "icon_path": ImagesManager.chatIcon,
      "label": LocaleKeys.messages.tr,
    },
    {
      "icon_path": ImagesManager.profileIcon,
      "label": LocaleKeys.profile.tr,
    },
  ];
}
