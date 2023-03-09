import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/modules/home/data/models/dars_order.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../../home/widgets/order_widget.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(() => OrdersController());
    return Scaffold(
      appBar: CustomAppBar(
        readNotification: true,
        title: LocaleKeys.my_orders,
        action: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            await Get.toNamed(Routes.ORDER_DARS);
          },
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: ColorManager.primary,
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.add_rounded,
                color: ColorManager.primary,
                size: 15,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorManager.white,
          backgroundColor: ColorManager.primary,
          onRefresh: () async {
            await Future.sync(() => controller.pagingController.refresh());
          },
          child: GetX<OrdersController>(builder: (OrdersController controller) {
            if (controller.isInternetConnected.value == true) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Expanded(
                      child: GetBuilder<OrdersController>(
                          builder: (OrdersController controller) {
                        return PagedListView<int, DarsOrder>(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 4.h),
                          pagingController: controller.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<DarsOrder>(
                            animateTransitions: true,
                            transitionDuration:
                                const Duration(milliseconds: 350),
                            firstPageErrorIndicatorBuilder:
                                (BuildContext context) {
                              return Center(
                                child: SpinKitCircle(
                                  duration: const Duration(milliseconds: 1300),
                                  size: 50,
                                  color: ColorManager.primary,
                                ),
                              );
                            },
                            firstPageProgressIndicatorBuilder:
                                (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    LottiesManager.searchingLight,
                                    animate: true,
                                  ),
                                ],
                              );
                            },
                            newPageErrorIndicatorBuilder:
                                (BuildContext context) {
                              return Center(
                                child: SpinKitCircle(
                                  duration: const Duration(milliseconds: 1300),
                                  color: ColorManager.primary,
                                  size: 50,
                                ),
                              );
                            },
                            newPageProgressIndicatorBuilder:
                                (BuildContext context) {
                              return Column(
                                children: [
                                  SizedBox(height: 20.h),
                                  Center(
                                    child: SpinKitCircle(
                                      duration:
                                          const Duration(milliseconds: 1300),
                                      color: ColorManager.primary,
                                      size: 50,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              );
                            },
                            noItemsFoundIndicatorBuilder:
                                (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    ImagesManager.noOrders,
                                    width: 120.w,
                                    height: 125.h,
                                  ),
                                  PrimaryText(
                                    LocaleKeys.no_orders_currently.tr,
                                    fontSize: 16,
                                    fontWeight: FontWeightManager.light,
                                    color: ColorManager.fontColor,
                                  ),
                                  PrimaryText(
                                    LocaleKeys.you_can_add_new_dars_order.tr,
                                    fontSize: 16,
                                    fontWeight: FontWeightManager.light,
                                    color: ColorManager.grey5,
                                  ),
                                  SizedBox(height: 25.h),
                                  PrimaryButton(
                                    onPressed: () async {
                                      await Get.toNamed(Routes.ORDER_DARS);
                                    },
                                    title: LocaleKeys.add_new_order.tr,
                                    width: (Get.width * 0.55).w,
                                  ),
                                ],
                              );
                            },
                            itemBuilder: (BuildContext context, DarsOrder order,
                                int index) {
                              return OrderWidget(
                                isFirst: index == 0,
                                darsOrder: order,
                              );
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20.h),
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
