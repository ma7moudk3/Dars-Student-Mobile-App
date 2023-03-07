import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/modules/preferred_teachers/data/models/preferred_teacher/preferred_teacher.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../dars_teachers/widgets/dars_teacher_widget.dart';
import '../controllers/preferred_teachers_controller.dart';

class PreferredTeachersView extends GetView<PreferredTeachersController> {
  const PreferredTeachersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.preferred_teachers,
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
      body: GetX<PreferredTeachersController>(
          builder: (PreferredTeachersController controller) {
        if (controller.isInternetConnected.value) {
          return Column(
            children: [
              SizedBox(height: 24.h),
              GetBuilder<PreferredTeachersController>(
                  builder: (PreferredTeachersController controller) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: RefreshIndicator(
                      color: ColorManager.white,
                      backgroundColor: ColorManager.primary,
                      onRefresh: () async => await Future.sync(
                          () => controller.pagingController.refresh()),
                      child: PagedListView<int, PreferredTeacher>(
                        pagingController: controller.pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<PreferredTeacher>(
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
                                  LocaleKeys.no_results_found.tr,
                                  fontSize: 20.sp,
                                ),
                              ],
                            );
                          },
                          itemBuilder: (BuildContext context,
                              PreferredTeacher teacher, int index) {
                            return TeacherWidget(
                              teacher: teacher,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
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
