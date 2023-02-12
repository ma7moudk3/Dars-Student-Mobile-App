import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/data/models/countries/result.dart';
import 'package:hessa_student/global_presentation/global_widgets/global_button.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/global_dropdown.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/hessa_teachers_controller.dart';

class HessaTeacherFilterBottomSheetContent
    extends GetView<HessaTeachersController> {
  const HessaTeacherFilterBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HessaTeachersController>(
        builder: (HessaTeachersController controller) {
      if (controller.isLoading.value == true) {
        return SizedBox(
          height: 400.h,
          child: Center(
            child: SpinKitCircle(
              duration: const Duration(milliseconds: 1300),
              size: 50,
              color: ColorManager.primary,
            ),
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 26.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.borderColor3),
                ),
              ),
              PrimaryText(
                LocaleKeys.search_filter,
                fontSize: 16.sp,
                fontWeight: FontWeightManager.softLight,
              ),
              SizedBox(height: 10.h),
              PrimaryText(
                LocaleKeys.city,
                fontSize: 14.sp,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.fontColor,
              ),
              SizedBox(height: 12.h),
              PrimaryDropDown(
                fontColor: ColorManager.fontColor5,
                items: controller.countries.result != null &&
                        controller.countries.result!.isNotEmpty
                    ? (controller.countries.result!
                            .map((Result result) => result.displayName ?? ""))
                        .toList()
                    : [""],
                hint: LocaleKeys.city,
                value: controller.countries.result != null &&
                        controller.countries.result!.isNotEmpty
                    ? (controller.countries.result![0].displayName ?? "")
                    : "",
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.borderColor2,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: Get.width,
                height: 50.h,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.borderColor2,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.borderColor2,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                onChanged: (String? value) =>
                    controller.changeCountry(value ?? ""),
              ),
              SizedBox(height: 12.h),
              PrimaryText(
                LocaleKeys.choose,
                fontSize: 14.sp,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.fontColor,
              ),
              SizedBox(height: 10.h),
              GetBuilder<HessaTeachersController>(
                  builder: (HessaTeachersController controller) {
                return Container(
                  width: Get.width,
                  padding: EdgeInsets.only(
                    bottom: 16.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: ColorManager.borderColor2,
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                          children: List.generate(2, (int index) {
                        return Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                controller.changeFilterFactor(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 22.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              controller.teacherFilterFactor ==
                                                      index
                                                  ? ColorManager.primary
                                                  : ColorManager.borderColor2,
                                          width: 2.w,
                                        ),
                                      ),
                                      child: controller.teacherFilterFactor ==
                                              index
                                          ? Center(
                                              child: Icon(
                                                Icons.circle,
                                                color: ColorManager.primary,
                                                size: 8.sp,
                                              ),
                                            )
                                          : null,
                                    ),
                                    SizedBox(width: 10.w),
                                    PrimaryText(
                                      index == 0
                                          ? LocaleKeys.academic_learning
                                          : LocaleKeys.skill,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeightManager.softLight,
                                      color: ColorManager.fontColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: index == 0,
                              child: moreDivider(thickness: 1.5),
                            ),
                          ],
                        );
                      })),
                      moreDivider(thickness: 1.5, height: 16.h, opacity: 0.3),
                      Visibility(
                        visible:
                            controller.teacherFilterFactor == 1, // 1 is skill
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 16.h,
                          ),
                          child: PrimaryDropDown(
                            items: [LocaleKeys.choose_skill.tr],
                            hint: LocaleKeys.skill,
                            value: LocaleKeys.choose_skill.tr,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.borderColor2,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: Get.width,
                            height: 45.h,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.borderColor2,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.borderColor2,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onChanged: (String? value) {},
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.teacherFilterFactor ==
                            0, // 1: skill, 0: academic learning
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                top: 16.h,
                              ),
                              child: PrimaryDropDown(
                                items: [LocaleKeys.choose_studying_subject.tr],
                                hint: LocaleKeys.studying_subject,
                                value: LocaleKeys.choose_studying_subject.tr,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorManager.borderColor2,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                width: Get.width,
                                height: 45.h,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorManager.borderColor2,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorManager.borderColor2,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onChanged: (String? value) {},
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                top: 16.h,
                              ),
                              child: PrimaryDropDown(
                                items: [LocaleKeys.choose_studying_class.tr],
                                hint: LocaleKeys.studying_class,
                                value: LocaleKeys.choose_studying_class.tr,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorManager.borderColor2,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                width: Get.width,
                                height: 45.h,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorManager.borderColor2,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorManager.borderColor2,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onChanged: (String? value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 16.h,
                        ),
                        child: Row(
                          children: [
                            PrimaryText(
                              LocaleKeys.gender,
                              fontSize: 14.sp,
                              fontWeight: FontWeightManager.softLight,
                              color: ColorManager.fontColor,
                            ),
                            const Spacer(),
                            Row(
                              children: List.generate(2, (int index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.changeTeacherGender(index);
                                  },
                                  child: Container(
                                    width: 80.w,
                                    height: 40.h,
                                    margin: EdgeInsets.only(
                                      right: index == 0 ? 0 : 10.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.teacherGender == index
                                          ? ColorManager.primary
                                          : ColorManager.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: controller.teacherGender != index
                                          ? Border.all(
                                              color: ColorManager.borderColor2,
                                              width: 1,
                                            )
                                          : null,
                                      boxShadow: const [],
                                    ),
                                    child: Center(
                                      child: PrimaryText(
                                        index == 0
                                            ? LocaleKeys.male
                                            : LocaleKeys.female,
                                        color: controller.teacherGender == index
                                            ? ColorManager.white
                                            : ColorManager.borderColor,
                                        fontWeight: FontWeightManager.softLight,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(
                    width: (Get.width * 0.42).w,
                    onPressed: () => Get.back(),
                    title: LocaleKeys.search.tr,
                  ),
                  GlobalButton(
                    width: (Get.width * 0.42).w,
                    borderRadius: BorderRadius.circular(15.h),
                    height: 55.h,
                    onTap: () async {
                      if (controller.toggleSort == true) {
                        if (await checkInternetConnection(timeout: 10)) {
                          await controller.resetTeachers();
                        } else {
                          await Get.toNamed(Routes.CONNECTION_FAILED);
                        }
                      }
                      if (Get.isBottomSheetOpen!) {
                        Get.back();
                      }
                    },
                    title: LocaleKeys.reset.tr,
                  ),
                ],
              ),
            ],
          ),
        );
      }
    });
  }
}
