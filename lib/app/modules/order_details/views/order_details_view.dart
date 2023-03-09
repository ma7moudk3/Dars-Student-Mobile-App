import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/modules/order_details/widgets/one_dars_widget.dart';
import 'package:lottie/lottie.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/constants.dart';
import '../controllers/order_details_controller.dart';
import '../widgets/studying_package_widget.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.order_details.tr,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorManager.fontColor,
              size: 20,
            ),
          ),
        ),
        action: const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: GetX<OrderDetailsController>(
            builder: (OrderDetailsController controller) {
          if (controller.isInternetConnected.value == true) {
            if (controller.isLoading.value == false) {
              if (controller.darsOrderDetails.result?.order?.productId ==
                      null ||
                  !darsProductTypes.contains(
                      controller.darsOrderDetails.result?.order?.productId)) {
                return Center(
                  child: SpinKitCircle(
                    duration: const Duration(milliseconds: 1300),
                    size: 50,
                    color: ColorManager.primary,
                  ),
                );
              } else {
                return RefreshIndicator(
                  color: ColorManager.white,
                  backgroundColor: ColorManager.primary,
                  onRefresh: () async => await controller.checkInternet(),
                  child: SingleChildScrollView(
                    child: GetBuilder<OrderDetailsController>(
                        builder: (OrderDetailsController controller) {
                      int productId = controller
                              .darsOrderDetails.result?.order?.productId ??
                          -1;
                      if (productId == 41) {
                        // 19 is for studying package, 41 is for one dars
                        return const OneDarsWidget();
                      } else {
                        return const StudyingPackageWidget();
                      }
                    }),
                  ),
                );
              }
            } else {
              return Center(
                child: SpinKitCircle(
                  duration: const Duration(milliseconds: 1300),
                  size: 50,
                  color: ColorManager.primary,
                ),
              );
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(
                  LocaleKeys.check_your_internet_connection.tr,
                  fontSize: 18,
                  fontWeight: FontWeightManager.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: (Get.height * 0.5).h,
                  child: Lottie.asset(
                    LottiesManager.noInernetConnection,
                    animate: true,
                  ),
                ),
                PrimaryButton(
                  onPressed: () async {
                    await controller.checkInternet();
                  },
                  title: LocaleKeys.retry.tr,
                  width: (Get.width * 0.5).w,
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
