import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/modules/order_hessa/controllers/order_hessa_controller.dart';
import 'package:hessa_student/app/modules/order_hessa/widgets/delete_student_dialog_content.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../../data/models/classes/item.dart';
import '../../../routes/app_pages.dart';
import '../../dependents/data/models/student/student.dart';

class DependentsListBottomSheetContent extends GetView<OrderHessaController> {
  const DependentsListBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 26.w,
                height: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.borderColor3,
                ),
              ),
            ),
            Container(
              height: (Get.height * 0.5).h,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.white,
              ),
              child: GetBuilder<OrderHessaController>(
                  builder: (OrderHessaController controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryText(
                      LocaleKeys.dependents_list,
                      fontSize: 14.sp,
                      fontWeight: FontWeightManager.book,
                    ),
                    SizedBox(height: 30.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: RefreshIndicator(
                          color: ColorManager.white,
                          backgroundColor: ColorManager.primary,
                          onRefresh: () async => await Future.sync(
                              () => controller.pagingController.refresh()),
                          child: PagedListView<int, Student>(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            pagingController: controller.pagingController,
                            builderDelegate: PagedChildBuilderDelegate<Student>(
                              animateTransitions: true,
                              transitionDuration:
                                  const Duration(milliseconds: 350),
                              firstPageErrorIndicatorBuilder:
                                  (BuildContext context) {
                                return Center(
                                  child: SpinKitCircle(
                                    duration:
                                        const Duration(milliseconds: 1300),
                                    size: 40,
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
                                      height: 250.h,
                                      width: 250.w,
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
                                    size: 40,
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
                                        size: 40,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      ImagesManager.dependents,
                                      width: Get.width,
                                      height: 160.h,
                                    ),
                                    PrimaryText(
                                      LocaleKeys.there_are_no_dependents,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeightManager.softLight,
                                    ),
                                    SizedBox(height: 8.h),
                                    PrimaryText(
                                      LocaleKeys.you_can_add_new_dependent,
                                      fontSize: 16.sp,
                                      color: ColorManager.fontColor7,
                                      fontWeight: FontWeightManager.softLight,
                                    ),
                                  ],
                                );
                              },
                              itemBuilder: (BuildContext context,
                                  Student student, int index) {
                                return GetBuilder<OrderHessaController>(
                                    builder: (OrderHessaController controller) {
                                  String studentPicture =
                                      "${Links.baseLink}${Links.nonUsersProfileImageByToken}?id=${student.requesterStudent?.requesterStudentPhoto ?? -1}";
                                  return CheckboxListTile(
                                    side: BorderSide(
                                      color: ColorManager.borderColor2,
                                      width: 2,
                                    ),
                                    value: controller.selectedStudents
                                            .firstWhereOrNull(
                                          (Student tempStudent) =>
                                              (tempStudent
                                                      .requesterStudent?.id ??
                                                  -1) ==
                                              (student.requesterStudent?.id ??
                                                  0),
                                        ) !=
                                        null, // like contains
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            StatefulBuilder(builder:
                                                (BuildContext context,
                                                    setState) {
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
                                                        ImagesManager
                                                            .classIcon),
                                                    SizedBox(width: 5.w),
                                                    PrimaryText(
                                                      controller.classes.result
                                                              ?.items
                                                              ?.where((Item
                                                                      level) =>
                                                                  (level.id ??
                                                                      -1) ==
                                                                  (student.requesterStudent
                                                                          ?.levelId ??
                                                                      0))
                                                              .first
                                                              .displayName ??
                                                          "",
                                                      fontSize: 14.sp,
                                                      color: ColorManager
                                                          .fontColor7,
                                                      fontWeight:
                                                          FontWeightManager
                                                              .softLight,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
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
                                                      BorderRadius.circular(14),
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
                                          ],
                                        ),
                                        SizedBox(height: 15.h),
                                        Divider(
                                          color: ColorManager.borderColor3,
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    activeColor: ColorManager.primary,
                                    selectedTileColor: ColorManager.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    checkboxShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: ColorManager.primary,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    onChanged: (bool? isChecked) =>
                                        controller.selectStudent(
                                            student, isChecked ?? false),
                                  );
                                });
                                // return Padding(
                                //   padding: EdgeInsets.symmetric(vertical: 5.h),
                                //   child: Column(
                                //     children: [
                                //       Row(
                                //         children: [
                                //           GestureDetector(
                                //             onTap: () async {},
                                //             child: Container(
                                //               height: 22.h,
                                //               width: 20.w,
                                //               decoration: BoxDecoration(
                                //                 borderRadius:
                                //                     BorderRadius.circular(8),
                                //                 border: Border.all(
                                //                   color: ColorManager.primary,
                                //                   width: 2.w,
                                //                 ),
                                //               ),
                                //               child: Center(
                                //                 child: Icon(
                                //                   Icons.check_rounded,
                                //                   color: ColorManager.primary,
                                //                   size: 13.sp,
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //           SizedBox(width: 10.w),
                                //           Container(
                                //             width: 58.w,
                                //             height: 65.h,
                                //             decoration: BoxDecoration(
                                //               image: DecorationImage(
                                //                 image: AssetImage(controller
                                //                         .dependentsController
                                //                         .dummyDependents[index]
                                //                     ["dependent_image"]),
                                //                 fit: BoxFit.cover,
                                //               ),
                                //               border: Border.all(
                                //                 width: 1,
                                //                 color: ColorManager.primary,
                                //               ),
                                //               borderRadius:
                                //                   BorderRadius.circular(20),
                                //             ),
                                //           ),
                                //           SizedBox(width: 10.w),
                                //           Column(
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             children: [
                                //               PrimaryText(
                                //                 controller.dependentsController
                                //                         .dummyDependents[index]
                                //                     ["dependent_name"],
                                //               ),
                                //               SizedBox(
                                //                 height: 15.h,
                                //               ),
                                //               Row(
                                //                 children: [
                                //                   SvgPicture.asset(
                                //                       ImagesManager.classIcon),
                                //                   SizedBox(width: 5.w),
                                //                   PrimaryText(
                                //                     controller
                                //                             .dependentsController
                                //                             .dummyDependents[
                                //                         index]["class"],
                                //                     fontSize: 14.sp,
                                //                     color:
                                //                         ColorManager.fontColor7,
                                //                     fontWeight: FontWeightManager
                                //                         .softLight,
                                //                   ),
                                //                 ],
                                //               ),
                                //             ],
                                //           ),
                                //           const Spacer(),
                                //           GestureDetector(
                                //             behavior: HitTestBehavior.opaque,
                                //             onTap: () async {
                                //               log('delete');
                                //             },
                                //             child: Container(
                                //               width: 36.w,
                                //               height: 36.h,
                                //               decoration: BoxDecoration(
                                //                 color: ColorManager.red
                                //                     .withOpacity(0.10),
                                //                 borderRadius:
                                //                     BorderRadius.circular(14),
                                //               ),
                                //               child: Center(
                                //                 child: SvgPicture.asset(
                                //                   ImagesManager.deleteIcon,
                                //                   height: 20.h,
                                //                   width: 20.w,
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       SizedBox(height: 15.h),
                                //       Visibility(
                                //         visible: index !=
                                //             (controller.dependentsController
                                //                     .dummyDependents.length -
                                //                 1),
                                //         child: Divider(
                                //           color: ColorManager.borderColor3,
                                //           thickness: 1,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GetBuilder<OrderHessaController>(
                        builder: (OrderHessaController controller) {
                      if (controller.pagingController.itemList != null &&
                          controller.pagingController.itemList!.isNotEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryButton(
                              width: 265.w,
                              onPressed: () => Get.back(),
                              title: LocaleKeys.save.tr,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (Get.isBottomSheetOpen!) {
                                  Get.back();
                                }
                                await Get.toNamed(Routes.ADD_NEW_DEPENDENT,
                                    arguments: {
                                      "isFromOrderHessa": true,
                                    });
                              },
                              child: Container(
                                width: 48.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: ColorManager.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: ColorManager.white,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return PrimaryButton(
                          width: Get.width.w,
                          onPressed: () async {
                            if (Get.isBottomSheetOpen!) {
                              Get.back();
                            }
                            await Get.toNamed(Routes.ADD_NEW_DEPENDENT,
                                arguments: {
                                  "isFromOrderHessa": true,
                                });
                          },
                          title: LocaleKeys.add_dependent.tr,
                        );
                      }
                    })
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
