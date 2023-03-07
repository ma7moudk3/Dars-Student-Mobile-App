import 'package:hessa_student/app/routes/app_pages.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:intl/intl.dart';

import '../../../constants/constants.dart';
import '../../../constants/exports.dart';
import '../controllers/home_controller.dart';
import '../data/models/dars_order.dart';

class OrderWidget extends GetView<HomeController> {
  final bool isFirst;

  const OrderWidget({
    Key? key,
    this.isFirst = false,
    required this.darsOrder,
  }) : super(key: key);
  final DarsOrder darsOrder;
  @override
  Widget build(BuildContext context) {
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
                      PrimaryText(
                        'رياضيات مستوى مبتدىء',
                        fontSize: 14.sp,
                        color: ColorManager.fontColor,
                        fontWeight: FontWeightManager.softLight,
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
                            size: 20.sp,
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
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 25.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(ImagesManager.avatar),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          PrimaryText(
                            'أ. محمد جبريل',
                            fontSize: 14.sp,
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
                                size: 18.sp,
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
                                fontSize: 13.sp,
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
                                size: 18.sp,
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
                  Container(
                    width: 80.w,
                    height: 26.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorManager.green
                          .withOpacity(0.15), // badge color >> could be red
                    ),
                    child: Center(
                      child: PrimaryText(
                        'بدأت الحصّة', // "اهتمام من قبل 3 مدرسين"
                        fontSize: 12.sp,
                        color: ColorManager.green,
                        fontWeight: FontWeightManager.softLight,
                      ),
                    ),
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
