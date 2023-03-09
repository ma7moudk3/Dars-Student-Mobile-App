import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hessa_student/app/modules/order_details/widgets/participant_students_list_bottom_sheet.dart';
import 'package:hessa_student/global_presentation/global_widgets/global_button.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/constants.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/order_details_controller.dart';
import 'cancel_order_bottom_sheet_content.dart';
import 'dars_property_widget.dart';

class OneDarsWidget extends GetView<OrderDetailsController> {
  const OneDarsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color orderStatusColor = ColorManager.primary;
    OrderStatus orderStatus =
        OrderStatus.values[controller.darsOrder.currentStatusId ?? 0];
    log("Current Order Status: $orderStatus");
    switch (orderStatus) {
      case OrderStatus.submitted:
        orderStatusColor = ColorManager.primary;
        break;
      case OrderStatus.confirmed:
        orderStatusColor = ColorManager.primary;
        break;
      case OrderStatus.started:
        orderStatusColor = ColorManager.green;
        break;
      case OrderStatus.tempPaused:
        orderStatusColor = ColorManager.yellow;
        break;
      case OrderStatus.completed:
        orderStatusColor = ColorManager.green;
        break;
      case OrderStatus.cancelled:
        orderStatusColor = ColorManager.red;
        break;
    }
    return Column(
      children: [
        SizedBox(height: 22.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagesManager.lumbPencilIcon),
                  SizedBox(width: 8.w),
                  PrimaryText(
                    "20 ${LocaleKeys.studying_hour.tr}",
                    fontSize: 16,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.fontColor,
                  ),
                  const Spacer(),
                  Container(
                    width: 100.w,
                    height: 29.h,
                    decoration: BoxDecoration(
                      color: orderStatusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: PrimaryText(
                        controller.darsOrder.currentStatusStr ?? "",
                        color: orderStatusColor,
                        fontWeight: FontWeightManager.softLight,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              moreDivider(),
              Column(
                children: List.generate(controller.orderProperties.length,
                    (int index) {
                  return DarsPropertyWidget(
                    iconPath: controller.orderProperties[index]["icon"],
                    title: controller.orderProperties[index]["title"],
                    content: controller.orderProperties[index]["content"] ?? "",
                  );
                }),
              ),
              moreDivider(),
              SizedBox(height: 10.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryText(
                    LocaleKeys.participant_students.tr,
                    fontSize: 14,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.primary,
                  ),
                  const Spacer(),
                  GlobalButton(
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
                        const ParticipantListBottomSheetContent(),
                      );
                    },
                    title: LocaleKeys.see_all.tr,
                    fontSize: 13,
                    width: 75.w,
                    height: 27.h,
                    borderColor: ColorManager.primary,
                    borderRadius: BorderRadius.circular(5),
                    color: ColorManager.transparent,
                    fontWeight: FontWeightManager.softLight,
                  ),
                ],
              ),
              SizedBox(
                width: Get.width,
                height: 100.h,
                child: ListView.builder(
                  itemCount:
                      controller.darsOrderDetails.result?.students?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    String studentPicture =
                        "${Links.baseLink}${Links.nonUsersProfileImageByToken}?id=${controller.darsOrderDetails.result?.students?[index].requesterStudentPhoto ?? -1}";
                    return Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          // Get.toNamed(Routes.STUDENT_DETAILS);
                          log('Student Details ${index + 1}');
                        },
                        child: Row(
                          children: [
                            StatefulBuilder(
                                builder: (BuildContext context, setState) {
                              return Container(
                                width: 44.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
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
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x19000000)
                                          .withOpacity(0.07),
                                      spreadRadius: 0,
                                      offset: const Offset(0, 12),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PrimaryText(
                                  controller.darsOrderDetails.result
                                          ?.students?[index].name ??
                                      "",
                                  fontSize: 14,
                                  fontWeight: FontWeightManager.softLight,
                                ),
                                Row(
                                  children: [
                                    PrimaryText(
                                      "${LocaleKeys.school.tr}: ${controller.darsOrderDetails.result?.students?[index].schoolName ?? ""}",
                                      fontSize: 14,
                                      color: ColorManager.fontColor7,
                                      fontWeight: FontWeightManager.softLight,
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
              moreDivider(),
              SizedBox(height: 10.h),
              GetBuilder<OrderDetailsController>(
                  builder: (OrderDetailsController controlller) {
                if (orderStatus == OrderStatus.submitted &&
                    controller.darsOrderDetails.result?.order
                            ?.preferredprovider !=
                        null &&
                    (controller.darsOrderDetails.result?.candidateProvider ??
                            [])
                        .isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        LocaleKeys.current_preferred_teacher.tr,
                        fontSize: 14,
                        fontWeight: FontWeightManager.softLight,
                        color: ColorManager.primary,
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {},
                          child: Row(
                            children: [
                              StatefulBuilder(
                                  builder: (BuildContext context, setState) {
                                String teacherPicture =
                                    "${Links.baseLink}${Links.profileImageById}?userid=${controller.darsOrderDetails.result?.order?.preferredprovider?["userId"] ?? -1}";
                                return Container(
                                  width: 44.w,
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        teacherPicture,
                                        errorListener: () {
                                          setState(() {
                                            teacherPicture =
                                                "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                                          });
                                        },
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x19000000)
                                            .withOpacity(0.07),
                                        spreadRadius: 0,
                                        offset: const Offset(0, 12),
                                        blurRadius: 15,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryText(
                                    controller.darsOrderDetails.result?.order
                                            ?.preferredprovider?["name"] ??
                                        "",
                                    fontSize: 14,
                                    fontWeight: FontWeightManager.softLight,
                                  ),
                                  SizedBox(
                                      width: 120.w,
                                      child: Tooltip(
                                        message:
                                            "${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["countryName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["governorateName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["localityName"] ?? ""}",
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(16),
                                        showDuration:
                                            const Duration(milliseconds: 5500),
                                        preferBelow: true,
                                        textAlign: detectLang(
                                                text:
                                                    "${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["countryName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["governorateName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["localityName"] ?? ""}")
                                            ? TextAlign.left
                                            : TextAlign.right,
                                        decoration: BoxDecoration(
                                          color: ColorManager.grey5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: PrimaryText(
                                          "${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["countryName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["governorateName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["localityName"] ?? ""}",
                                          fontSize: 12,
                                          maxLines: 1,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                          color: ColorManager.fontColor7,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )),
                                ],
                              ),
                              const Spacer(),
                              GetBuilder<OrderDetailsController>(
                                  builder: (OrderDetailsController controller) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        await controller
                                            .toggleTeacherFavorite();
                                      },
                                      child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: ColorManager.primary
                                              .withOpacity(0.10),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            controller
                                                    .isPreferredTeacherFavorite
                                                ? Icons.favorite_rounded
                                                : Icons
                                                    .favorite_outline_rounded,
                                            size: 30,
                                            color: controller
                                                    .isPreferredTeacherFavorite
                                                ? ColorManager.red
                                                : ColorManager.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        log('Messaging');
                                      },
                                      child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: ColorManager.yellow
                                              .withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            ImagesManager.messagingIcon,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  );
                } else if (orderStatus == OrderStatus.confirmed) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        LocaleKeys.teacher.tr,
                        fontSize: 14,
                        fontWeight: FontWeightManager.softLight,
                        color: ColorManager.primary,
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {},
                          child: Row(
                            children: [
                              StatefulBuilder(
                                  builder: (BuildContext context, setState) {
                                String teacherPicture =
                                    "${Links.baseLink}${Links.profileImageById}?userid=${controller.darsOrderDetails.result?.providerUserId ?? -1}";
                                return Container(
                                  width: 44.w,
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        teacherPicture,
                                        errorListener: () {
                                          setState(() {
                                            teacherPicture =
                                                "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                                          });
                                        },
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x19000000)
                                            .withOpacity(0.07),
                                        spreadRadius: 0,
                                        offset: const Offset(0, 12),
                                        blurRadius: 15,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryText(
                                    controller.darsOrderDetails.result
                                            ?.providerName ??
                                        "",
                                    fontSize: 14,
                                    fontWeight: FontWeightManager.softLight,
                                  ),
                                  SizedBox(
                                      width: 120.w,
                                      child: Tooltip(
                                        message:
                                            "${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["countryName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["governorateName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["localityName"] ?? ""}",
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(16),
                                        showDuration:
                                            const Duration(milliseconds: 5500),
                                        preferBelow: true,
                                        textAlign: detectLang(
                                                text:
                                                    "${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["countryName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["governorateName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["localityName"] ?? ""}")
                                            ? TextAlign.left
                                            : TextAlign.right,
                                        decoration: BoxDecoration(
                                          color: ColorManager.grey5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: PrimaryText(
                                          "${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["countryName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["governorateName"] ?? ""} - ${controller.darsOrderDetails.result?.order?.preferredprovider?["address"]?["localityName"] ?? ""}",
                                          fontSize: 12,
                                          maxLines: 1,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                          color: ColorManager.fontColor7,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )),
                                ],
                              ),
                              const Spacer(),
                              GetBuilder<OrderDetailsController>(
                                  builder: (OrderDetailsController controller) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        await controller
                                            .toggleTeacherFavorite();
                                      },
                                      child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: ColorManager.primary
                                              .withOpacity(0.10),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            controller
                                                    .isPreferredTeacherFavorite
                                                ? Icons.favorite_rounded
                                                : Icons
                                                    .favorite_outline_rounded,
                                            size: 30,
                                            color: controller
                                                    .isPreferredTeacherFavorite
                                                ? ColorManager.red
                                                : ColorManager.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        log('Messaging');
                                      },
                                      child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: ColorManager.yellow
                                              .withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            ImagesManager.messagingIcon,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  );
                  // return Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     PrimaryText(
                  //       orderStatus == OrderStatus.confirmed
                  //           ? LocaleKeys.teacher.tr
                  //           : LocaleKeys.intersted_teachers.tr,
                  //       fontSize: 14,
                  //       fontWeight: FontWeightManager.softLight,
                  //       color: ColorManager.primary,
                  //     ),
                  //     SizedBox(height: 15.h),
                  //     if (controller.darsOrderDetails.result?.candidateProvider
                  //             ?.isNotEmpty ??
                  //         false)
                  //       ListView.builder(
                  //         itemCount: controller.darsOrderDetails.result
                  //                 ?.candidateProvider?.length ??
                  //             0,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           double candidateProviderRate = double.parse(
                  //               controller.darsOrderDetails.result
                  //                       ?.candidateProvider?[index].rate
                  //                       .toString() ??
                  //                   "0.0");
                  //           return GestureDetector(
                  //             onTap: () async {
                  //               // await Get.bottomSheet(
                  //               //   backgroundColor: ColorManager.white,
                  //               //   isScrollControlled: true,
                  //               //   shape: const RoundedRectangleBorder(
                  //               //     borderRadius: BorderRadius.only(
                  //               //       topLeft: Radius.circular(20),
                  //               //       topRight: Radius.circular(20),
                  //               //     ),
                  //               //   ),
                  //               //   OrderCandidateProviderWidget(
                  //               //     candidateProvider: controller.darsOrderDetails
                  //               //         .result?.candidateProvider?[index],
                  //               //   ),
                  //               // );
                  //               Map<String, dynamic> arguments = {
                  //                 "teacherId": controller
                  //                         .darsOrderDetails
                  //                         .result
                  //                         ?.candidateProvider?[index]
                  //                         .providerId ??
                  //                     -1,
                  //               };
                  //               if (OrderStatus.values[
                  //                       controller.darsOrder.currentStatusId ??
                  //                           0] !=
                  //                   OrderStatus.confirmed) {
                  //                 arguments["orderId"] = controller
                  //                         .darsOrderDetails.result?.order?.id ??
                  //                     -1;
                  //               }
                  //               await Get.toNamed(
                  //                 Routes.TEACHER_DETAILS,
                  //                 arguments: arguments,
                  //               );
                  //             },
                  //             child: Container(
                  //               width: Get.width,
                  //               padding: EdgeInsets.symmetric(
                  //                 horizontal: 16.w,
                  //                 vertical: 10.h,
                  //               ),
                  //               margin: EdgeInsets.only(bottom: 15.h),
                  //               decoration: BoxDecoration(
                  //                 color: ColorManager.white,
                  //                 borderRadius: BorderRadius.circular(14.0),
                  //                 boxShadow: const [
                  //                   BoxShadow(
                  //                     color: Color(0x1a000000),
                  //                     offset: Offset(0, 1),
                  //                     blurRadius: 8,
                  //                   ),
                  //                 ],
                  //               ),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(5.0),
                  //                 child: Column(
                  //                   children: [
                  //                     Row(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.end,
                  //                       children: [
                  //                         StatefulBuilder(builder:
                  //                             (BuildContext context, setState) {
                  //                           String
                  //                               candidateProviderPicture = // provider = teacher
                  //                               "${Links.baseLink}${Links.profileImageById}?userid=${controller.darsOrderDetails.result?.candidateProvider?[index].userId ?? -1}";
                  //                           return Container(
                  //                             width: 50.w,
                  //                             height: 50.h,
                  //                             decoration: BoxDecoration(
                  //                               image: DecorationImage(
                  //                                 image:
                  //                                     CachedNetworkImageProvider(
                  //                                   candidateProviderPicture,
                  //                                   errorListener: () {
                  //                                     setState(() {
                  //                                       candidateProviderPicture =
                  //                                           "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                  //                                     });
                  //                                   },
                  //                                 ),
                  //                                 fit: BoxFit.cover,
                  //                               ),
                  //                               borderRadius:
                  //                                   BorderRadius.circular(12),
                  //                               boxShadow: [
                  //                                 BoxShadow(
                  //                                   color:
                  //                                       const Color(0x19000000)
                  //                                           .withOpacity(0.07),
                  //                                   spreadRadius: 0,
                  //                                   offset: const Offset(0, 12),
                  //                                   blurRadius: 15,
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           );
                  //                         }),
                  //                         SizedBox(width: 10.w),
                  //                         Expanded(
                  //                           child: Column(
                  //                             children: [
                  //                               Row(
                  //                                 mainAxisSize:
                  //                                     MainAxisSize.min,
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment.end,
                  //                                 children: [
                  //                                   PrimaryText(
                  //                                     controller
                  //                                             .darsOrderDetails
                  //                                             .result
                  //                                             ?.candidateProvider?[
                  //                                                 index]
                  //                                             .userName ??
                  //                                         "",
                  //                                     color: ColorManager
                  //                                         .fontColor,
                  //                                   ),
                  //                                   const Spacer(),
                  //                                   Row(
                  //                                     mainAxisSize:
                  //                                         MainAxisSize.min,
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment.end,
                  //                                     children: [
                  //                                       Icon(
                  //                                         (candidateProviderRate <=
                  //                                                     5 &&
                  //                                                 candidateProviderRate >
                  //                                                     4)
                  //                                             ? Icons
                  //                                                 .star_rounded
                  //                                             : (candidateProviderRate <=
                  //                                                         3.5 &&
                  //                                                     candidateProviderRate >=
                  //                                                         1)
                  //                                                 ? Icons
                  //                                                     .star_half_rounded
                  //                                                 : Icons
                  //                                                     .star_outline_rounded,
                  //                                         color: ColorManager
                  //                                             .orange,
                  //                                         textDirection:
                  //                                             TextDirection.ltr,
                  //                                         size: 20,
                  //                                       ),
                  //                                       SizedBox(
                  //                                         width: 25.w,
                  //                                         child: PrimaryText(
                  //                                           candidateProviderRate
                  //                                               .toStringAsFixed(
                  //                                                   1),
                  //                                           color: ColorManager
                  //                                               .fontColor,
                  //                                           fontSize: 12,
                  //                                           maxLines: 1,
                  //                                           fontWeight:
                  //                                               FontWeightManager
                  //                                                   .softLight,
                  //                                           overflow:
                  //                                               TextOverflow
                  //                                                   .ellipsis,
                  //                                         ),
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                               SizedBox(height: 5.h),
                  //                               Row(
                  //                                 mainAxisSize:
                  //                                     MainAxisSize.min,
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment.end,
                  //                                 children: [
                  //                                   PrimaryText(
                  //                                     [
                  //                                       "رياضيات",
                  //                                       "علوم",
                  //                                       "فيزياء"
                  //                                     ] // TODO: change to real data
                  //                                         .map((String
                  //                                                 subject) =>
                  //                                             subject
                  //                                                 .toString())
                  //                                         .join(", "),
                  //                                     color:
                  //                                         ColorManager.primary,
                  //                                     fontWeight:
                  //                                         FontWeightManager
                  //                                             .softLight,
                  //                                     fontSize: 11,
                  //                                   ),
                  //                                   const Spacer(),
                  //                                   PrimaryText(
                  //                                     "نابلس, الضفة", // TODO: change to real data
                  //                                     color: ColorManager
                  //                                         .fontColor7,
                  //                                     fontSize: 12,
                  //                                     maxLines: 1,
                  //                                     overflow:
                  //                                         TextOverflow.ellipsis,
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       )
                  //     else ...[
                  //       Center(
                  //         child: Column(
                  //           children: [
                  //             SizedBox(height: 10.h),
                  //             PrimaryText(
                  //               LocaleKeys.no_candidate_providers_yet.tr,
                  //               color: ColorManager.fontColor3,
                  //               fontSize: 14,
                  //               fontWeight: FontWeightManager.medium,
                  //             ),
                  //             SizedBox(height: 20.h),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ],
                  // );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        orderStatus == OrderStatus.confirmed
                            ? LocaleKeys.teacher.tr
                            : LocaleKeys.intersted_teachers.tr,
                        fontSize: 14,
                        fontWeight: FontWeightManager.softLight,
                        color: ColorManager.primary,
                      ),
                      SizedBox(height: 15.h),
                      if (controller.darsOrderDetails.result?.candidateProvider
                              ?.isNotEmpty ??
                          false)
                        ListView.builder(
                          itemCount: controller.darsOrderDetails.result
                                  ?.candidateProvider?.length ??
                              0,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            double candidateProviderRate = double.parse(
                                controller.darsOrderDetails.result
                                        ?.candidateProvider?[index].rate
                                        .toString() ??
                                    "0.0");
                            return GestureDetector(
                              onTap: () async {
                                // await Get.bottomSheet(
                                //   backgroundColor: ColorManager.white,
                                //   isScrollControlled: true,
                                //   shape: const RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.only(
                                //       topLeft: Radius.circular(20),
                                //       topRight: Radius.circular(20),
                                //     ),
                                //   ),
                                //   OrderCandidateProviderWidget(
                                //     candidateProvider: controller.darsOrderDetails
                                //         .result?.candidateProvider?[index],
                                //   ),
                                // );
                                Map<String, dynamic> arguments = {
                                  "teacherId": controller
                                          .darsOrderDetails
                                          .result
                                          ?.candidateProvider?[index]
                                          .providerId ??
                                      -1,
                                };
                                if (OrderStatus.values[
                                        controller.darsOrder.currentStatusId ??
                                            0] !=
                                    OrderStatus.confirmed) {
                                  arguments["orderId"] = controller
                                          .darsOrderDetails.result?.order?.id ??
                                      -1;
                                }
                                await Get.toNamed(
                                  Routes.TEACHER_DETAILS,
                                  arguments: arguments,
                                );
                              },
                              child: Container(
                                width: Get.width,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 10.h,
                                ),
                                margin: EdgeInsets.only(bottom: 15.h),
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(14.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x1a000000),
                                      offset: Offset(0, 1),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          StatefulBuilder(builder:
                                              (BuildContext context, setState) {
                                            String
                                                candidateProviderPicture = // provider = teacher
                                                "${Links.baseLink}${Links.profileImageById}?userid=${controller.darsOrderDetails.result?.candidateProvider?[index].userId ?? -1}";
                                            return Container(
                                              width: 50.w,
                                              height: 50.h,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    candidateProviderPicture,
                                                    errorListener: () {
                                                      setState(() {
                                                        candidateProviderPicture =
                                                            "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                                                      });
                                                    },
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0x19000000)
                                                            .withOpacity(0.07),
                                                    spreadRadius: 0,
                                                    offset: const Offset(0, 12),
                                                    blurRadius: 15,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    PrimaryText(
                                                      controller
                                                              .darsOrderDetails
                                                              .result
                                                              ?.candidateProvider?[
                                                                  index]
                                                              .userName ??
                                                          "",
                                                      color: ColorManager
                                                          .fontColor,
                                                    ),
                                                    const Spacer(),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Icon(
                                                          (candidateProviderRate <=
                                                                      5 &&
                                                                  candidateProviderRate >
                                                                      4)
                                                              ? Icons
                                                                  .star_rounded
                                                              : (candidateProviderRate <=
                                                                          3.5 &&
                                                                      candidateProviderRate >=
                                                                          1)
                                                                  ? Icons
                                                                      .star_half_rounded
                                                                  : Icons
                                                                      .star_outline_rounded,
                                                          color: ColorManager
                                                              .orange,
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 25.w,
                                                          child: PrimaryText(
                                                            candidateProviderRate
                                                                .toStringAsFixed(
                                                                    1),
                                                            color: ColorManager
                                                                .fontColor,
                                                            fontSize: 12,
                                                            maxLines: 1,
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .softLight,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    PrimaryText(
                                                      [
                                                        "رياضيات",
                                                        "علوم",
                                                        "فيزياء"
                                                      ] // TODO: change to real data
                                                          .map((String
                                                                  subject) =>
                                                              subject
                                                                  .toString())
                                                          .join(", "),
                                                      color:
                                                          ColorManager.primary,
                                                      fontWeight:
                                                          FontWeightManager
                                                              .softLight,
                                                      fontSize: 11,
                                                    ),
                                                    const Spacer(),
                                                    PrimaryText(
                                                      "نابلس, الضفة", // TODO: change to real data
                                                      color: ColorManager
                                                          .fontColor7,
                                                      fontSize: 12,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      else ...[
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              PrimaryText(
                                LocaleKeys.no_candidate_providers_yet.tr,
                                color: ColorManager.fontColor3,
                                fontSize: 14,
                                fontWeight: FontWeightManager.medium,
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ],
                    ],
                  );
                }
              }),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: (Get.height * 0.075).h,
          ),
          child: PrimaryButton(
            isDisabled: controller
                    .darsOrderDetails.result?.order?.currentStatusId ==
                OrderStatus.cancelled
                    .index, // TODO: if another condition is added, change this
            onPressed: () async {
              await Get.bottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                const CancelDarsBottomSheetContent(),
                backgroundColor: ColorManager.white,
              ).whenComplete(() => controller.clearData());
            },
            title: LocaleKeys.cancel_dars.tr,
          ),
        ),
      ],
    );
  }
}
