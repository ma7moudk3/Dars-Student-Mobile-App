import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:hessa_student/app/constants/exports.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.bottomNavIndex.value]),
      bottomNavigationBar: GetX<BottomNavBarController>(builder: (controller) {
        return AnimatedBottomNavigationBar.builder(
          itemCount: controller.icons.length,
          tabBuilder: (int index, bool isActive) {
            final color =
                isActive ? ColorManager.primary : HexColor.fromHex("#B0B9C1");
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 22.w,
                  height: 40.h,
                  child: SvgPicture.asset(
                    controller.icons[index]["icon_path"],
                    color: color,
                  ),
                ),
                PrimaryText(
                  controller.icons[index]["label"],
                  color: color,
                  fontSize: 11.sp,
                  fontWeight: FontWeightManager.book,
                )
              ],
            );
          },
          backgroundColor: ColorManager.white,
          activeIndex: controller.bottomNavIndex.value,
          splashColor: ColorManager.primaryLight,
          height: 90.h,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.none,
          onTap: (index) => {controller.bottomNavIndex.value = index},
          hideAnimationController: controller.hideBottomBarAnimationController,
        );
      }),
    );
  }
}
