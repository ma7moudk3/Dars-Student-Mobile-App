import 'package:hessa_student/app/core/helper_functions.dart';
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
            fontSize: 13,
            fontWeight: FontWeightManager.softLight,
          ),
          const Spacer(),
          SizedBox(
            width: (Get.width * 0.38).w,
            child: Tooltip(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(16),
              showDuration: const Duration(milliseconds: 5500),
              preferBelow: true,
              
              textAlign:
                  detectLang(text: content) ? TextAlign.left : TextAlign.right,
              decoration: BoxDecoration(
                color: ColorManager.grey5,
                borderRadius: BorderRadius.circular(10),
              ),
              triggerMode: TooltipTriggerMode.tap,
              message: content,
              textStyle: TextStyle(
                color: ColorManager.white,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                fontFamily: FontConstants.fontFamily,
              ),
              child: PrimaryText(
                content,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.grey5,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(width: (Get.width * 0.04).w),
        ],
      ),
    );
  }
}
