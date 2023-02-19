import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/modules/dependents/data/models/student/student.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../../routes/app_pages.dart';
import '../../order_hessa/widgets/delete_student_dialog_content.dart';
import '../controllers/dependents_controller.dart';
import '../widgets/dependent_info_bottom_sheet_content.dart';
import '../widgets/no_dependents_widget.dart';

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
                        LocaleKeys.added_dependents,
                        fontSize: 16,
                        color: ColorManager.green,
                        fontWeight: FontWeightManager.light,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GetBuilder<DependentsController>(
                      builder: (DependentsController controller) {
                    return Expanded(
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
                              String studentPicture =
                                  "${Links.baseLink}${Links.profileImageById}?userId=${student.requesterStudent?.id ?? -1}";
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  await Get.bottomSheet(
                                    backgroundColor: ColorManager.white,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    DependentInfoBottomSheetContent(
                                      student: student,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  margin: EdgeInsets.only(bottom: 16.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x1a000000),
                                        offset: Offset(0, 1),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          StatefulBuilder(builder:
                                              (BuildContext context, setState) {
                                            return Container(
                                              width: 58.w,
                                              height: 65.h,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    studentPicture,
                                                    errorListener: () {
                                                      setState(() {
                                                        studentPicture =
                                                            "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                                                      });
                                                    },
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                  color: ColorManager.primary,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            );
                                          }),
                                          SizedBox(width: 10.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PrimaryText(
                                                student.requesterStudent
                                                        ?.name ??
                                                    "",
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      ImagesManager.classIcon),
                                                  SizedBox(width: 5.w),
                                                  PrimaryText(
                                                    student.levelName ?? "",
                                                    fontSize: 14.sp,
                                                    color:
                                                        ColorManager.fontColor7,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .softLight,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () async {
                                                  await Get.dialog(
                                                    Container(
                                                      color: ColorManager.black
                                                          .withOpacity(0.1),
                                                      height: 140.h,
                                                      width: 140.w,
                                                      child: Center(
                                                        child: Container(
                                                          width: Get.width,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 18.w,
                                                          ),
                                                          child:
                                                              DeleteStudentDialogContent(
                                                            deleteStudentFunction:
                                                                () async {
                                                              await controller
                                                                  .deleteStudent(
                                                                studentId: student
                                                                        .requesterStudent
                                                                        ?.id ??
                                                                    -1,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 36.w,
                                                  height: 36.h,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.red
                                                        .withOpacity(0.10),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      ImagesManager.deleteIcon,
                                                      height: 20.h,
                                                      width: 20.w,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () async =>
                                                    await Get.toNamed(
                                                  Routes.EDIT_DEPENDENT,
                                                  arguments: student,
                                                ),
                                                child: Container(
                                                  width: 36.w,
                                                  height: 36.h,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.primary
                                                        .withOpacity(0.10),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.edit_rounded,
                                                      color:
                                                          ColorManager.primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                  SafeArea(
                    child: GetBuilder<DependentsController>(
                        builder: (DependentsController controller) {
                      return Visibility(
                        visible: controller.myStudents.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          child: PrimaryButton(
                            onPressed: () async =>
                                await Get.toNamed(Routes.ADD_NEW_DEPENDENT),
                            title: LocaleKeys.add_new_dependent.tr,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
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
