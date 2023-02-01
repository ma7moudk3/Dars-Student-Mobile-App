import '../../../constants/exports.dart';
import '../controllers/teacher_details_controller.dart';

class TeacherInfo extends GetView<TeacherDetailsController> {
  const TeacherInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesManager.avatar),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              width: 1,
              color: ColorManager.primary,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              "محمد جميل",
              fontSize: 16.sp,
            ),
            PrimaryText(
              "نابلس- القدس",
              fontSize: 14.sp,
              color: ColorManager.fontColor7,
              fontWeight: FontWeightManager.softLight,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: ColorManager.orange,
                  size: 14.sp,
                ),
                PrimaryText(
                  "4.5",
                  fontSize: 12.sp,
                  fontWeight: FontWeightManager.softLight,
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {},
          child: Container(
            width: 48.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: SvgPicture.asset(
                ImagesManager.heartIcon,
                color: ColorManager.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}