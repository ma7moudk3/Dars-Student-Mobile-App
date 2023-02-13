import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/modules/dependents/data/models/student/student.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dependents_controller.dart';
import 'widgets/no_dependents_widget.dart';

class DependentsView extends GetView<DependentsController> {
  const DependentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.dependents_title,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.fontColor,
            size: 20,
          ),
        ),
        action: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            await Get.toNamed(Routes.ADD_NEW_DEPENDENT);
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
      resizeToAvoidBottomInset: false,
      body: GetX<DependentsController>(
          builder: (DependentsController controller) {
        if (controller.isInternetConnected.value) {
          return GetBuilder<DependentsController>(
              builder: (DependentsController controller) {
            return Column(
              children: [
                SizedBox(height: 24.h),
                GetBuilder<DependentsController>(
                    builder: (DependentsController controller) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: RefreshIndicator(
                        color: ColorManager.white,
                        backgroundColor: ColorManager.primary,
                        onRefresh: () async => await Future.sync(
                            () => controller.pagingController.refresh()),
                        child: PagedListView<int, Student>(
                          pagingController: controller.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<Student>(
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
                              return const NoDependentsWidget();
                            },
                            itemBuilder: (BuildContext context, Student student,
                                int index) {
                              return PrimaryText("asd");
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          });
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
