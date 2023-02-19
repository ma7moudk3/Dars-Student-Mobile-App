import 'package:cached_network_image/cached_network_image.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../controllers/dependents_controller.dart';
import '../data/models/student/student.dart';

class DependentInfoBottomSheetContent extends GetView<DependentsController> {
  const DependentInfoBottomSheetContent({Key? key, required this.student})
      : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 26.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorManager.borderColor3,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, top: 16.h, bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.white,
                  ),
                  child: GetBuilder<DependentsController>(
                      builder: (DependentsController controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StatefulBuilder(
                            builder: (BuildContext context, setState) {
                          String studentPicture =
                              "${Links.baseLink}${Links.profileImageById}?userId=${student.requesterStudent?.id ?? -1}";
                          return Container(
                            width: 58.w,
                            height: 65.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  studentPicture,
                                  errorListener: () {
                                    setState(() {
                                      studentPicture =
                                          "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                                    });
                                  },
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          );
                        }),
                        SizedBox(height: 20.h),
                        Container(
                          width: Get.width,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: ColorManager.yellow.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: PrimaryText(
                              student.requesterStudent?.name ?? "",
                              fontSize: 16,
                              color: ColorManager.yellow,
                              fontWeight: FontWeightManager.light,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: ColorManager.fontColor6.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimaryText(
                                      "${LocaleKeys.gender.tr} :",
                                      color: ColorManager.fontColor,
                                    ),
                                    SizedBox(width: 10.w),
                                    PrimaryText(
                                      student.requesterStudent?.genderStr ?? "",
                                      color: ColorManager.borderColor2,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimaryText(
                                      "${LocaleKeys.school_name.tr} :",
                                      color: ColorManager.fontColor,
                                    ),
                                    SizedBox(width: 10.w),
                                    PrimaryText(
                                      student.schoolTypeName ?? "",
                                      color: ColorManager.borderColor2,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimaryText(
                                      "${LocaleKeys.studying_class.tr} :",
                                      color: ColorManager.fontColor,
                                    ),
                                    SizedBox(width: 10.w),
                                    PrimaryText(
                                      student.levelName ?? "",
                                      color: ColorManager.borderColor2,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimaryText(
                                      "${LocaleKeys.student_relation.tr} :",
                                      color: ColorManager.fontColor,
                                    ),
                                    SizedBox(width: 10.w),
                                    PrimaryText(
                                      student.requesterStudentRelationName ??
                                          "",
                                      color: ColorManager.borderColor2,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimaryText(
                                      "${LocaleKeys.student_requester.tr} :",
                                      color: ColorManager.fontColor,
                                    ),
                                    SizedBox(width: 10.w),
                                    PrimaryText(
                                      student.requesterUserName ?? "",
                                      color: ColorManager.borderColor2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
