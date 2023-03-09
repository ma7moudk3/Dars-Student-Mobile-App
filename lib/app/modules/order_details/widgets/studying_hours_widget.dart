import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/order_details_controller.dart';

class StudyingHoursDars extends GetView<OrderDetailsController> {
  const StudyingHoursDars({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 63.h,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xffe5e5e5),
          width: 1,
        ),
      ),
      child: Row(
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
              color: ColorManager.blueLight,
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
    );
  }
}
