import 'package:hessa_student/app/modules/teacher_details/controllers/teacher_details_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class TeacherRatingBottomSheetContent
    extends GetView<TeacherDetailsController> {
  const TeacherRatingBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherDetailsController>(
        builder: (TeacherDetailsController controller) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 26.w,
                height: 6.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.borderColor3),
              ),
            ),
            SizedBox(height: 24.h),
            SvgPicture.asset(
              ImagesManager.teacherRating,
              height: 150.h,
              width: 130.w,
            ),
            SizedBox(height: 24.h),
            PrimaryText(
              LocaleKeys.teacher_rating,
              fontSize: 18.sp,
              fontWeight: FontWeightManager.softLight,
            ),
            SizedBox(height: 3.h),
            PrimaryText(
              LocaleKeys.how_was_your_experience_with_the_teacher,
              fontSize: 14.sp,
              color: ColorManager.fontColor7,
              fontWeight: FontWeightManager.softLight,
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      controller.changeCurrentStar(index);
                    },
                    child: SvgPicture.asset(
                      ImagesManager.starFilledRoundedIcon,
                      color: controller.currentStar >= index
                          ? null
                          : ColorManager.rateGrey.withOpacity(0.35),
                      height: 25.h,
                      width: 25.w,
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 50.h),
            PrimaryButton(
              onPressed: () async {
                // await controller.rateTeacher();
                Get.back();
              },
              fontSize: 14.sp,
              title: LocaleKeys.rate.tr,
            ),
          ],
        ),
      );
    });
  }
}
