import 'package:hessa_student/app/modules/teacher_details/widgets/teacher_dars_rating_widget.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/teacher_details_controller.dart';

class TeacherRatingPreviousDroos extends GetView<TeacherDetailsController> {
  const TeacherRatingPreviousDroos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(13.0, 14.0, 14.0, 12.0),
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
              SvgPicture.asset(ImagesManager.ratingIcon),
              SizedBox(width: 8.w),
              PrimaryText(
                LocaleKeys.rating_previous_droos,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.fontColor,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          moreDivider(),
          SizedBox(height: 10.h),
          ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  const TeacherDarsRating(),
                  Visibility(
                    visible: index != 2,
                    child: moreDivider(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}