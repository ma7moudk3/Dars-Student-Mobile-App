import 'package:hessa_student/app/constants/constants.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/order_details_controller.dart';

class StudyingPackageOrderDarsStatus extends GetView<OrderDetailsController> {
  const StudyingPackageOrderDarsStatus({
    Key? key,
    required this.orderStatusColor,
    required this.orderStatus,
  }) : super(key: key);
  final Color orderStatusColor;
  final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 120.h,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xffe5e5e5),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(ImagesManager.lumbPencilIcon),
                SizedBox(width: 8.w),
                PrimaryText(
                  "${(controller.darsOrderDetails.value.result?.order?.duration ?? 20).toInt()} ${LocaleKeys.studying_hour.tr}",
                  fontSize: 16,
                  fontWeight: FontWeightManager.softLight,
                  color: ColorManager.fontColor,
                ),
                const Spacer(),
                Container(
                  width: 100.w,
                  height: 29.h,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: PrimaryText(
                      LocaleKeys.school_package.tr,
                      color: ColorManager.primary,
                      fontWeight: FontWeightManager.softLight,
                    ),
                  ),
                )
              ],
            ),
          ),
          moreDivider(),
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: ColorManager.primary,
                  size: 22.5,
                ),
                SizedBox(width: 12.w),
                PrimaryText(
                  LocaleKeys.order_status.tr,
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      : orderStatus == OrderStatus.completed
                                          ? Icons.check_rounded
                                          : Icons.close_rounded,
                          color: orderStatusColor,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      PrimaryText(
                        controller.darsOrderDetails.value.result
                                ?.currentStatusStr ??
                            "",
                        color: orderStatusColor,
                        fontWeight: FontWeightManager.softLight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
