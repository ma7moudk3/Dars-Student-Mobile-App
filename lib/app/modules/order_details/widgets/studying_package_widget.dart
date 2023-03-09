import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hessa_student/app/modules/order_details/widgets/participant_students_list_bottom_sheet.dart';
import 'package:hessa_student/app/modules/order_details/widgets/studying_hours_widget.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/order_details_controller.dart';
import 'droos_list_widget.dart';

class StudyingPackageWidget extends GetView<OrderDetailsController> {
  const StudyingPackageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 22.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const StudyingHoursDars(),
              SizedBox(height: 20.h),
              const DroosListWidget(),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                width: Get.width,
                height: 230.h,
                decoration: BoxDecoration(
                  color: const Color(0xfffafafa),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Get.bottomSheet(
                          backgroundColor: ColorManager.white,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          const ParticipantListBottomSheetContent(),
                        );
                      },
                      child: PrimaryText(
                        LocaleKeys.participant_students.tr,
                        fontSize: 14,
                        fontWeight: FontWeightManager.softLight,
                        color: ColorManager.primary,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller
                                .darsOrderDetails.result?.students?.length ??
                            0,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          String studentPicture =
                              "${Links.baseLink}${Links.nonUsersProfileImageByToken}?id=${controller.darsOrderDetails.result?.students?[index].requesterStudentPhoto ?? -1}";
                          return Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                // Get.toNamed(Routes.STUDENT_DETAILS);
                                log('Student Details ${index + 1}');
                              },
                              child: Row(
                                children: [
                                  StatefulBuilder(builder:
                                      (BuildContext context, setState) {
                                    return Container(
                                      width: 44.w,
                                      height: 44.h,
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
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x19000000)
                                                .withOpacity(0.07),
                                            spreadRadius: 0,
                                            offset: const Offset(0, 12),
                                            blurRadius: 15,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  SizedBox(width: 10.w),
                                  PrimaryText(
                                    controller.darsOrderDetails.result
                                            ?.students?[index].name ??
                                        '',
                                    fontSize: 14,
                                    fontWeight: FontWeightManager.softLight,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    moreDivider(),
                    PrimaryText(
                      LocaleKeys.teacher.tr,
                      fontSize: 14,
                      fontWeight: FontWeightManager.softLight,
                      color: ColorManager.primary,
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        await Get.toNamed(Routes.TEACHER_DETAILS);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 44.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  ImagesManager.avatar,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0x19000000).withOpacity(0.07),
                                  spreadRadius: 0,
                                  offset: const Offset(0, 12),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            children: [
                              PrimaryText(
                                'محمد عبد الله',
                                fontSize: 14,
                                fontWeight: FontWeightManager.softLight,
                              ),
                              PrimaryText(
                                'نابلس - القدس',
                                fontSize: 12,
                                fontWeight: FontWeightManager.softLight,
                                color: ColorManager.fontColor7,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  log('Favorite');
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color:
                                        ColorManager.primary.withOpacity(0.10),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      ImagesManager.heartIcon,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  log('Messaging');
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color:
                                        ColorManager.yellow.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      ImagesManager.messagingIcon,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              PrimaryButton(
                onPressed: () {},
                isDisabled: true, // to be changed later
                title: LocaleKeys.cancel_order_dars.tr,
              ),
              SizedBox(height: 65.h),
            ],
          ),
        ),
      ],
    );
  }
}
