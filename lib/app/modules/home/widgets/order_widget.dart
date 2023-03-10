import 'package:cached_network_image/cached_network_image.dart';
import 'package:hessa_student/app/routes/app_pages.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:intl/intl.dart';

import '../../../constants/constants.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../orders/controllers/orders_controller.dart';
import '../data/models/dars_order.dart';

class OrderWidget extends GetView<OrdersController> {
  final bool isFirst;

  const OrderWidget({
    Key? key,
    this.isFirst = false,
    required this.darsOrder,
  }) : super(key: key);
  final DarsOrder darsOrder;
  @override
  Widget build(BuildContext context) {
    Color orderStatusColor = ColorManager.primary;
    OrderStatus orderStatus =
        OrderStatus.values[darsOrder.currentStatusId ?? 0];
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
    String teacherPicture = darsOrder.providerUserId != null
        ? "${Links.baseLink}${Links.profileImageById}?userid=${darsOrder.providerUserId.toString()}"
        : "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await Get.toNamed(Routes.DARS_DETAILS, arguments: darsOrder);
      },
      child: Container(
        height: 186.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xfeffffff),
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1a000000),
              offset: Offset(0, 1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: Get.height,
              width: 45.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: ColorManager.primary.withOpacity(0.10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(
                      DateTime.parse(darsOrder.preferredStartDate ?? '')
                          .day
                          .toString()
                          .padLeft(2, '0'),
                      fontSize: 18,
                      color: ColorManager.primary,
                      fontWeight: FontWeightManager.light,
                    ),
                    PrimaryText(
                      months[DateFormat('yyyy-MM-ddTHH:mm:ss')
                                  .parse(darsOrder.preferredStartDate ?? '')
                                  .month -
                              1]
                          .toString(),
                      fontSize: 12,
                      color: ColorManager.primary,
                      fontWeight: FontWeightManager.softLight,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: PrimaryText(
                          darsOrder.levelTopic ?? "",
                          fontSize: 14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: ColorManager.fontColor,
                          fontWeight: FontWeightManager.softLight,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: ColorManager.primary.withOpacity(0.10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: ColorManager.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: ColorManager.dividerColor,
                    thickness: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 25.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: teacherPicture,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  ImagesManager.guest,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          PrimaryText(
                            darsOrder.providerName != null &&
                                    darsOrder.providerName!.isNotEmpty
                                ? darsOrder.providerName!
                                : (orderStatus == OrderStatus.cancelled
                                    ? LocaleKeys.had_no_assigned_teacher.tr
                                    : LocaleKeys.no_teacher_assigned.tr),
                            fontSize: 14,
                            color: ColorManager.fontColor7,
                            fontWeight: FontWeightManager.softLight,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                size: 18,
                                color: ColorManager.yellow,
                              ),
                              SizedBox(width: 5.w),
                              PrimaryText(
                                darsOrder.preferredStartDate != null
                                    ? darsOrder.preferredEndDate != null
                                        ? '${DateFormat('h:mm a', 'ar_SA').format(DateTime.parse(darsOrder.preferredStartDate ?? ''))} - ${DateFormat('h:mm a', 'ar_SA').format(DateTime.parse(darsOrder.preferredEndDate ?? ''))}'
                                        : DateFormat('h:mm a', 'ar_SA').format(
                                            DateTime.parse(
                                                darsOrder.preferredStartDate ??
                                                    ''))
                                    : '',
                                fontSize: 13,
                                color: ColorManager.fontColor7,
                                fontWeight: FontWeightManager.softLight,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(width: Get.height * 0.015.w),
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline_rounded,
                                size: 18,
                                color: ColorManager.yellow,
                              ),
                              SizedBox(width: 5.w),
                              SizedBox(
                                width: 75.w,
                                child: PrimaryText(
                                  "${darsOrder.studentCount ?? 0} ${LocaleKeys.participants.tr}",
                                  fontSize: 14,
                                  color: ColorManager.fontColor7,
                                  fontWeight: FontWeightManager.softLight,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 80.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: orderStatusColor.withOpacity(0.15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 18.w,
                              height: 18.h,
                              decoration: BoxDecoration(
                                color: orderStatusColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              /*
                                  enum OrderStatus {
                                    submitted,
                                    confirmed,
                                    started,
                                    tempPaused,
                                    completed,
                                    cancelled
                                  }
                            */
                              child: Icon(
                                orderStatus == OrderStatus.submitted ||
                                        orderStatus == OrderStatus.confirmed
                                    ? Icons.check_rounded
                                    : orderStatus == OrderStatus.started
                                        ? Icons.play_arrow_rounded
                                        : orderStatus == OrderStatus.tempPaused
                                            ? Icons.pause_rounded
                                            : orderStatus ==
                                                    OrderStatus.completed
                                                ? Icons.check_rounded
                                                : Icons.close_rounded,
                                color: orderStatusColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            PrimaryText(
                              darsOrder.currentStatusStr ?? '',
                              fontSize: 12,
                              color: orderStatusColor,
                              fontWeight: FontWeightManager.softLight,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Spacer(),
                            Container(
                              width: 80.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: (darsOrder.sessionCount == 0
                                        ? ColorManager.black18
                                        : ColorManager.primary)
                                    .withOpacity(0.15),
                              ),
                              child: Center(
                                child: PrimaryText(
                                  controller.getSessionString(
                                      darsOrder.sessionCount ?? 0, orderStatus),
                                  fontSize: 12,
                                  color: darsOrder.sessionCount == 0
                                      ? ColorManager.black18
                                      : ColorManager.primary,
                                  fontWeight: FontWeightManager.softLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
