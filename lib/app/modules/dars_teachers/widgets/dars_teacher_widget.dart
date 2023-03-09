import 'dart:developer';

import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hessa_student/app/modules/preferred_teachers/controllers/preferred_teachers_controller.dart';

import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../../routes/app_pages.dart';
import '../../preferred_teachers/data/models/preferred_teacher/preferred_teacher.dart';
import '../controllers/dars_teachers_controller.dart';
import '../data/models/dars_teacher.dart';

class TeacherWidget extends GetView<DarsTeachersController> {
  const TeacherWidget({
    Key? key,
    required this.teacher,
    this.index,
  }) : super(key: key);

  final dynamic teacher;
  final int? index;
  @override
  Widget build(BuildContext context) {
    String teacherUserId = teacher.runtimeType == DarsTeacher
        ? teacher.userId.toString()
        : (teacher.preferredProvider != null
            ? teacher.preferredProvider!.providerUserId != null
                ? teacher.preferredProvider!.providerUserId.toString()
                : "-1"
            : "-1");
    String preferredTeacherId = teacher.runtimeType == PreferredTeacher
        ? (teacher.preferredProvider != null
            ? teacher.preferredProvider!.providerId != null
                ? teacher.preferredProvider!.providerId.toString()
                : "-1"
            : "-1")
        : "-1";

    Widget unPreferTeacherBackgroundWidget =
        GetBuilder<PreferredTeachersController>(
            builder: (PreferredTeachersController controller) {
      return GestureDetector(
        onTap: () async {
          await controller.unPreferTeacher(
              teacherId: int.parse(preferredTeacherId));
        },
        child: Animator<double>(
            duration: const Duration(milliseconds: 1000),
            cycles: 0,
            curve: Curves.elasticIn,
            tween: Tween<double>(begin: 20.0, end: 25.0),
            builder: (context, animatorState, child) {
              return Container(
                width: 75.w,
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                  color: ColorManager.grey6.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Icon(
                    Icons.favorite_rounded,
                    size: animatorState.value * 2.2,
                    color: ColorManager.red,
                  ),
                ),
              );
            }),
      );
    });
    String teacherName = teacher.runtimeType == DarsTeacher
        ? teacher.name ?? ""
        : teacher.providerName ?? "";
    double teacherRate = teacher.runtimeType == DarsTeacher
        ? teacher.rate ?? 0.0
        : teacher.providerRate ?? 0.0;
    String levelTopic = teacher.runtimeType == DarsTeacher
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
    String country = teacher.runtimeType == DarsTeacher
            ? teacher.country ?? ""
            : teacher.country ?? "",
        governorate = teacher.runtimeType == DarsTeacher
            ? teacher.governorate ?? ""
            : teacher.governorate ?? "";
    log("${Links.baseLink}${Links.profileImageById}?userId=$teacherUserId");
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await Get.toNamed(Routes.TEACHER_DETAILS, arguments: {
          "teacher": teacher,
        });
      },
      child: teacher.runtimeType == PreferredTeacher
          ? Container(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Slidable(
                key: ValueKey(index ?? 0),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  closeThreshold: 0.2,
                  // dismissible: DismissiblePane(
                  //   dismissThreshold: 0.2,
                  //   onDismissed: () {},
                  // ),
                  dragDismissible: false,
                  children: [unPreferTeacherBackgroundWidget],
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                                    "${Links.baseLink}${Links.profileImageById}?userId=$teacherUserId",
                                fit: BoxFit.cover,
                                errorWidget: (BuildContext context, String url,
                                        dynamic error) =>
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          (teacherRate <= 5 && teacherRate > 4)
                                              ? Icons.star_rounded
                                              : (teacherRate <= 3.5 &&
                                                      teacherRate >= 1)
                                                  ? Icons.star_half_rounded
                                                  : Icons.star_outline_rounded,
                                          color: ColorManager.orange,
                                          textDirection: TextDirection.ltr,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                          child: PrimaryText(
                                            teacherRate.toStringAsFixed(1),
                                            color: ColorManager.fontColor,
                                            fontSize: 12,
                                            maxLines: 1,
                                            fontWeight:
                                                FontWeightManager.softLight,
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
                                        fontSize: 11,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 100.w,
                                      child: PrimaryText(
                                        country.isNotEmpty &&
                                                governorate.isNotEmpty
                                            ? "$country - $governorate"
                                            : "$country$governorate",
                                        color: ColorManager.fontColor7,
                                        fontSize: 12,
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
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              margin: EdgeInsets.only(bottom: 10.h),
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
                                "${Links.baseLink}${Links.profileImageById}?userId=$teacherUserId",
                            fit: BoxFit.cover,
                            errorWidget: (BuildContext context, String url,
                                    dynamic error) =>
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
                                          : (teacherRate <= 3.5 &&
                                                  teacherRate >= 1)
                                              ? Icons.star_half_rounded
                                              : Icons.star_outline_rounded,
                                      color: ColorManager.orange,
                                      textDirection: TextDirection.ltr,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                      child: PrimaryText(
                                        teacherRate.toStringAsFixed(1),
                                        color: ColorManager.fontColor,
                                        fontSize: 12,
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
                                    fontSize: 11,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 100.w,
                                  child: PrimaryText(
                                    country.isNotEmpty && governorate.isNotEmpty
                                        ? "$country - $governorate"
                                        : "$country$governorate",
                                    color: ColorManager.fontColor7,
                                    fontSize: 12,
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
