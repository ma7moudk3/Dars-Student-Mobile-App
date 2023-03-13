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
import 'droos_list_widget.dart';

class OneDarsWidget extends GetView<OrderDetailsController> {
  const OneDarsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color orderStatusColor = ColorManager.primary;
    OrderStatus orderStatus = OrderStatus.values[
        controller.darsOrderDetails.value.result?.order?.currentStatusId ?? 0];
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
    return GetBuilder<OrderDetailsController>(
        builder: (OrderDetailsController controller) {
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
                      "${(controller.darsOrderDetails.value.result?.order?.duration ?? 1).toInt()} ${LocaleKeys.studying_hour.tr}",
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
                          controller.darsOrderDetails.value.result
                                  ?.currentStatusStr ??
                              "",
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
                    if (controller.orderProperties[index]["content"] != null &&
                        controller
                            .orderProperties[index]["content"].isNotEmpty) {
                      return DarsPropertyWidget(
                        iconPath: controller.orderProperties[index]["icon"],
                        title: controller.orderProperties[index]["title"],
                        content:
                            controller.orderProperties[index]["content"] ?? "",
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                ),
                moreDivider(),
                SizedBox(height: 10.h),
                DroosListWidget(
                  orderStatus: orderStatus,
                ),
                SizedBox(height: 20.h),
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
                    itemCount: (controller.darsOrderDetails.value.result
                                    ?.students?.length ??
                                0) >
                            3
                        ? 3
                        : controller.darsOrderDetails.value.result?.students
                                ?.length ??
                            0,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      String studentPicture =
                          "${Links.baseLink}${Links.nonUsersProfileImageByToken}?id=${controller.darsOrderDetails.value.result?.students?[index].requesterStudentPhoto ?? -1}";
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
                                    controller.darsOrderDetails.value.result
                                            ?.students?[index].name ??
                                        "",
                                    fontSize: 14,
                                    fontWeight: FontWeightManager.softLight,
                                  ),
                                  Row(
                                    children: [
                                      PrimaryText(
                                        "${LocaleKeys.school.tr}: ${controller.darsOrderDetails.value.result?.students?[index].schoolName ?? ""}",
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
                GetBuilder<OrderDetailsController>(
                    builder: (OrderDetailsController controlller) {
                  if (controller.darsOrderDetails.value.result?.order
                              ?.providerId !=
                          null &&
                      controller.darsOrderDetails.value.result?.order
                              ?.providerId !=
                          0 &&
                      controller
                              .darsOrderDetails.value.result?.providerUserId !=
                          null &&
                      controller
                              .darsOrderDetails.value.result?.providerUserId !=
                          0) {
                    // if thie conidtion here is true it means that >> There's an assigned teacher for this order
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        moreDivider(),
                        SizedBox(height: 10.h),
                        PrimaryText(
                          LocaleKeys.assigned_teacher.tr,
                          fontSize: 14,
                          fontWeight: FontWeightManager.softLight,
                          color: ColorManager.primary,
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              int teacherId = controller.darsOrderDetails.value
                                      .result?.order?.providerId ??
                                  -1;
                              await Get.toNamed(
                                Routes.TEACHER_DETAILS,
                                arguments: {
                                  "teacherId": teacherId,
                                },
                              );
                            },
                            child: Row(
                              children: [
                                StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                  String teacherPicture =
                                      "${Links.baseLink}${Links.profileImageById}?userid=${controller.darsOrderDetails.value.result?.providerUserId ?? -1}";
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
                                PrimaryText(
                                  controller.darsOrderDetails.value.result
                                          ?.providerName ??
                                      "",
                                  fontSize: 14,
                                  fontWeight: FontWeightManager.softLight,
                                ),
                                const Spacer(),
                                GetBuilder<OrderDetailsController>(builder:
                                    (OrderDetailsController controller) {
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
                                        onTap: () async {
                                          await Get.toNamed(Routes.CHAT);
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
                  } else {
                    return Column(
                      children: [
                        Visibility(
                          visible: controller.darsOrderDetails.value.result
                                      ?.order?.preferredproviderId !=
                                  null &&
                              controller.darsOrderDetails.value.result?.order
                                      ?.preferredproviderId !=
                                  0 &&
                              (controller.darsOrderDetails.value.result?.order
                                          ?.preferredproviderIsReject ==
                                      null ||
                                  controller.darsOrderDetails.value.result
                                          ?.order?.preferredproviderIsReject ==
                                      false),
                          child: Column(
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
                                  onTap: () async {
                                    int teacherId = controller
                                            .darsOrderDetails
                                            .value
                                            .result
                                            ?.order
                                            ?.preferredproviderId ??
                                        -1;
                                    if (teacherId != -1) {
                                      await Get.toNamed(
                                        Routes.TEACHER_DETAILS,
                                        arguments: {
                                          "teacherId": teacherId,
                                        },
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      StatefulBuilder(builder:
                                          (BuildContext context, setState) {
                                        String teacherPicture =
                                            "${Links.baseLink}${Links.profileImageById}?userid=${controller.darsOrderDetails.value.result?.order?.preferredprovider?["userId"] ?? -1}";
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
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PrimaryText(
                                            controller
                                                        .darsOrderDetails
                                                        .value
                                                        .result
                                                        ?.order
                                                        ?.preferredprovider?[
                                                    "name"] ??
                                                "",
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                          ),
                                          SizedBox(
                                              width: 120.w,
                                              child: Tooltip(
                                                message:
                                                    "${controller.darsOrderDetails.value.result?.order?.preferredprovider?["address"]?["countryName"] ?? ""} - ${controller.darsOrderDetails.value.result?.order?.preferredprovider?["address"]?["governorateName"] ?? ""} - ${controller.darsOrderDetails.value.result?.order?.preferredprovider?["address"]?["localityName"] ?? ""}",
                                                padding:
                                                    const EdgeInsets.all(10),
                                                     textStyle: TextStyle(
                color: ColorManager.white,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                fontFamily: FontConstants.fontFamily,
              ),
                                                margin:
                                                    const EdgeInsets.all(16),
                                                showDuration: const Duration(
                                                    milliseconds: 5500),
                                                preferBelow: true,
                                                textAlign: detectLang(
                                                        text:
                                                            "${controller.darsOrderDetails.value.result?.order?.preferredprovider?["address"]?["countryName"] ?? ""} - ${controller.darsOrderDetails.value.result?.order?.preferredprovider?["address"]?["governorateName"] ?? ""} - ${controller.darsOrderDetails.value.result?.order?.preferredprovider?["address"]?["localityName"] ?? ""}")
                                                    ? TextAlign.left
                                                    : TextAlign.right,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.grey5,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                triggerMode:
                                                    TooltipTriggerMode.tap,
                                                child: PrimaryText(
                                                  "${controller.darsOrderDetails.value.result?.order?.preferredprovider?["address"]?["countryName"] ?? ""} - ${controller.darsOrderDetails.value.result?.order?.preferredprovider?["address"]?["governorateName"] ?? ""} - ${controller.darsOrderDetails.value.result?.order?.preferredprovider?["address"]?["localityName"] ?? ""}",
                                                  fontSize: 12,
                                                  maxLines: 1,
                                                  fontWeight: FontWeightManager
                                                      .softLight,
                                                  color:
                                                      ColorManager.fontColor7,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const Spacer(),
                                      GetBuilder<OrderDetailsController>(
                                          builder: (OrderDetailsController
                                              controller) {
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
                                              onTap: () async {
                                                await Get.toNamed(Routes.CHAT);
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
                          ),
                        ),
                        moreDivider(),
                        SizedBox(height: 5.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              LocaleKeys.intersted_teachers.tr,
                              fontSize: 14,
                              fontWeight: FontWeightManager.softLight,
                              color: ColorManager.primary,
                            ),
                            SizedBox(height: 15.h),
                            if (controller.darsOrderDetails.value.result
                                    ?.candidateProvider?.isNotEmpty ??
                                false)
                              ListView.builder(
                                itemCount: controller.darsOrderDetails.value
                                        .result?.candidateProvider?.length ??
                                    0,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  double candidateProviderRate = double.parse(
                                      controller.darsOrderDetails.value.result
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
                                      //     candidateProvider: controller.darsOrderDetails.value
                                      //         .result?.candidateProvider?[index],
                                      //   ),
                                      // );
                                      Map<String, dynamic> arguments = {
                                        "teacherId": controller
                                                .darsOrderDetails
                                                .value
                                                .result
                                                ?.candidateProvider?[index]
                                                .providerId ??
                                            -1,
                                      };
                                      if (OrderStatus.values[controller
                                                  .darsOrderDetails
                                                  .value
                                                  .result
                                                  ?.order
                                                  ?.currentStatusId ??
                                              0] !=
                                          OrderStatus.confirmed) {
                                        arguments["orderId"] = controller
                                                .darsOrderDetails
                                                .value
                                                .result
                                                ?.order
                                                ?.id ??
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
                                        borderRadius:
                                            BorderRadius.circular(14.0),
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
                                                  CrossAxisAlignment.center,
                                              children: [
                                                StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        setState) {
                                                  String
                                                      candidateProviderPicture = // provider = teacher
                                                      "${Links.baseLink}${Links.profileImageById}?userid=${controller.darsOrderDetails.value.result?.candidateProvider?[index].userId ?? -1}";
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
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                                  0x19000000)
                                                              .withOpacity(
                                                                  0.07),
                                                          spreadRadius: 0,
                                                          offset: const Offset(
                                                              0, 12),
                                                          blurRadius: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                                SizedBox(width: 10.w),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      PrimaryText(
                                                        controller
                                                                .darsOrderDetails
                                                                .value
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
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
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
                                                                TextDirection
                                                                    .ltr,
                                                            size: 22,
                                                          ),
                                                          SizedBox(
                                                            width: 25.w,
                                                            child: PrimaryText(
                                                              candidateProviderRate
                                                                  .toStringAsFixed(
                                                                      1),
                                                              color: ColorManager
                                                                  .fontColor,
                                                              fontSize: 13,
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
                                      orderStatus == OrderStatus.cancelled
                                          ? LocaleKeys.no_candidate_providers.tr
                                          : LocaleKeys
                                              .no_candidate_providers_yet.tr,
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
                        ),
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
            child: Column(
              children: [
                PrimaryButton(
                  isDisabled: controller.darsOrderDetails.value.result?.order
                          ?.currentStatusId ==
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
                  title: controller.darsOrderDetails.value.result?.order
                              ?.currentStatusId ==
                          OrderStatus.cancelled.index
                      ? LocaleKeys.order_already_cancelled.tr
                      : LocaleKeys.cancel_order_dars.tr,
                ),
                Visibility(
                  visible: orderStatus ==
                      OrderStatus
                          .submitted, // TODO: if another condition is added or the condition is changed, change it
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      GlobalButton(
                        width: Get.width,
                        height: 55.h,
                        fontSize: 14,
                        borderRadius: BorderRadius.circular(15.r),
                        onTap: () async {
                          await Get.toNamed(Routes.ORDER_DARS, arguments: {
                            "orderIdToEdit": controller
                                    .darsOrderDetails.value.result?.order?.id ??
                                -1,
                          });
                        },
                        fontColor: ColorManager.fontColor4,
                        title: LocaleKeys.edit_order_dars.tr,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
