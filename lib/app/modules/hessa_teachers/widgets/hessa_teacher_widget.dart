import 'package:cached_network_image/cached_network_image.dart';

import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../../routes/app_pages.dart';
import '../controllers/hessa_teachers_controller.dart';
import '../data/models/hessa_teacher.dart';

class HessaTeacherWidget extends GetView<HessaTeachersController> {
  const HessaTeacherWidget({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  final dynamic teacher;

  @override
  Widget build(BuildContext context) {
    String teacherId = teacher.runtimeType == HessaTeacher
        ? teacher.userId.toString()
        : (teacher.preferredProvider != null
            ? teacher.preferredProvider!.providerId.toString()
            : "");
    String teacherName = teacher.runtimeType == HessaTeacher
        ? teacher.name ?? ""
        : teacher.providerName ?? "";
    double teacherRate = teacher.runtimeType == HessaTeacher
        ? teacher.rate ?? 0.0
        : teacher.providerRate ?? 0.0;
    String levelTopic = teacher.runtimeType == HessaTeacher
        ? teacher.levelTopic ??
            [""]
                .map((String subject) => subject.toString())
                .toSet()
                .toList()
                .join(", ")
        : teacher.levelTopic ??
            [""]
                .map((String subject) => subject.toString())
                .toSet()
                .toList()
                .join(", ");
    String country = teacher.runtimeType == HessaTeacher
            ? teacher.country ?? ""
            : teacher.country ?? "",
        governorate = teacher.runtimeType == HessaTeacher
            ? teacher.governorate ?? ""
            : teacher.governorate ?? "";
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await Get.toNamed(Routes.TEACHER_DETAILS, arguments: {
          "teacher": teacher,
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        margin: EdgeInsets.only(bottom: 16.h),
        width: Get.width,
        decoration: BoxDecoration(
          color: const Color(0xfeffffff),
          borderRadius: BorderRadius.circular(14.0),
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl:
                          "${Links.baseLink}${Links.profileImageById}?userId=$teacherId",
                      fit: BoxFit.cover,
                      errorWidget:
                          (BuildContext context, String url, dynamic error) =>
                              Image.asset(
                        ImagesManager.guest,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PrimaryText(
                            teacherName,
                            color: ColorManager.fontColor,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                (teacherRate <= 5 && teacherRate > 4)
                                    ? Icons.star_rounded
                                    : (teacherRate <= 3.5 && teacherRate >= 1)
                                        ? Icons.star_half_rounded
                                        : Icons.star_outline_rounded,
                                color: ColorManager.orange,
                                textDirection: TextDirection.ltr,
                                size: 20.sp,
                              ),
                              SizedBox(
                                width: 25.w,
                                child: PrimaryText(
                                  teacherRate.toStringAsFixed(1),
                                  color: ColorManager.fontColor,
                                  fontSize: 12.sp,
                                  maxLines: 1,
                                  fontWeight: FontWeightManager.softLight,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: PrimaryText(
                              levelTopic,
                              color: ColorManager.primary,
                              fontWeight: FontWeightManager.softLight,
                              fontSize: 11.sp,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 100.w,
                            child: PrimaryText(
                              country.isNotEmpty && governorate.isNotEmpty
                                  ? "$country - $governorate}"
                                  : "$country$governorate",
                              color: ColorManager.fontColor7,
                              fontSize: 12.sp,
                              maxLines: 1,
                              fontWeight: FontWeightManager.softLight,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
