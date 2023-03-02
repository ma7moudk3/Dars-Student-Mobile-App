
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/modules/addresses/data/models/address_result/address_result.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/addresses_controller.dart';
import 'widgets/address_widget.dart';

class AddressesView extends GetView<AddressesController> {
  const AddressesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.addresses,
        leading: GestureDetector(
          onTap: () => Get.back(),
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
        action: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async => await Get.toNamed(Routes.ADD_NEW_ADDRESS),
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
      body:
          GetX<AddressesController>(builder: (AddressesController controller) {
        if (controller.isInternetConnected.value) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                Container(
                  width: Get.width,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ColorManager.green.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: PrimaryText(
                      LocaleKeys.added_addresses,
                      fontSize: 16,
                      color: ColorManager.green,
                      fontWeight: FontWeightManager.light,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                GetBuilder<AddressesController>(
                    builder: (AddressesController controller) {
                  return Expanded(
                    child: RefreshIndicator(
                      color: ColorManager.white,
                      backgroundColor: ColorManager.primary,
                      onRefresh: () async => await Future.sync(
                          () => controller.pagingController.refresh()),
                      child: PagedListView<int, AddressResult>(
                        pagingController: controller.pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<AddressResult>(
                          animateTransitions: true,
                          transitionDuration: const Duration(milliseconds: 350),
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
                          newPageErrorIndicatorBuilder: (BuildContext context) {
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
                          noItemsFoundIndicatorBuilder: (BuildContext context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Lottie.asset(
                                    LottiesManager.noResultsSearching,
                                    animate: true,
                                  ),
                                ),
                                PrimaryText(
                                  LocaleKeys.no_addresses_found.tr,
                                  textAlign: TextAlign.center,
                                  fontSize: 19,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 20.h,
                                  ),
                                  child: PrimaryButton(
                                    onPressed: () async => await Get.toNamed(
                                        Routes.ADD_NEW_ADDRESS),
                                    title: LocaleKeys.add_new_address.tr,
                                  ),
                                ),
                              ],
                            );
                          },
                          itemBuilder: (BuildContext context,
                              AddressResult addressResult, int index) {
                            return AddressWidget(
                              addressResult: addressResult,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }),
                SafeArea(
                  child: GetBuilder<AddressesController>(
                      builder: (AddressesController controller) {
                    return Visibility(
                      visible: controller.addresses.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 20.h,
                        ),
                        child: PrimaryButton(
                          onPressed: () async {
                            await Get.toNamed(Routes.ADD_NEW_ADDRESS);
                          },
                          title: LocaleKeys.add_new_address.tr,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryText(
                LocaleKeys.check_your_internet_connection.tr,
                fontSize: 18.sp,
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
    );
  }
}
