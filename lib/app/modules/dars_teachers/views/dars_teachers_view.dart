import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/global_presentation/global_features/lotties_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/confirm_back_dialog_content.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/pop_up_menu.dart';
import '../../../../global_presentation/global_widgets/search_bar.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dars_teachers_controller.dart';
import '../data/models/dars_teacher.dart';
import '../widgets/dars_teacher_filter_bottom_sheet_content.dart';
import '../widgets/dars_teacher_widget.dart';

class DarsTeachersView extends GetView<DarsTeachersController> {
  const DarsTeachersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DarsTeachersController>(
        builder: (DarsTeachersController controller) {
      return WillPopScope(
        onWillPop: () async {
          if (controller.toggleFilter) {
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
                      subTitle: LocaleKeys.wanna_back_and_lose_filters.tr,
                    ),
                  ),
                ),
              ),
            );
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.dars_teachers,
            leading: GestureDetector(
              onTap: () async {
                if (controller.toggleFilter) {
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
                            subTitle: LocaleKeys.wanna_back_and_lose_filters.tr,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  Get.back();
                }
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
          body: GetX<DarsTeachersController>(
              builder: (DarsTeachersController controller) {
            if (controller.isInternetConnected.value == true) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Container(
                    width: (Get.width).w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 0.h),
                    child: SearchBar(
                      searchHint: LocaleKeys.search_for_teacher.tr,
                      onFilterTap: () async {
                        await Get.bottomSheet(
                          isScrollControlled: true,
                          isDismissible: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          backgroundColor: ColorManager.white,
                          const DarsTeacherFilterBottomSheetContent(),
                        );
                      },
                      onSearch: (String? text) async {
                        if (controller.searchTextController.text.isNotEmpty &&
                            (controller.searchTextController.text
                                .trim()
                                .isNotEmpty)) {
                          if (await checkInternetConnection(timeout: 10)) {
                            controller.toggleSearch = true;
                          } else {
                            await Get.toNamed(Routes.CONNECTION_FAILED);
                          }
                        }
                      },
                    ),
                  ),
                  KeyboardVisibilityBuilder(
                      builder: (context, bool isKeyboardVisible) {
                    return GetBuilder<DarsTeachersController>(
                        builder: (DarsTeachersController controller) {
                      return Visibility(
                        visible: controller.toggleFilter &&
                            controller.filterList.isNotEmpty,
                        child: Expanded(
                          flex: isKeyboardVisible ? 2 : 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 14.h),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.filterList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 30.h,
                                        margin: EdgeInsets.only(right: 10.w),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 7.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0x1a5b83f9),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x01000000),
                                              offset: Offset(0, 5),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              PrimaryText(
                                                controller.filterList[index]
                                                    ["displayName"],
                                                color: ColorManager.primary,
                                              ),
                                              SizedBox(width: 5.w),
                                              GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () async {
                                                  await controller
                                                      .removeFilterTag(
                                                          filterTag: controller
                                                                  .filterList[
                                                              index]);
                                                },
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: ColorManager.primary,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  }),
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            PrimaryText(
                              LocaleKeys.search_results,
                              fontSize: 16.sp,
                            ),
                            const Spacer(),
                            GetBuilder<DarsTeachersController>(
                                builder: (DarsTeachersController controller) {
                              return Row(
                                children: [
                                  PrimaryText(
                                    controller.sortType == null
                                        ? LocaleKeys.choose_sort_type
                                        : controller.sortType
                                                    ?.contains("DESC") ==
                                                true
                                            ? LocaleKeys.most_rated
                                            : LocaleKeys.less_rated,
                                    fontSize: 16,
                                    color: ColorManager.fontColor7,
                                  ),
                                  PopUpMenu(
                                    menulist: [
                                      PopupMenuItem(
                                        textStyle: const TextStyle(
                                          fontFamily: FontConstants.fontFamily,
                                        ),
                                        onTap: () async => await controller
                                            .sortTeacherByRating(
                                          sortType: "DESC",
                                        ),
                                        child: ListTile(
                                          splashColor: Colors.transparent,
                                          leading: Transform.scale(
                                            scaleY: -1,
                                            child: SvgPicture.asset(
                                              ImagesManager.descendingIcon,
                                              color: ColorManager.fontColor
                                                  .withOpacity(0.7),
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                          ),
                                          title: PrimaryText(
                                            LocaleKeys.most_rated.tr,
                                            color: ColorManager.fontColor,
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        textStyle: const TextStyle(
                                          fontFamily: FontConstants.fontFamily,
                                        ),
                                        onTap: () async => await controller
                                            .sortTeacherByRating(
                                          sortType: "ASC",
                                        ),
                                        child: ListTile(
                                          splashColor: Colors.transparent,
                                          leading: SvgPicture.asset(
                                            ImagesManager.descendingIcon,
                                            color: ColorManager.fontColor
                                                .withOpacity(0.7),
                                            height: 20.h,
                                            width: 20.w,
                                          ),
                                          title: PrimaryText(
                                            LocaleKeys.less_rated.tr,
                                            color: ColorManager.fontColor,
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        textStyle: const TextStyle(
                                          fontFamily: FontConstants.fontFamily,
                                        ),
                                        onTap: () async => await controller
                                            .sortTeacherByRating(),
                                        child: ListTile(
                                          splashColor: Colors.transparent,
                                          leading: Icon(
                                            Icons.select_all_rounded,
                                            color: ColorManager.fontColor
                                                .withOpacity(0.7),
                                            size: 23,
                                          ),
                                          title: PrimaryText(
                                            LocaleKeys.select_all.tr,
                                            color: ColorManager.fontColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                    icon: controller.sortType == null
                                        ? Icon(
                                            Icons.more_vert_rounded,
                                            color: ColorManager.fontColor
                                                .withOpacity(0.7),
                                          )
                                        : controller.sortType
                                                    ?.contains("DESC") ==
                                                true
                                            ? Transform.scale(
                                                scaleY: -1,
                                                child: SvgPicture.asset(
                                                  ImagesManager.descendingIcon,
                                                  color: ColorManager.fontColor
                                                      .withOpacity(0.7),
                                                  height: 20.h,
                                                  width: 20.w,
                                                ),
                                              )
                                            : SvgPicture.asset(
                                                ImagesManager.descendingIcon,
                                                color: ColorManager.fontColor
                                                    .withOpacity(0.7),
                                                height: 20.h,
                                                width: 20.w,
                                              ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),
                  GetBuilder<DarsTeachersController>(
                      builder: (DarsTeachersController controller) {
                    return Expanded(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: RefreshIndicator(
                          color: ColorManager.white,
                          backgroundColor: ColorManager.primary,
                          onRefresh: () async => await Future.sync(
                              () => controller.pagingController.refresh()),
                          child: PagedListView<int, DarsTeacher>(
                            pagingController: controller.pagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<DarsTeacher>(
                              animateTransitions: true,
                              transitionDuration:
                                  const Duration(milliseconds: 350),
                              firstPageErrorIndicatorBuilder:
                                  (BuildContext context) {
                                return Center(
                                  child: SpinKitCircle(
                                    duration:
                                        const Duration(milliseconds: 1300),
                                    size: 50,
                                    color: ColorManager.primary,
                                  ),
                                );
                              },
                              firstPageProgressIndicatorBuilder:
                                  (BuildContext context) {
                                return Column(
                                  children: [
                                    SizedBox(height: 50.h),
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
                                    duration:
                                        const Duration(milliseconds: 1300),
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
                                return Center(
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      Center(
                                        child: Lottie.asset(
                                          LottiesManager.noResultsSearching,
                                          animate: true,
                                        ),
                                      ),
                                      PrimaryText(
                                        LocaleKeys.no_results_found.tr,
                                        fontSize: 20,
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                );
                              },
                              itemBuilder: (BuildContext context,
                                  DarsTeacher teacher, int index) {
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
        ),
      );
    });
  }
}
