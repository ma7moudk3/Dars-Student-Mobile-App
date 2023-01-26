import 'dart:developer';

import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/generated/locales.g.dart';

import '../controllers/home_controller.dart';
import '../widgets/hessa_grid_view_item.dart';
import '../widgets/order_widget.dart';
import '../widgets/profile_info.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: 96.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    offset: const Offset(0, 1.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: SafeArea(
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 20.w),
                      SvgPicture.asset(ImagesManager.notificationIcon),
                      const Spacer(),
                      PrimaryText(
                        LocaleKeys.home,
                        fontSize: 18,
                        fontWeight: FontWeightManager.light,
                      ),
                      const Spacer(),
                      SvgPicture.asset(ImagesManager.searchIcon),
                      SizedBox(width: 20.w),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 26.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileInfoWidget(),
                  SizedBox(height: 30.h),
                  PrimaryText(
                    "${LocaleKeys.welcome.tr} وليد علي ..",
                    fontSize: 16.sp,
                    fontWeight: FontWeightManager.light,
                    color: ColorManager.grey5,
                  ),
                  SizedBox(height: 5.h),
                  PrimaryText(
                    "${LocaleKeys.what_are_you_looking_for_today.tr} !",
                    fontSize: 20.sp,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.fontColor,
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      HessaGridViewItem(
                        imagePath: ImagesManager.notebookIcon,
                        title: LocaleKeys.order_new_hessa.tr,
                        onTap: () async {
                          log('order_new_hessa');
                        },
                        iconBackgroundColor: ColorManager.primary,
                      ),
                      HessaGridViewItem(
                        imagePath: ImagesManager.teachersIcon,
                        title: LocaleKeys.hessa_teachers.tr,
                        onTap: () async {
                          log('hessa_teachers');
                        },
                        iconBackgroundColor: ColorManager.yellow,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        "${LocaleKeys.recent_orders.tr} :",
                        fontSize: 16.sp,
                        fontWeight: FontWeightManager.light,
                        color: ColorManager.fontColor,
                      ),
                      PrimaryText(
                        LocaleKeys.more,
                        fontSize: 15.sp,
                        fontWeight: FontWeightManager.light,
                        color: ColorManager.primary,
                      ),
                    ],
                  ),
                  GetBuilder<HomeController>(
                      init: HomeController(),
                      builder: (HomeController controller) {
                        if (controller.orders.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                    ImagesManager.noOrdersBackground),
                                SvgPicture.asset(
                                  ImagesManager.noOrders,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: controller.orders.length + 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              if (index == controller.orders.length) {
                                return SizedBox(height: 20.h);
                              }
                              return const OrderWidget();
                            },
                          );
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
