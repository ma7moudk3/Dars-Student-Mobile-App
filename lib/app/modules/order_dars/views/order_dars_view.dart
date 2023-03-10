import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/modules/addresses/data/models/address_result/address_result.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_widgets/global_dropdown.dart';
import 'package:lottie/lottie.dart';

import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/confirm_back_dialog_content.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/shimmer_loading.dart';
import '../../../../global_presentation/global_widgets/typeahead/cupertino_flutter_typeahead.dart';
import '../../../routes/app_pages.dart';
import '../../preferred_teachers/data/models/preferred_teacher/preferred_teacher.dart';
import '../controllers/order_dars_controller.dart';
import '../widgets/add_student_widget.dart';
import '../widgets/dars_date_time_picker_widget.dart';
import '../widgets/order_dars_options.dart';
import '../widgets/type_ahead_teacher_widget.dart';

class OrderDarsView extends GetView<OrderDarsController> {
  const OrderDarsView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!Get.isRegistered<OrderDarsController>()) {
          return true;
        }
        if (!controller.isDataChanged() || controller.isLoading.value) {
          return true;
        } else {
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
                  child: const ConfirmBackDialogContent(),
                ),
              ),
            ),
          );
          return false;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title:
              controller.orderIdToEdit != null && controller.orderIdToEdit != -1
                  ? LocaleKeys.edit_order_dars
                  : LocaleKeys.order_dars,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              if (!Get.isRegistered<OrderDarsController>()) {
                Get.back();
              }
              if (controller.isDataChanged()) {
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
                        child: const ConfirmBackDialogContent(),
                      ),
                    ),
                  ),
                );
              } else {
                Get.back();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.fontColor,
                size: 20,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: GetX<OrderDarsController>(
              builder: (OrderDarsController controller) {
            if (controller.isInternetConnected.value) {
              if (controller.isLoading.value == false) {
                return GetBuilder<OrderDarsController>(
                    builder: (OrderDarsController controller) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 26.h),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 11.w, right: 11.w, bottom: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImagesManager.categoryIcon,
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  SizedBox(width: 10.w),
                                  PrimaryText(
                                    LocaleKeys.order_new_dars,
                                    fontSize: 16,
                                    fontWeight: FontWeightManager.softLight,
                                    color: ColorManager.fontColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              PrimaryText(
                                LocaleKeys.fill_the_student_form,
                                fontSize: 14,
                                fontWeight: FontWeightManager.softLight,
                                color: ColorManager.fontColor7,
                              ),
                              SizedBox(height: 25.h),
                              Container(
                                width: Get.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      offset: Offset(0, 1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Form(
                                  key: controller.formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          PrimaryText(
                                            LocaleKeys.student_name,
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            color: ColorManager.fontColor,
                                          ),
                                          SizedBox(width: 2.w),
                                          PrimaryText(
                                            "*",
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            color: ColorManager.accent,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      const AddStudentOrderDarsWidget(),
                                      SizedBox(height: 12.h),
                                      // for now >> not required in the api
                                      // Column(
                                      //   children: [
                                      //     Row(
                                      //       children: [
                                      //         PrimaryText(
                                      //           LocaleKeys.studying_class,
                                      //           fontSize: 14,
                                      //           fontWeight: FontWeightManager
                                      //               .softLight,
                                      //           color: ColorManager.fontColor,
                                      //         ),
                                      //         SizedBox(width: 2.w),
                                      //         PrimaryText(
                                      //           "*",
                                      //           fontSize: 16,
                                      //           fontWeight: FontWeightManager
                                      //               .softLight,
                                      //           color: ColorManager.accent,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     SizedBox(height: 12.h),
                                      //     PrimaryDropDown(
                                      //       fontColor:
                                      //           ColorManager.fontColor5,
                                      //       items:
                                      //           controller
                                      //                           .classes.result !=
                                      //                       null &&
                                      //                   controller
                                      //                           .classes
                                      //                           .result!
                                      //                           .items !=
                                      //                       null &&
                                      //                   controller
                                      //                       .classes
                                      //                       .result!
                                      //                       .items!
                                      //                       .isNotEmpty
                                      //               ? (controller.classes
                                      //                   .result!.items!
                                      //                   .map((level.Item
                                      //                           item) =>
                                      //                       item.displayName ??
                                      //                       "")).toList()
                                      //               : [""],
                                      //       hint: LocaleKeys.studying_class,
                                      //       value: controller.classes.result != null &&
                                      //               controller.classes.result!.items !=
                                      //                   null &&
                                      //               controller.classes.result!
                                      //                   .items!.isNotEmpty
                                      //           ? controller.classes.result!.items!.firstWhereOrNull((level.Item level) => (level.id ?? -1) == controller.selectedClass.id) !=
                                      //                   null
                                      //               ? controller.classes
                                      //                       .result!.items!
                                      //                       .firstWhereOrNull((level.Item level) =>
                                      //                           (level.id ?? -1) ==
                                      //                           controller
                                      //                               .selectedClass
                                      //                               .id)!
                                      //                       .displayName ??
                                      //                   ""
                                      //               : (controller
                                      //                       .classes
                                      //                       .result!
                                      //                       .items![0]
                                      //                       .displayName ??
                                      //                   "")
                                      //           : "",
                                      //       disabledBorder:
                                      //           OutlineInputBorder(
                                      //         borderSide: BorderSide(
                                      //           color:
                                      //               ColorManager.borderColor2,
                                      //           width: 1.2,
                                      //         ),
                                      //         borderRadius:
                                      //             BorderRadius.circular(12),
                                      //       ),
                                      //       width: Get.width,
                                      //       height: 50.h,
                                      //       enabledBorder: OutlineInputBorder(
                                      //         borderSide: BorderSide(
                                      //           color:
                                      //               ColorManager.borderColor2,
                                      //           width: 1.2,
                                      //         ),
                                      //         borderRadius:
                                      //             BorderRadius.circular(12),
                                      //       ),
                                      //       focusedBorder: OutlineInputBorder(
                                      //         borderSide: BorderSide(
                                      //           color:
                                      //               ColorManager.borderColor2,
                                      //           width: 1.2,
                                      //         ),
                                      //         borderRadius:
                                      //             BorderRadius.circular(12),
                                      //       ),
                                      //       onChanged: (String? value) =>
                                      //           controller.changeLevel(value),
                                      //     ),
                                      //   ],
                                      // ),
                                      Row(
                                        children: [
                                          PrimaryText(
                                            LocaleKeys.order_dars_category,
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            color: ColorManager.fontColor,
                                          ),
                                          SizedBox(width: 2.w),
                                          PrimaryText(
                                            "*",
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            color: ColorManager.accent,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        children: List.generate(2, (int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller
                                                  .changeDarsCategory(index);
                                            },
                                            child: Container(
                                              width: 100.w,
                                              height: 40.h,
                                              margin: EdgeInsets.only(
                                                left: index == 1 ? 0 : 10.w,
                                              ),
                                              decoration: BoxDecoration(
                                                color: controller
                                                            .darsCategory ==
                                                        index
                                                    ? ColorManager.primary
                                                    : ColorManager.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border:
                                                    controller.darsCategory !=
                                                            index
                                                        ? Border.all(
                                                            color: ColorManager
                                                                .borderColor2,
                                                            width: 1,
                                                          )
                                                        : null,
                                                boxShadow: const [],
                                              ),
                                              child: Center(
                                                child: PrimaryText(
                                                  index == 0
                                                      ? LocaleKeys
                                                          .academic_learning
                                                      : LocaleKeys.skill,
                                                  color:
                                                      controller.darsCategory ==
                                                              index
                                                          ? ColorManager.white
                                                          : ColorManager
                                                              .borderColor,
                                                  fontWeight: FontWeightManager
                                                      .softLight,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      Visibility(
                                        visible: controller.darsCategory ==
                                            0, // academic learning
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 12.h),
                                            Row(
                                              children: [
                                                PrimaryText(
                                                  LocaleKeys.studying_subjects,
                                                  fontSize: 14,
                                                  fontWeight: FontWeightManager
                                                      .softLight,
                                                  color: ColorManager.fontColor,
                                                ),
                                                SizedBox(width: 2.w),
                                                PrimaryText(
                                                  "*",
                                                  fontSize: 16,
                                                  fontWeight: FontWeightManager
                                                      .softLight,
                                                  color: ColorManager.accent,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 12.h),
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () async {
                                                await controller
                                                    .showMultiSelectTopics();
                                              },
                                              child: PrimaryDropDown(
                                                fontColor:
                                                    ColorManager.fontColor5,
                                                isDisabled: true,
                                                items: const [
                                                  LocaleKeys
                                                      .choose_one_studying_subject_at_least
                                                ],
                                                hint: LocaleKeys
                                                    .studying_subjects,
                                                value: LocaleKeys
                                                    .choose_one_studying_subject_at_least,
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorManager
                                                        .borderColor2,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                width: Get.width,
                                                height: 50.h,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorManager
                                                        .borderColor2,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorManager
                                                        .borderColor2,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                onChanged: (String? value) =>
                                                    {},
                                              ),
                                            ),
                                            Wrap(
                                              spacing: 5.w,
                                              children: controller
                                                  .selectedTopics
                                                  .map((String item) {
                                                return Chip(
                                                  backgroundColor: ColorManager
                                                      .primary
                                                      .withOpacity(0.10),
                                                  onDeleted: () {
                                                    controller
                                                        .removeTopic(item);
                                                  },
                                                  deleteIconColor:
                                                      ColorManager.primary,
                                                  deleteButtonTooltipMessage:
                                                      LocaleKeys.delete.tr,
                                                  labelPadding: EdgeInsets.only(
                                                      right: 5.w),
                                                  deleteIcon: Icon(
                                                    Icons.close,
                                                    color: ColorManager.primary,
                                                    size: 14,
                                                  ),
                                                  label: PrimaryText(
                                                    item,
                                                    color: ColorManager.primary,
                                                    fontSize: 12,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.darsCategory ==
                                            1, // skill
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 12.h),
                                            Row(
                                              children: [
                                                PrimaryText(
                                                  LocaleKeys.skills,
                                                  fontSize: 14,
                                                  fontWeight: FontWeightManager
                                                      .softLight,
                                                  color: ColorManager.fontColor,
                                                ),
                                                SizedBox(width: 2.w),
                                                PrimaryText(
                                                  "*",
                                                  fontSize: 16,
                                                  fontWeight: FontWeightManager
                                                      .softLight,
                                                  color: ColorManager.accent,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 12.h),
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () async {
                                                await controller
                                                    .showMultiSelectSkills();
                                              },
                                              child: PrimaryDropDown(
                                                fontColor:
                                                    ColorManager.fontColor5,
                                                isDisabled: true,
                                                items: const [
                                                  LocaleKeys
                                                      .choose_one_skill_at_least
                                                ],
                                                hint: LocaleKeys.skills,
                                                value: LocaleKeys
                                                    .choose_one_skill_at_least,
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorManager
                                                        .borderColor2,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                width: Get.width,
                                                height: 50.h,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorManager
                                                        .borderColor2,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorManager
                                                        .borderColor2,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                onChanged: (String? value) =>
                                                    {},
                                              ),
                                            ),
                                            Wrap(
                                              spacing: 5.w,
                                              children: controller
                                                  .selectedSkills
                                                  .map((String item) {
                                                return Chip(
                                                  backgroundColor: ColorManager
                                                      .primary
                                                      .withOpacity(0.10),
                                                  onDeleted: () {
                                                    controller
                                                        .removeSkill(item);
                                                  },
                                                  deleteIconColor:
                                                      ColorManager.primary,
                                                  deleteButtonTooltipMessage:
                                                      LocaleKeys.delete.tr,
                                                  labelPadding: EdgeInsets.only(
                                                      right: 5.w),
                                                  deleteIcon: Icon(
                                                    Icons.close,
                                                    color: ColorManager.primary,
                                                    size: 14,
                                                  ),
                                                  label: PrimaryText(
                                                    item,
                                                    color: ColorManager.primary,
                                                    fontSize: 12,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      const OrderDarsOptions(),
                                      SizedBox(height: 12.h),
                                      Row(
                                        children: [
                                          PrimaryText(
                                            LocaleKeys.dars_time_and_date,
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            color: ColorManager.fontColor,
                                          ),
                                          SizedBox(width: 2.w),
                                          PrimaryText(
                                            "*",
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            color: ColorManager.accent,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        children: List.generate(2, (int index) {
                                          return Container(
                                            width: Get.width * 0.40,
                                            margin: EdgeInsets.only(
                                              right: index == 1 ? 10.w : 0.w,
                                            ),
                                            child: DarsDateAndTimePickerWidget(
                                                index: index),
                                          );
                                        }),
                                      ),
                                      SizedBox(height: 12.h),
                                      GetBuilder<OrderDarsController>(builder:
                                          (OrderDarsController controller) {
                                        if (controller
                                                .isAddressDropDownLoading ==
                                            true) {
                                          return const ShimmerLoading();
                                        } else {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  PrimaryText(
                                                    LocaleKeys.location,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .softLight,
                                                    color:
                                                        ColorManager.fontColor,
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  PrimaryText(
                                                    "*",
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .softLight,
                                                    color: ColorManager.accent,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 12.h),
                                              PrimaryDropDown(
                                                fontColor:
                                                    ColorManager.fontColor5,
                                                items: controller
                                                        .addresses.isNotEmpty
                                                    ? (controller.addresses.map((AddressResult
                                                            addressResult) =>
                                                        addressResult.countryName !=
                                                                    null &&
                                                                addressResult
                                                                        .governorateName !=
                                                                    null &&
                                                                addressResult
                                                                        .localityName !=
                                                                    null
                                                            ? "${addressResult.countryName ?? ""} - ${addressResult.governorateName ?? ""} - ${addressResult.localityName ?? ""}"
                                                            : "${addressResult.countryName ?? ""}${addressResult.governorateName ?? ""}${addressResult.localityName ?? ""}")).toList()
                                                    : [LocaleKeys.choose_location.tr],
                                                prefixIcon: Icon(
                                                  Icons.location_on_outlined,
                                                  color: ColorManager.yellow,
                                                  size: 22,
                                                ),
                                                suffixIcon: GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () async {
                                                    await Get.toNamed(
                                                        Routes.ADD_NEW_ADDRESS,
                                                        arguments: {
                                                          "isFromOrderDars":
                                                              true
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons.add_rounded,
                                                    color: ColorManager.primary,
                                                    size: 22,
                                                  ),
                                                ),
                                                value: controller
                                                            .selectedAddress !=
                                                        null
                                                    ? controller
                                                                    .selectedAddress
                                                                    ?.countryName !=
                                                                null &&
                                                            controller
                                                                    .selectedAddress
                                                                    ?.governorateName !=
                                                                null &&
                                                            controller
                                                                    .selectedAddress
                                                                    ?.localityName !=
                                                                null
                                                        ? "${controller.selectedAddress?.countryName ?? ""} - ${controller.selectedAddress?.governorateName ?? ""} - ${controller.selectedAddress?.localityName ?? ""}"
                                                        : "${controller.selectedAddress?.countryName ?? ""}${controller.selectedAddress?.governorateName ?? ""}${controller.selectedAddress?.localityName ?? ""}"
                                                    : LocaleKeys
                                                        .choose_location.tr,
                                                hint: LocaleKeys.location,
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorManager
                                                        .borderColor2,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                width: Get.width,
                                                height: 50.h,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorManager
                                                        .borderColor2,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorManager
                                                        .borderColor2,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                onChanged: (String? value) =>
                                                    controller
                                                        .changeAddress(value),
                                              ),
                                            ],
                                          );
                                        }
                                      }),
                                      SizedBox(height: 12.h),
                                      Row(
                                        children: [
                                          PrimaryText(
                                            LocaleKeys.preferred_teacher_name,
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            color: ColorManager.fontColor,
                                          ),
                                          // uncomment this if you want to make teacher name required
                                          // SizedBox(width: 2.w),
                                          // PrimaryText(
                                          //   "*",
                                          //   fontSize: 16,
                                          //   fontWeight:
                                          //       FontWeightManager.softLight,
                                          //   color: ColorManager.accent,
                                          // ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      CupertinoTypeAheadFormField(
                                        hideOnError: true,
                                        getImmediateSuggestions: true,
                                        suggestionsBoxController:
                                            controller.suggestionsBoxController,
                                        textFieldConfiguration:
                                            CupertinoTextFieldConfiguration(
                                          controller: controller
                                              .preferredTeacherNameController,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: ColorManager.borderColor2,
                                            ),
                                          ),
                                          cursorColor: ColorManager.primary,
                                          enableSuggestions: true,
                                          maxLines: 1,
                                          enableInteractiveSelection: true,
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 15.0, 20.0, 15.0),
                                          style: TextStyle(
                                            color: ColorManager.fontColor,
                                            fontSize: 14,
                                            fontFamily:
                                                FontConstants.fontFamily,
                                          ),
                                          suffix: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () async {
                                              // go to assign teacher screen
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 10.w),
                                              child: SvgPicture.asset(
                                                ImagesManager.addPersonIcon,
                                                color: controller
                                                    .teacherNameErrorIconColor,
                                              ),
                                            ),
                                          ),
                                          placeholder:
                                              LocaleKeys.write_teacher_name.tr,
                                        ),
                                        keepSuggestionsOnLoading: true,
                                        suggestionsCallback:
                                            (String searchValue) async {
                                          if (searchValue.isNotEmpty &&
                                              searchValue.length >= 3 &&
                                              searchValue.trim().isNotEmpty) {
                                            return await controller
                                                .searchTeacher(
                                                    searchValue: searchValue
                                                        .toLowerCase());
                                          } else {
                                            return <PreferredTeacher>[];
                                          }
                                        },
                                        hideOnEmpty: true,
                                        transitionBuilder: (context,
                                            suggestionsBox, controller) {
                                          return suggestionsBox;
                                        },
                                        itemBuilder: (BuildContext context,
                                            PreferredTeacher teacher) {
                                          return TypeAheadPreferredTeacherWidget(
                                            teacher: teacher,
                                          );
                                        },
                                        noItemsFoundBuilder:
                                            (BuildContext context) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 8.h),
                                            decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              border: Border.all(
                                                color: CupertinoColors
                                                    .extraLightBackgroundGray,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x29000000),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 8,
                                                ),
                                              ],
                                            ),
                                            child: PrimaryText(
                                              LocaleKeys.no_teacher_found,
                                            ),
                                          );
                                        },
                                        onSuggestionSelected:
                                            (PreferredTeacher teacher) {
                                          controller.selectTeacher(teacher);
                                        },
                                        errorBuilder: (context, error) {
                                          controller.selectTeacher(null);
                                          return PrimaryText(
                                            error.toString(),
                                            color: ColorManager.red,
                                          );
                                        },
                                      ),
                                      SizedBox(height: 12.h),
                                      PrimaryTextField(
                                        fontSize: 14,
                                        multiLines: true,
                                        maxLines: 8,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20.0, 20.0, 20.0, 10.0),
                                        controller: controller.notesController,
                                        title: LocaleKeys.notes,
                                        borderRadius: BorderRadius.circular(14),
                                        titleFontWeight:
                                            FontWeightManager.softLight,
                                        onTap: () async {},
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                              color: ColorManager.borderColor2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                              color: ColorManager.primary),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                              color: ColorManager.red),
                                        ),
                                        borderSide: BorderSide(
                                          color: ColorManager.primary,
                                        ),
                                        hintText:
                                            LocaleKeys.write_down_you_notes,
                                      ),
                                      const SizedBox(height: 10.0),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 25.h),
                              PrimaryButton(
                                onPressed: () async {
                                  if (controller.selectedStudents.isEmpty) {
                                    CustomSnackBar.showCustomErrorSnackBar(
                                      title: LocaleKeys.data_entry_error.tr,
                                      message: LocaleKeys
                                          .choose_one_student_at_least.tr,
                                    );
                                  } else if (controller.darsCategory ==
                                          0 && // academic learning category
                                      controller.selectedTopics.isEmpty) {
                                    CustomSnackBar.showCustomErrorSnackBar(
                                      title: LocaleKeys.data_entry_error.tr,
                                      message: LocaleKeys
                                          .choose_one_studying_subject_at_least
                                          .tr,
                                    );
                                  } else if (controller.darsCategory ==
                                          1 && // skills category
                                      controller.selectedSkills.isEmpty) {
                                    CustomSnackBar.showCustomErrorSnackBar(
                                      title: LocaleKeys.data_entry_error.tr,
                                      message: LocaleKeys
                                          .choose_one_skill_at_least.tr,
                                    );
                                  } else if (controller.selectedAddress ==
                                      null) {
                                    CustomSnackBar.showCustomErrorSnackBar(
                                      title: LocaleKeys.data_entry_error.tr,
                                      message: LocaleKeys.choose_location.tr,
                                    );
                                  } else {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      await controller.addOrEditOrderDars();
                                    }
                                  }
                                },
                                title: controller.orderIdToEdit != null &&
                                        controller.orderIdToEdit != -1
                                    ? LocaleKeys.update_order_dars
                                    : LocaleKeys.submit_form,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
              } else {
                return Center(
                  child: SpinKitCircle(
                    duration: const Duration(milliseconds: 1300),
                    size: 50,
                    color: ColorManager.primary,
                  ),
                );
              }
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryText(
                    LocaleKeys.check_your_internet_connection.tr,
                    fontSize: 18,
                    fontWeight: FontWeightManager.bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: (Get.height * 0.5).h,
                    child: Lottie.asset(
                      LottiesManager.noInernetConnection,
                      animate: true,
                    ),
                  ),
                  PrimaryButton(
                    onPressed: () async {
                      await controller.checkInternet();
                    },
                    title: LocaleKeys.retry.tr,
                    width: (Get.width * 0.5).w,
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
