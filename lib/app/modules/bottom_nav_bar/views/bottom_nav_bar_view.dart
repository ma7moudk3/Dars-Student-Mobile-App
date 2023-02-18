import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/confirm_back_dialog_content.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.dialog(
          Container(
            color: ColorManager.black.withOpacity(0.1),
            height: 140.h,
            width: 140.w,
            child: Center(
              child: Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                child: ConfirmBackDialogContent(
                  subTitle: LocaleKeys.wanna_out.tr,
                ),
              ),
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: Obx(() => controller.screens[controller.bottomNavIndex.value]),
        bottomNavigationBar:
            GetX<BottomNavBarController>(builder: (controller) {
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
                    child: index != 2
                        ? SvgPicture.asset(
                            controller.icons[index]["icon_path"],
                            color: color,
                          )
                        : Stack(
                            fit: StackFit.passthrough,
                            children: [
                              SvgPicture.asset(
                                controller.icons[index]["icon_path"],
                                color: color,
                              ),
                              Positioned(
                                top: 5.5.h,
                                right: 0,
                                child: Container(
                                  width: 10.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
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
            hideAnimationController:
                controller.hideBottomBarAnimationController,
          );
        }),
      ),
    );
  }
}
