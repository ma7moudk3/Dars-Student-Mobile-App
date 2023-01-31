import '../../../constants/exports.dart';
import '../controllers/hessa_details_controller.dart';

class HessaPropertyWidget extends GetView<HessaDetailsController> {
  const HessaPropertyWidget({
    required this.iconPath,
    required this.title,
    Key? key,
  }) : super(key: key);
  final String iconPath, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath),
          SizedBox(width: 10.w),
          PrimaryText(
            title,
            fontSize: 13.sp,
            fontWeight: FontWeightManager.softLight,
          ),
          const Spacer(),
          PrimaryText(
            "11:00 م - 12:00 م",
            fontSize: 14.sp,
            fontWeight: FontWeightManager.softLight,
            color: ColorManager.grey5,
          ),
          SizedBox(width: (Get.width * 0.04).w),
        ],
      ),
    );
  }
}
