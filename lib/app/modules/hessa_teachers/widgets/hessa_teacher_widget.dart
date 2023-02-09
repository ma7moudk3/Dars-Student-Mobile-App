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

  final HessaTeacher teacher;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await Get.toNamed(Routes.TEACHER_DETAILS);
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
                          "${Links.baseLink}${Links.profileImageById}?userId=${teacher.userId.toString()}",
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.asset(
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
                            teacher.name ?? "",
                            color: ColorManager.fontColor,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                teacher.rate != null
                                    ? (teacher.rate! <= 5 && teacher.rate! > 4)
                                        ? Icons.star_rounded
                                        : (teacher.rate! <= 3.5 &&
                                                teacher.rate! >= 1)
                                            ? Icons.star_half_rounded
                                            : Icons.star_outline_rounded
                                    : Icons.star_outline_rounded,
                                color: ColorManager.orange,
                                textDirection: TextDirection.ltr,
                                size: 20.sp,
                              ),
                              SizedBox(
                                width: 25.w,
                                child: PrimaryText(
                                  teacher.rate != null
                                      ? teacher.rate!.toStringAsFixed(1)
                                      : "0.0",
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
                              teacher.levelTopic ??
                                  [""]
                                      .map((String subject) =>
                                          subject.toString())
                                      .join(", "),
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
                              teacher.country != null &&
                                      teacher.country!.isNotEmpty &&
                                      teacher.governorate != null &&
                                      teacher.governorate!.isNotEmpty
                                  ? "${teacher.country ?? ""} - ${teacher.governorate ?? ""}"
                                  : "${teacher.country ?? ""}${teacher.governorate ?? ""}",
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
