import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/modules/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:hessa_student/app/routes/app_pages.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_features/lotties_manager.dart';
import 'package:lottie/lottie.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorManager.white,
          backgroundColor: ColorManager.primary,
          onRefresh: () async {
            // Future.sync(() => controller.pagingController.refresh());
            await controller.checkInternet();
          },
          child: GetX<HomeController>(builder: (HomeController controller) {
            if (controller.isInternetConnected.value == true) {
              return SingleChildScrollView(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              PrimaryText(
                                "${LocaleKeys.welcome.tr} ${controller.currentUserInfo.result != null ? controller.currentUserInfo.result!.name : ""} ${controller.currentUserInfo.result != null ? controller.currentUserInfo.result!.surname : ""}",
                                fontSize: 16.sp,
                                fontWeight: FontWeightManager.light,
                                color: ColorManager.grey5,
                              ),
                              Transform(
                                transform: Matrix4.rotationY(
                                    Get.locale!.languageCode != "ar"
                                        ? 0
                                        : 3.14),
                                alignment: Alignment.bottomCenter,
                                child: Lottie.asset(
                                  LottiesManager.hi,
                                  width: 32.w,
                                  animate: true,
                                  reverse: true,
                                ),
                              ),
                              // PrimaryText(
                              //   "...",
                              //   fontSize: 16.sp,
                              //   fontWeight: FontWeightManager.light,
                              //   color: ColorManager.grey5,
                              // ),
                            ],
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
                                  await Get.toNamed(Routes.HESSA_TEACHERS);
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
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  final BottomNavBarController
                                      bottomNavBarController = Get.find();
                                  bottomNavBarController.bottomNavIndex.value =
                                      1; // orders view
                                },
                                child: PrimaryText(
                                  LocaleKeys.more,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeightManager.light,
                                  color: ColorManager.primary,
                                ),
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
                                          LocaleKeys
                                              .you_can_add_new_hessa_order.tr,
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (index ==
                                              controller.orders.length) {
                                            return SizedBox(height: 20.h);
                                          }
                                          return OrderWidget(
                                              isFirst: index == 0);
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
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(
                      LocaleKeys.check_your_internet_connection.tr,
                      fontSize: 18,
                      fontWeight: FontWeightManager.bold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: Get.height * 0.5,
                      child: Lottie.asset(
                        LottiesManager.noInernetConnection,
                        animate: true,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    PrimaryButton(
                      onPressed: () async {
                        await controller.checkInternet();
                      },
                      title: LocaleKeys.retry.tr,
                      width: Get.width * 0.5,
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
