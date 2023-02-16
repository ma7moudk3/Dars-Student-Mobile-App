import 'package:cached_network_image/cached_network_image.dart';

import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../hessa_teachers/data/models/hessa_teacher.dart';
import '../controllers/teacher_details_controller.dart';

class TeacherInfo extends GetView<TeacherDetailsController> {
  const TeacherInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String teacherPicture = controller.hessaTeacherDetails.result != null
        ? controller.hessaTeacherDetails.result!.providers != null &&
                controller.hessaTeacherDetails.result!.providers!.userId != null
            ? "${Links.baseLink}${Links.profileImageById}?userId=${controller.hessaTeacherDetails.result!.providers!.userId.toString()}"
            : "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png"
        : "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
    String country = controller.hessaTeacher.runtimeType == HessaTeacher
            ? controller.hessaTeacher.country ?? ""
            : controller.hessaTeacher.country ?? "",
        governorate = controller.hessaTeacher.runtimeType == HessaTeacher
            ? controller.hessaTeacher.governorate ?? ""
            : controller.hessaTeacher.governorate ?? "";
    double teacherRate = controller.hessaTeacher.runtimeType == HessaTeacher
        ? controller.hessaTeacher.rate ?? 0.0
        : controller.hessaTeacher.providerRate ?? 0.0;
    return GetBuilder<TeacherDetailsController>(
        builder: (TeacherDetailsController controller) {
      return Row(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: ColorManager.primary,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: teacherPicture,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  ImagesManager.guest,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                controller.hessaTeacherDetails.result != null
                    ? controller.hessaTeacherDetails.result!.userName ?? ""
                    : "",
                fontSize: 16.sp,
              ),
              PrimaryText(
                country.isNotEmpty && governorate.isNotEmpty
                    ? "$country - $governorate"
                    : "$country$governorate",
                fontSize: 14.sp,
                color: ColorManager.fontColor7,
                fontWeight: FontWeightManager.softLight,
              ),
              teacherRate > 0.0
                  ? Row(
                      children: [
                        Icon(
                          controller.hessaTeacherDetails.result != null &&
                                  controller.hessaTeacherDetails.result!
                                          .providers !=
                                      null &&
                                  controller.hessaTeacherDetails.result!
                                          .providers!.rate !=
                                      null
                              ? (controller.hessaTeacherDetails.result!
                                              .providers!.rate <=
                                          5 &&
                                      controller.hessaTeacherDetails.result!
                                              .providers!.rate >
                                          4)
                                  ? Icons.star_rounded
                                  : (teacherRate <= 3.5 && teacherRate >= 1)
                                      ? Icons.star_half_rounded
                                      : Icons.star_outline_rounded
                              : Icons.star_outline_rounded,
                          color: ColorManager.orange,
                          textDirection: TextDirection.ltr,
                          size: 16.sp,
                        ),
                        SizedBox(
                          width: 25.w,
                          child: PrimaryText(
                            teacherRate.toStringAsFixed(1),
                            fontSize: 13.sp,
                            fontWeight: FontWeightManager.softLight,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              // await Get.bottomSheet(
              //   isScrollControlled: true,
              //   shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(20),
              //       topRight: Radius.circular(20),
              //     ),
              //   ),
              //   backgroundColor: ColorManager.white,
              //   const TeacherRatingBottomSheetContent(),
              // );
              await controller.toggleFavorite();
            },
            child: Container(
              width: 48.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Icon(
                  controller.isFavorite != null && controller.isFavorite!
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  size: 30,
                  color: controller.isFavorite != null && controller.isFavorite!
                      ? ColorManager.red
                      : ColorManager.primary,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
