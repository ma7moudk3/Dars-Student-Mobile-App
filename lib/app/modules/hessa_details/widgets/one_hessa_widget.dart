import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hessa_student/app/modules/hessa_details/widgets/participant_students_list_bottom_sheet.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../../core/helper_functions.dart';
import '../controllers/hessa_details_controller.dart';
import 'cancel_hessa_bottom_sheet_content.dart';
import 'hessa_property_widget.dart';

class OneHessaWidget extends GetView<HessaDetailsController> {
  const OneHessaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(controller.hessaOrder.toJson().toString());
    return Column(
      children: [
        SizedBox(height: 22.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagesManager.lumbPencilIcon),
                  SizedBox(width: 8.w),
                  PrimaryText(
                    "20 ${LocaleKeys.studying_hour.tr}",
                    fontSize: 16.sp,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.fontColor,
                  ),
                  const Spacer(),
                  Container(
                    width: 100.w,
                    height: 29.h,
                    decoration: BoxDecoration(
                      color: ColorManager.green.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: PrimaryText(
                        LocaleKeys.dars_started.tr,
                        color: ColorManager.green,
                        fontWeight: FontWeightManager.softLight,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              moreDivider(),
              Column(
                children: List.generate(controller.hessaProperties.length,
                    (int index) {
                  return HessaPropertyWidget(
                    iconPath: controller.hessaProperties[index]["icon"],
                    title: controller.hessaProperties[index]["title"],
                    content: controller.hessaProperties[index]["content"] ?? "",
                  );
                }),
              ),
              moreDivider(),
              SizedBox(height: 10.h),
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
                  fontSize: 14.sp,
                  fontWeight: FontWeightManager.softLight,
                  color: ColorManager.primary,
                ),
              ),
              SizedBox(
                width: Get.width,
                height: 100.h,
                child: ListView.builder(
                  itemCount:
                      controller.hessaOrderDetails.result?.students?.length ??
                          0,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    String studentPicture =
                        "${Links.baseLink}${Links.nonUsersProfileImageByToken}?id=${controller.hessaOrderDetails.result?.students?[index].requesterStudentPhoto ?? -1}";
                    return Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          // Get.toNamed(Routes.STUDENT_DETAILS);
                          log('Student Details ${index + 1}');
                        },
                        child: Row(
                          children: [
                            StatefulBuilder(
                                builder: (BuildContext context, setState) {
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
                              controller.hessaOrderDetails.result
                                      ?.students?[index].name ??
                                  "",
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
              SizedBox(height: 10.h),
              PrimaryText(
                LocaleKeys.intersted_teachers.tr,
                fontSize: 14.sp,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.primary,
              ),
              SizedBox(height: 15.h),
              ListView.builder(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              SizedBox(height: 20.h),
                              Container(
                                width: 58.w,
                                height: 65.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(ImagesManager.avatar),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              PrimaryText(
                                'محمد عبد الله',
                                fontSize: 14.sp,
                                fontWeight: FontWeightManager.softLight,
                              ),
                              PrimaryText(
                                'نابلس - القدس',
                                fontSize: 14.sp,
                                color: ColorManager.fontColor7,
                                fontWeight: FontWeightManager.softLight,
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryButton(
                                      width: 265.w,
                                      onPressed: () => Get.back(),
                                      title: LocaleKeys.approve_teacher.tr,
                                    ),
                                    GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                        width: 48.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: ColorManager.yellow,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            ImagesManager.messagingIcon,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      margin: EdgeInsets.only(bottom: 15.h),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1a000000),
                            offset: Offset(0, 1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
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
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          PrimaryText(
                                            "سارة محمد",
                                            color: ColorManager.fontColor,
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: ColorManager.orange,
                                                size: 14.sp,
                                              ),
                                              SizedBox(
                                                width: 40.w,
                                                child: PrimaryText(
                                                  "4.5",
                                                  color: ColorManager.fontColor,
                                                  fontSize: 12.sp,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          PrimaryText(
                                            ["رياضيات", "علوم", "فيزياء"]
                                                .map((String subject) =>
                                                    subject.toString())
                                                .join(", "),
                                            color: ColorManager.primary,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            fontSize: 11.sp,
                                          ),
                                          const Spacer(),
                                          PrimaryText(
                                            "مدرسة العلمين",
                                            color: ColorManager.fontColor7,
                                            fontSize: 12.sp,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: Get.height * 0.075.h,
          ),
          child: PrimaryButton(
            onPressed: () async {
              await Get.bottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                const CancelHessaBottomSheetContent(),
                backgroundColor: ColorManager.white,
              ).whenComplete(() => controller.clearData());
            },
            // isDisabled: true, // to be changed later
            title: LocaleKeys.cancel_dars.tr,
          ),
        ),
      ],
    );
  }
}
