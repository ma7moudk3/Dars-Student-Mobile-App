import 'dart:developer';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/constants/constants.dart';
import 'package:hessa_student/app/modules/order_details/data/models/order_session/order_session.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/expansion_tile_card.dart';
import '../../../constants/exports.dart';
import '../controllers/order_details_controller.dart';
import 'dars_property_widget.dart';

class DroosListWidget extends GetView<OrderDetailsController> {
  const DroosListWidget({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, OrderSession>(
      pagingController: controller.pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<OrderSession>(
        animateTransitions: true,
        transitionDuration: const Duration(milliseconds: 350),
        firstPageErrorIndicatorBuilder: (BuildContext context) {
          return Center(
            child: SpinKitCircle(
              duration: const Duration(milliseconds: 1300),
              size: 50,
              color: ColorManager.primary,
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (BuildContext context) {
          return Column(
            children: [
              SizedBox(height: 50.h),
              Lottie.asset(
                LottiesManager.searchingLight,
                animate: true,
                width: 200.w,
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
        newPageProgressIndicatorBuilder: (BuildContext context) {
          return Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                child: SpinKitCircle(
                  duration: const Duration(milliseconds: 1300),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                LocaleKeys.droos_list.tr,
                fontSize: 16,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.primary,
              ),
              SizedBox(height: 20.h),
              Center(
                child: PrimaryText(
                  orderStatus == OrderStatus.cancelled
                      ? "${LocaleKeys.had_no_droos.tr} !"
                      : "${LocaleKeys.no_droos_yet.tr} !",
                  fontSize: 16,
                  fontWeight: FontWeightManager.softLight,
                  color: ColorManager.fontColor,
                ),
              ),
              SizedBox(height: 20.h),
            ],
          );
        },
        itemBuilder:
            (BuildContext context, OrderSession orderSession, int index) {
          DateTime preferredStartDate = DateFormat('yyyy-MM-dd')
              .parse((orderSession.session?.startDate ?? '').split("T")[0]);
          DateTime preferredStartTime = DateFormat('HH:mm:ss')
              .parse((orderSession.session?.startDate ?? '').split("T")[1]);
          DateTime preferredEndDate = DateFormat('yyyy-MM-dd')
              .parse((orderSession.session?.endDate ?? '').split("T")[0]);
          DateTime preferredEndTime = DateFormat('HH:mm:ss')
              .parse((orderSession.session?.endDate ?? '').split("T")[1]);
          List<Map<String, dynamic>> orderProperties = [
            {
              "icon": ImagesManager.clockIocn,
              "title": LocaleKeys.timing.tr,
              "content": "${DateFormat.jm('ar_SA').format(
                DateTime(
                  preferredStartDate.year,
                  preferredStartDate.month,
                  preferredStartDate.day,
                  preferredStartTime.hour,
                  preferredStartTime.minute,
                ),
              )} - ${DateFormat.jm('ar_SA').format(
                DateTime(
                  preferredEndDate.year,
                  preferredEndDate.month,
                  preferredEndDate.day,
                  preferredEndTime.hour,
                  preferredEndTime.minute,
                ),
              )}",
            },
            {
              "icon": ImagesManager.calendarIcon,
              "title": LocaleKeys.date.tr,
              "content": DateFormat("dd MMMM yyyy", "ar_SA")
                  .format(preferredStartDate),
            },
            {
              "icon": ImagesManager.tvIcon,
              "title": LocaleKeys.session.tr,
              "content": orderSession.session?.sessionTypeId == 0
                  ? LocaleKeys.face_to_face.tr
                  : orderSession.session?.sessionTypeId == 1
                      ? LocaleKeys.electronic.tr
                      : LocaleKeys.both.tr,
            },
            {
              "icon": ImagesManager.boardIcon,
              "title": LocaleKeys.dars_type.tr,
              "content": orderSession.productName ?? "",
            },
            {
              "icon": ImagesManager.addressIcon,
              "title": LocaleKeys.address.tr,
              "content": controller.darsOrderDetails.value.result?.address
                      ?.addressDetails?.name ??
                  "",
            },
            {
              "icon": ImagesManager.personIcon,
              "title": LocaleKeys.students_count.tr,
              "content": controller
                  .getStudentsCountString(orderSession.studentCount ?? 0),
            },
          ];
          Color sessionStatusColor = ColorManager.primary;
          SessionStatus sessionStatus =
              SessionStatus.values[orderSession.session?.currentStatusId ?? 0];
          log("Current Session Status: $sessionStatus");
          switch (sessionStatus) {
            case SessionStatus.notStarted:
              sessionStatusColor = ColorManager.primary;
              break;
            case SessionStatus.inProgress:
              sessionStatusColor = ColorManager.green;
              break;
            case SessionStatus.paused:
              sessionStatusColor = ColorManager.yellow;
              break;
            case SessionStatus.completed:
              sessionStatusColor = ColorManager.green;
              break;
            case SessionStatus.cancelled:
              sessionStatusColor = ColorManager.red;
              break;
          }
          return Column(
            children: [
              ExpansionTileCard(
                heightFactorCurve: Curves.easeInOut,
                colorCurve: Curves.bounceIn,
                onExpansionChanged: (bool isExpanded) => log('$isExpanded'),
                title: PrimaryText(
                  "${LocaleKeys.dars.tr} (${index + 1})",
                  fontSize: 14,
                  fontWeight: FontWeightManager.softLight,
                ),
                subtitle: SizedBox(
                  width: 170.w,
                  child: PrimaryText(
                    "رياضيات الصف الاول",
                    fontSize: 13,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.primary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                borderRadius: BorderRadius.circular(14.0),
                shadowColor: const Color(0x1a000000),
                animateTrailing: true,
                trailing: Container(
                  width: 100.w,
                  height: 29.h,
                  decoration: BoxDecoration(
                    color: sessionStatusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 18.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: sessionStatusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        /* enum SessionStatus { notStarted, inProgress, paused, completed, cancelled } */
                        child: Icon(
                          sessionStatus == SessionStatus.notStarted
                              ? Icons.not_started_rounded
                              : sessionStatus == SessionStatus.inProgress
                                  ? Icons.play_arrow_rounded
                                  : sessionStatus == SessionStatus.paused
                                      ? Icons.pause_rounded
                                      : sessionStatus == SessionStatus.completed
                                          ? Icons.check_rounded
                                          : Icons.close_rounded, // cancelled
                          color: sessionStatusColor,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      PrimaryText(
                        orderSession.session?.currentStatusName ??
                            (sessionStatus == SessionStatus.notStarted
                                ? LocaleKeys.not_started.tr
                                : sessionStatus == SessionStatus.inProgress
                                    ? LocaleKeys.in_progress.tr
                                    : sessionStatus == SessionStatus.paused
                                        ? LocaleKeys.paused.tr
                                        : sessionStatus ==
                                                SessionStatus.completed
                                            ? LocaleKeys.completed.tr
                                            : LocaleKeys.cancelled.tr),
                        color: sessionStatusColor,
                        fontWeight: FontWeightManager.softLight,
                      ),
                    ],
                  ),
                ),
                // TODO: if the requester is allowed to delete the session then show the delete icon
                // trailing: GestureDetector(
                //   behavior: HitTestBehavior.opaque,
                //   onTap: () async {
                //     await Get.dialog(
                //       Container(
                //         color: ColorManager.black.withOpacity(0.1),
                //         height: 140.h,
                //         width: 140.w,
                //         child: Center(
                //           child: Container(
                //             width: Get.width,
                //             margin: EdgeInsets.symmetric(
                //               horizontal: 18.w,
                //             ),
                //             child: DeleteSessionBottomSheetContent(
                //               deleteSessionFunction: () async {
                //                 await controller.deleteSession(
                //                   sessionId: orderSession.session?.id ?? -1,
                //                 );
                //               },
                //             ),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                //   child: Container(
                //     width: 36.w,
                //     height: 36.h,
                //     decoration: BoxDecoration(
                //       color: ColorManager.red.withOpacity(0.10),
                //       borderRadius: BorderRadius.circular(14),
                //     ),
                //     child: Center(
                //       child: SvgPicture.asset(
                //         ImagesManager.deleteIcon,
                //         height: 20.h,
                //         width: 20.w,
                //       ),
                //     ),
                //   ),
                // ),
                leading: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: ColorManager.primary,
                      size: 20,
                    ),
                  ),
                ),
                duration: const Duration(milliseconds: 500),
                children: List.generate(orderProperties.length, (int index) {
                  return DarsPropertyWidget(
                    iconPath: orderProperties[index]["icon"],
                    title: orderProperties[index]["title"],
                    content: orderProperties[index]["content"] ?? "",
                  );
                }),
              ),
              Visibility(
                visible: index != 1, // index != length - 1 (last index)
                child: SizedBox(height: 20.h),
              ),
            ],
          );
        },
      ),
    );
  }
}
