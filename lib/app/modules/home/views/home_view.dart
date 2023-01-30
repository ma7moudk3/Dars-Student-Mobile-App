import 'dart:developer';

import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/routes/app_pages.dart';
import 'package:hessa_student/generated/locales.g.dart';

import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../controllers/home_controller.dart';
import '../widgets/hessa_grid_view_item.dart';
import '../widgets/order_widget.dart';
import '../widgets/home_profile_info_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(() => HomeController());
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 26.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeProfileInfoWidget(),
                  SizedBox(height: 25.h),
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
                  SizedBox(height: 20.h),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      HessaGridViewItem(
                        imagePath: ImagesManager.notebookIcon,
                        title: LocaleKeys.order_new_hessa.tr,
                        onTap: () async {
                          await Get.toNamed(Routes.ORDER_HESSA);
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
                  SizedBox(height: 25.h),
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
                                  ImagesManager.noOrders,
                                  width: 120.w,
                                  height: 125.h,
                                ),
                                PrimaryText(
                                  LocaleKeys.no_orders_currently.tr,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeightManager.light,
                                  color: ColorManager.fontColor,
                                ),
                                PrimaryText(
                                  LocaleKeys.you_can_add_new_hessa_order.tr,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeightManager.light,
                                  color: ColorManager.grey5,
                                ),
                                SizedBox(height: 15.h),
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(height: 20.h),
                              ListView.builder(
                                itemCount: controller.orders.length + 1,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == controller.orders.length) {
                                    return SizedBox(height: 20.h);
                                  }
                                  return OrderWidget(isFirst: index == 0);
                                },
                              ),
                            ],
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
