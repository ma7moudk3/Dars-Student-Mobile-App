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
            await Get.toNamed(Routes.ORDER_HESSA);
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
                size: 15.sp,
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
            // Future.sync(() => controller.pagingController.refresh());
            await controller.checkInternet();
          },
          child: GetX<OrdersController>(builder: (OrdersController controller) {
            if (controller.isInternetConnected.value == true) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      ListView.builder(
                        itemCount: 9 + 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 9) {
                            return SizedBox(height: 20.h);
                          }
                          return OrderWidget(isFirst: index == 0);
                        },
                      ),
                    ],
                  ),
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
