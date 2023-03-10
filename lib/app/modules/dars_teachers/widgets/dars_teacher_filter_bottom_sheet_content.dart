import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/global_presentation/global_widgets/global_button.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/confirm_back_dialog_content.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/global_dropdown.dart';
import '../../../../global_presentation/global_widgets/shimmer_loading.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import 'package:hessa_student/app/data/models/countries/result.dart' as country;
import '../../../data/models/governorates/result.dart' as governorate;
import 'package:hessa_student/app/data/models/topics/result.dart' as topic;
import '../../../data/models/classes/item.dart' as level;
import '../../../data/models/skills/item.dart' as skill;
import '../../../routes/app_pages.dart';
import '../controllers/dars_teachers_controller.dart';

class DarsTeacherFilterBottomSheetContent
    extends GetView<DarsTeachersController> {
  const DarsTeacherFilterBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.dialog(
          Container(
            color: ColorManager.black.withOpacity(0.1),
            height: 140.h,
            width: 140.w,
            child: Center(
              child: Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                child: ConfirmBackDialogContent(
                  subTitle: LocaleKeys.wanna_back_and_lose_filters.tr,
                ),
              ),
            ),
          ),
        );
        return false;
      },
      child: SafeArea(
        child: GetX<DarsTeachersController>(
            builder: (DarsTeachersController controller) {
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
                        color: ColorManager.borderColor3,
                      ),
                    ),
                  ),
                  PrimaryText(
                    LocaleKeys.search_filter,
                    fontSize: 16,
                    fontWeight: FontWeightManager.softLight,
                  ),
                  SizedBox(height: 10.h),
                  PrimaryText(
                    LocaleKeys.country,
                    fontSize: 14,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.fontColor,
                  ),
                  SizedBox(height: 12.h),
                  PrimaryDropDown(
                    fontColor: ColorManager.fontColor5,
                    items: controller.countries.result != null &&
                            controller.countries.result!.isNotEmpty
                        ? (controller.countries.result!.map(
                            (country.Result result) =>
                                result.displayName ?? "")).toList()
                        : [""],
                    hint: LocaleKeys.city,
                    value: controller.countries.result != null &&
                            controller.countries.result!.isNotEmpty
                        ? controller.countries.result!.firstWhereOrNull(
                                    (country.Result country) =>
                                        (country.id) ==
                                        controller.selectedCountry.id) !=
                                null
                            ? controller.countries.result!
                                    .firstWhereOrNull(
                                        (country.Result country) =>
                                            (country.id ?? -1) ==
                                            controller.selectedCountry.id)!
                                    .displayName ??
                                ""
                            : (controller.countries.result![0].displayName ??
                                "")
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
                        controller.changeCountry(value),
                  ),
                  SizedBox(height: 12.h),
                  GetBuilder<DarsTeachersController>(
                      builder: (DarsTeachersController controller) {
                    bool isGovernorateDropDownDisabled =
                        controller.governorates.result == null ||
                            controller.governorates.result!.isEmpty;
                    if (controller.isGovernorateDropDownLoading == true) {
                      return const ShimmerLoading();
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryText(
                            LocaleKeys.city,
                            fontSize: 14,
                            fontWeight: FontWeightManager.softLight,
                            color: ColorManager.fontColor,
                          ),
                          SizedBox(height: 12.h),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              if (isGovernorateDropDownDisabled &&
                                  (controller.selectedCountry.id == null ||
                                      controller.selectedCountry.id == -1)) {
                                CustomSnackBar.showCustomInfoSnackBar(
                                  title: LocaleKeys.note.tr,
                                  message:
                                      LocaleKeys.please_choose_country_first.tr,
                                );
                              }
                            },
                            child: PrimaryDropDown(
                              fontColor: isGovernorateDropDownDisabled
                                  ? null
                                  : ColorManager.fontColor5,
                              items: controller.governorates.result != null
                                  ? (controller.governorates.result!.map(
                                      (governorate.Result result) =>
                                          result.displayName ?? "")).toList()
                                  : [LocaleKeys.choose_city.tr],
                              hint: LocaleKeys.city,
                              value: controller.governorates.result != null &&
                                      controller.governorates.result!.isNotEmpty
                                  ? controller.governorates.result!
                                              .firstWhereOrNull(
                                                  (governorate.Result governorate) =>
                                                      (governorate.id) ==
                                                      controller
                                                          .selectedGovernorate
                                                          .id) !=
                                          null
                                      ? controller.governorates.result!
                                              .firstWhereOrNull(
                                                  (governorate.Result governorat) =>
                                                      (governorat.id ?? -1) ==
                                                      controller
                                                          .selectedGovernorate
                                                          .id)!
                                              .displayName ??
                                          LocaleKeys.choose_city.tr
                                      : (controller.governorates.result![0]
                                              .displayName ??
                                          LocaleKeys.choose_city.tr)
                                  : LocaleKeys.choose_city.tr,
                              isDisabled: isGovernorateDropDownDisabled,
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
                              onChanged: (String? governorate) =>
                                  controller.changeGovernorate(governorate),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                  SizedBox(height: 12.h),
                  PrimaryText(
                    LocaleKeys.choose,
                    fontSize: 14,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.fontColor,
                  ),
                  SizedBox(height: 10.h),
                  GetBuilder<DarsTeachersController>(
                      builder: (DarsTeachersController controller) {
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
                                              color: controller
                                                          .teacherFilterFactor ==
                                                      index
                                                  ? ColorManager.primary
                                                  : ColorManager.borderColor2,
                                              width: 2.w,
                                            ),
                                          ),
                                          child: controller
                                                      .teacherFilterFactor ==
                                                  index
                                              ? Center(
                                                  child: Icon(
                                                    Icons.circle,
                                                    color: ColorManager.primary,
                                                    size: 8,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        SizedBox(width: 10.w),
                                        PrimaryText(
                                          index == 0
                                              ? LocaleKeys.academic_learning
                                              : LocaleKeys.skill,
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeightManager.softLight,
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
                          moreDivider(
                              thickness: 1.5, height: 16.h, opacity: 0.3),
                          Visibility(
                            visible: controller.teacherFilterFactor ==
                                1, // 1 is skill
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                top: 16.h,
                              ),
                              child: PrimaryDropDown(
                                fontColor: ColorManager.fontColor5,
                                items: controller.skills.result != null &&
                                        controller.skills.result!.items !=
                                            null &&
                                        controller
                                            .skills.result!.items!.isNotEmpty
                                    ? (controller.skills.result!.items!.map(
                                        (skill.Item item) =>
                                            item.displayName ?? "")).toList()
                                    : [""],
                                hint: LocaleKeys.choose_skill,
                                value: controller.skills.result != null &&
                                        controller.skills.result!.items !=
                                            null &&
                                        controller
                                            .skills.result!.items!.isNotEmpty
                                    ? controller.skills.result!.items!
                                                .firstWhereOrNull(
                                                    (skill.Item skill) =>
                                                        (skill.id ?? -1) ==
                                                        controller.selectedSkill
                                                            .id) !=
                                            null
                                        ? controller.skills.result!.items!
                                                .firstWhereOrNull(
                                                    (skill.Item skill) =>
                                                        (skill.id ?? -1) ==
                                                        controller
                                                            .selectedSkill.id)!
                                                .displayName ??
                                            ""
                                        : (controller.skills.result!.items![0]
                                                .displayName ??
                                            "")
                                    : "",
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
                                onChanged: (String? value) =>
                                    controller.changeSkill(value),
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
                                    fontColor: ColorManager.fontColor5,
                                    items: controller.topics.result != null &&
                                            controller.topics.result!.isNotEmpty
                                        ? (controller.topics.result!.map(
                                                (topic.Result result) =>
                                                    result.displayName ?? ""))
                                            .toList()
                                        : [""],
                                    hint: LocaleKeys.studying_subject,
                                    value: controller.topics.result != null &&
                                            controller.topics.result!.isNotEmpty
                                        ? controller.topics.result!
                                                    .firstWhereOrNull(
                                                        (topic.Result topic) =>
                                                            (topic.id ?? -1) ==
                                                            controller
                                                                .selectedTopic
                                                                .id) !=
                                                null
                                            ? controller.topics.result!
                                                    .firstWhereOrNull(
                                                        (topic.Result topic) =>
                                                            (topic.id ?? -1) ==
                                                            controller
                                                                .selectedTopic
                                                                .id)!
                                                    .displayName ??
                                                ""
                                            : (controller.topics.result![0]
                                                    .displayName ??
                                                "")
                                        : "",
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
                                    onChanged: (String? value) =>
                                        controller.changeTopic(value),
                                  ),
                                ),
                                //~ uncomment if we want to use searcahable dropdown
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //     left: 16.w,
                                //     right: 16.w,
                                //     top: 10.h,
                                //   ),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       PrimaryText(
                                //         LocaleKeys.studying_subject,
                                //         fontSize: 14,
                                //         fontWeight: FontWeightManager.softLight,
                                //         color: ColorManager.fontColor,
                                //       ),
                                //       SizedBox(height: 8.h),
                                //       SingleChildScrollView(
                                //         clipBehavior: Clip.none,
                                //         child: CupertinoTypeAheadFormField<
                                //             topic.Result>(
                                //           hideOnError: true,
                                //           getImmediateSuggestions: true,
                                //           suggestionsBoxController:
                                //               controller.suggestionsBoxController,
                                //           textFieldConfiguration:
                                //               CupertinoTextFieldConfiguration(
                                //             controller: controller.topicController,
                                //             decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(15),
                                //               border: Border.all(
                                //                 color: ColorManager.borderColor2,
                                //               ),
                                //             ),
                                //             cursorColor: ColorManager.primary,
                                //             enableSuggestions: true,
                                //             maxLines: 1,
                                //             enableInteractiveSelection: true,
                                //             padding: const EdgeInsets.fromLTRB(
                                //                 10.0, 15.0, 20.0, 15.0),
                                //             style: TextStyle(
                                //               color: ColorManager.fontColor,
                                //               fontSize: 14,
                                //               fontFamily: FontConstants.fontFamily,
                                //             ),
                                //             placeholder:
                                //                 LocaleKeys.search_for_subject.tr,
                                //           ),
                                //           suggestionsCallback:
                                //               (String searchValue) {
                                //             if (controller.topics.result != null &&
                                //                 controller
                                //                     .topics.result!.isNotEmpty) {
                                //               return controller.topics.result!
                                //                   .where((topic.Result topic) =>
                                //                       topic.displayName != null &&
                                //                       topic.displayName!
                                //                           .toLowerCase()
                                //                           .contains(searchValue))
                                //                   .toList();
                                //             } else {
                                //               return [];
                                //             }
                                //           },
                                //           hideOnEmpty: true,
                                //           transitionBuilder: (context,
                                //               suggestionsBox, controller) {
                                //             return suggestionsBox;
                                //           },
                                //           itemBuilder: (BuildContext context,
                                //               topic.Result result) {
                                //             return Padding(
                                //               padding: const EdgeInsets.all(5.0),
                                //               child: PrimaryText(
                                //                 result.displayName ?? "",
                                //                 color: ColorManager.fontColor,
                                //                 fontSize: 12,
                                //               ),
                                //             );
                                //           },
                                //           noItemsFoundBuilder:
                                //               (BuildContext context) {
                                //             return PrimaryText(
                                //               LocaleKeys.no_teacher_found,
                                //             );
                                //           },
                                //           onSuggestionSelected:
                                //               (topic.Result result) {
                                //             controller.changeTopic(result);
                                //           },
                                //           errorBuilder: (context, error) {
                                //             return PrimaryText(
                                //               error.toString(),
                                //               color: ColorManager.red,
                                //             );
                                //           },
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 16.w,
                                    right: 16.w,
                                    top: 16.h,
                                  ),
                                  child: PrimaryDropDown(
                                    fontColor: ColorManager.fontColor5,
                                    items: controller.classes.result != null &&
                                            controller.classes.result!.items !=
                                                null &&
                                            controller.classes.result!.items!
                                                .isNotEmpty
                                        ? (controller.classes.result!.items!
                                                .map((level.Item item) =>
                                                    item.displayName ?? ""))
                                            .toList()
                                        : [""],
                                    hint: LocaleKeys.studying_class,
                                    value: controller.classes.result != null &&
                                            controller.classes.result!.items !=
                                                null &&
                                            controller.classes.result!.items!
                                                .isNotEmpty
                                        ? controller.classes.result!.items!
                                                    .firstWhereOrNull(
                                                        (level.Item level) =>
                                                            (level.id ?? -1) ==
                                                            controller
                                                                .selectedClass
                                                                .id) !=
                                                null
                                            ? controller.classes.result!.items!
                                                    .firstWhereOrNull((level.Item level) =>
                                                        (level.id ?? -1) ==
                                                        controller.selectedClass.id)!
                                                    .displayName ??
                                                ""
                                            : (controller.classes.result!.items![0].displayName ?? "")
                                        : "",
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
                                    onChanged: (String? value) =>
                                        controller.changeLevel(value),
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
                                  fontSize: 14,
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
                                          color:
                                              controller.teacherGender == index
                                                  ? ColorManager.primary
                                                  : ColorManager.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: controller.teacherGender !=
                                                  index
                                              ? Border.all(
                                                  color:
                                                      ColorManager.borderColor2,
                                                  width: 1,
                                                )
                                              : null,
                                        ),
                                        child: Center(
                                          child: PrimaryText(
                                            index == 0
                                                ? LocaleKeys.male
                                                : LocaleKeys.female,
                                            color: controller.teacherGender ==
                                                    index
                                                ? ColorManager.white
                                                : ColorManager.borderColor,
                                            fontWeight:
                                                FontWeightManager.softLight,
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
                        fontSize: 16,
                        onPressed: () async {
                          if (await checkInternetConnection(timeout: 10)) {
                            await controller.filterTeachers(
                              levelId: controller.selectedClass.id,
                              topicId: controller.selectedTopic.id,
                              skillId: controller.selectedSkill.id,
                              countryId: controller.selectedCountry.id,
                              governorateId: controller.selectedGovernorate.id,
                              genderId: controller.teacherGender +
                                  1, // 1 or 2 , 1 female, 2 male
                            );
                          } else {
                            await Get.toNamed(Routes.CONNECTION_FAILED);
                          }
                          if (Get.isBottomSheetOpen!) {
                            Get.back();
                          }
                        },
                        title: LocaleKeys.search.tr,
                      ),
                      GetBuilder<DarsTeachersController>(
                          builder: (DarsTeachersController controller) {
                        return GlobalButton(
                          width: (Get.width * 0.42).w,
                          borderRadius: BorderRadius.circular(15.h),
                          height: 55.h,
                          onTap: () async {
                            if (controller.toggleFilter == true) {
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
                        );
                      }),
                    ],
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
