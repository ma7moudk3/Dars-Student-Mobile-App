import 'dart:developer';
import 'package:hessa_student/app/modules/hessa_details/widgets/participant_students_list_bottom_sheet.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/hessa_details_controller.dart';
import 'hessa_property_widget.dart';

class OneHessaWidget extends GetView<HessaDetailsController> {
  const OneHessaWidget({
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
                        LocaleKeys.hessa_started.tr,
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
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
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
                                    color: const Color(0x19000000)
                                        .withOpacity(0.07),
                                    spreadRadius: 0,
                                    offset: const Offset(0, 12),
                                    blurRadius: 15,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                            PrimaryText(
                              'محمد عبد الله',
                              fontSize: 14.sp,
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
                  return Container(
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
            bottom: 25.h,
            top: 16.h,
          ),
          child: PrimaryButton(
            onPressed: () {},
            isDisabled: true, // to be changed later
            title: LocaleKeys.cancel_hessa.tr,
          ),
        ),
      ],
    );
  }
}
