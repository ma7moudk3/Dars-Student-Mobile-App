import 'package:cached_network_image/cached_network_image.dart';

import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../preferred_teachers/data/models/preferred_teacher/preferred_teacher.dart';
import '../controllers/order_hessa_controller.dart';

class TypeAheadPreferredTeacherWidget extends GetView<OrderHessaController> {
  const TypeAheadPreferredTeacherWidget({Key? key, required this.teacher})
      : super(key: key);
  final PreferredTeacher teacher;
  @override
  Widget build(BuildContext context) {
    String teacherPicture =
        "${Links.baseLink}${Links.profileImageById}?userId=${teacher.preferredProvider?.providerUserId ?? -1}";
    double teacherRate = teacher.providerRate ?? 0.0;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatefulBuilder(builder: (BuildContext context, setState) {
                return Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        teacherPicture,
                        errorListener: () {
                          setState(() {
                            teacherPicture =
                                "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                          });
                        },
                      ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      width: 1,
                      color: ColorManager.primary,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
              SizedBox(width: 5.w),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: PrimaryText(
                            teacher.providerName ?? "",
                            color: ColorManager.fontColor,
                            fontSize: 12.sp,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
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
                              width: 40.w,
                              child: PrimaryText(
                                teacher.providerRate != null
                                    ? teacherRate.toString()
                                    : "0.0",
                                color: ColorManager.fontColor,
                                fontSize: 12.sp,
                                maxLines: 1,
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
                            teacher.levelTopic ?? "",
                            color: ColorManager.primary,
                            fontWeight: FontWeightManager.softLight,
                            fontSize: 11.sp,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                          child: PrimaryText(
                            teacher.country != null &&
                                    teacher.governorate != null
                                ? "${teacher.country} - ${teacher.governorate}"
                                : "${teacher.country}${teacher.governorate}",
                            color: ColorManager.fontColor7,
                            fontSize: 12.sp,
                            maxLines: 1,
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
          SizedBox(height: 10.h),
          Divider(
            color: ColorManager.borderColor3,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
