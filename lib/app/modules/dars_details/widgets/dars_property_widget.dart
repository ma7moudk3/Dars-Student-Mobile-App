import '../../../constants/exports.dart';
import '../controllers/dars_details_controller.dart';

class DarsPropertyWidget extends GetView<DarsDetailsController> {
  const DarsPropertyWidget({
    required this.iconPath,
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);
  final String iconPath, title, content;

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
            content,
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
