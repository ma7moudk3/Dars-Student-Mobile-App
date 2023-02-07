import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/teacher_details_controller.dart';

class HessaTeacherBrief extends GetView<TeacherDetailsController> {
  const HessaTeacherBrief({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13.0, 14.0, 14.0, 12.0),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1a000000),
            offset: Offset(0, 1),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(ImagesManager.tagIcon),
              SizedBox(width: 8.w),
              PrimaryText(
                LocaleKeys.brief,
                fontSize: 14.sp,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.fontColor,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          moreDivider(),
          SizedBox(height: 10.h),
          PrimaryText(
            "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التط",
            color: ColorManager.grey5,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}
