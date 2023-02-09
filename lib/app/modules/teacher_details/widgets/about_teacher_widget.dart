import 'package:hessa_student/app/modules/teacher_details/widgets/teacher_property_widget.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/teacher_details_controller.dart';

class AboutTeacher extends GetView<TeacherDetailsController> {
  const AboutTeacher({
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
              SvgPicture.asset(ImagesManager.qualificationIcon),
              SizedBox(width: 8.w),
              PrimaryText(
                LocaleKeys.about_teacher,
                fontSize: 14.sp,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.fontColor,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          moreDivider(),
          SizedBox(height: 10.h),
          Column(
            children:
                List.generate(controller.teacherProperties.length, (int index) {
              return TeacherPropertyWidget(
                iconPath: controller.teacherProperties[index]["icon"],
                title: controller.teacherProperties[index]["title"],
                content: controller.teacherProperties[index]["content"] ?? "",
              );
            }),
          ),
        ],
      ),
    );
  }
}
