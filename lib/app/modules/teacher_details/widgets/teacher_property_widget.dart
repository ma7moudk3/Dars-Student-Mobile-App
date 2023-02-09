import 'package:hessa_student/app/modules/teacher_details/controllers/teacher_details_controller.dart';

import '../../../constants/exports.dart';

class TeacherPropertyWidget extends GetView<TeacherDetailsController> {
  const TeacherPropertyWidget({
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
          SizedBox(
            width: (Get.width * 0.38).w,
            child: PrimaryText(
              content,
              fontSize: 14.sp,
              fontWeight: FontWeightManager.softLight,
              color: ColorManager.grey5,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: (Get.width * 0.04).w),
        ],
      ),
    );
  }
}
