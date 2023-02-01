import '../../../constants/exports.dart';
import '../controllers/teacher_details_controller.dart';

class TeacherHessaRating extends GetView<TeacherDetailsController> {
  const TeacherHessaRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              PrimaryText(
                "رياضيات مستوى مبتدئ",
                fontSize: 14.sp,
                fontWeight: FontWeightManager.softLight,
              ),
              const Spacer(),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                      5,
                      (int index) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: (5 - 4) >
                                index // (5 - 4) is because the index start from 0 and from the left to the right
                            ? SvgPicture.asset(
                                ImagesManager.starUnfilled,
                                height: 15.h,
                              )
                            : SvgPicture.asset(
                                ImagesManager.starFilled,
                                height: 15.h,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  PrimaryText(
                    "4.5",
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.softLight,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              PrimaryText(
                "الصف الاول",
                fontSize: 14.sp,
                color: ColorManager.fontColor7,
                fontWeight: FontWeightManager.softLight,
              ),
              const Spacer(),
              PrimaryText(
                "18 مارس 2022",
                fontSize: 14.sp,
                color: ColorManager.fontColor7,
                fontWeight: FontWeightManager.softLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
