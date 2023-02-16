import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/confirm_back_dialog_content.dart';
import '../../../data/models/student_relation/result.dart' as student_relation;
import 'package:hessa_student/app/data/models/school_types/result.dart'
    as school_type;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/global_dropdown.dart';
import '../../../data/models/classes/item.dart' as level;
import '../controllers/add_new_dependent_controller.dart';

class AddNewDependentView extends GetView<AddNewDependentController> {
  const AddNewDependentView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFileFunctionalityNeeded = false;
    Future handleAttachmentPressed() async {
      if (Platform.isIOS) {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    child: PrimaryText(LocaleKeys.camera),
                    onPressed: () async {
                      Get.back();
                      await controller.handleImageSelection(
                          imageSource: ImageSource.camera);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: PrimaryText(LocaleKeys.gallery),
                    onPressed: () async {
                      Get.back();
                      await controller.handleImageSelection(
                          imageSource: ImageSource.gallery);
                    },
                  ),
                  Visibility(
                    visible: isFileFunctionalityNeeded,
                    child: CupertinoActionSheetAction(
                      child: PrimaryText(LocaleKeys.file),
                      onPressed: () async {
                        Get.back();
                        await controller.handleFileSelection();
                      },
                    ),
                  ),
                  CupertinoActionSheetAction(
                    child: PrimaryText(LocaleKeys.close.tr),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              );
            });
      } else {
        Get.bottomSheet(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SizedBox(
              height: isFileFunctionalityNeeded == true
                  ? Get.height * 0.20
                  : Get.height * 0.13,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.camera_alt_rounded,
                      size: 25,
                    ),
                    title: PrimaryText("camera".tr),
                    onTap: () async {
                      Get.back();
                      await controller.handleImageSelection(
                          imageSource: ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_rounded,
                      size: 25,
                    ),
                    title: PrimaryText("gallery".tr),
                    onTap: () async {
                      Get.back();
                      await controller.handleImageSelection(
                          imageSource: ImageSource.gallery);
                    },
                  ),
                  Visibility(
                    visible: isFileFunctionalityNeeded,
                    child: ListTile(
                      // the file functionality is not required at the moment
                      leading: const Icon(
                        Icons.file_present_rounded,
                        size: 25,
                      ),
                      title: PrimaryText("file".tr),
                      onTap: () async {
                        Get.back();
                        await controller.handleFileSelection();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          backgroundColor: ColorManager.white,
        );
      }
    }

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
                child: const ConfirmBackDialogContent(),
              ),
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.add_dependent,
          leading: GestureDetector(
            onTap: () async {
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
            },
            behavior: HitTestBehavior.opaque,
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorManager.fontColor,
              size: 20,
            ),
          ),
          action: const SizedBox.shrink(),
        ),
        body: GetX<AddNewDependentController>(
            builder: (AddNewDependentController controller) {
          if (controller.isInternetConnected.value) {
            if (controller.isLoading.value == false) {
              return GetBuilder<AddNewDependentController>(
                  builder: (AddNewDependentController controller) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 32.h),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: Container(
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
                          child: GetBuilder<AddNewDependentController>(
                              builder: (AddNewDependentController controller) {
                            return Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: controller.image != null,
                                    child: Center(
                                      child: Container(
                                        width: 85.w,
                                        height: 85.h,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: controller.image != null
                                                ? FileImage(controller.image!)
                                                    as ImageProvider
                                                : AssetImage(
                                                    ImagesManager.avatar),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: ColorManager.primary,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  PrimaryTextField(
                                    fontSize: 14.sp,
                                    isRequired: true,
                                    controller: controller.nameController,
                                    title: LocaleKeys.name,
                                    focusNode: controller.nameFocusNode,
                                    titleFontWeight:
                                        FontWeightManager.softLight,
                                    onTap: () async {},
                                    prefixIcon: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 14.w),
                                      child: SvgPicture.asset(
                                        ImagesManager.personIcon,
                                        width: 22.w,
                                        height: 22.h,
                                        color: controller.nameIconErrorColor ??
                                            ColorManager.primary,
                                      ),
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minHeight: 22.h,
                                      minWidth: 22.w,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                          color: ColorManager.borderColor2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                          color: ColorManager.primary),
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide:
                                          BorderSide(color: ColorManager.red),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorManager.primary,
                                    ),
                                    hintText: LocaleKeys.write_dependent_name,
                                    validator: (String? dependentName) =>
                                        controller.validateDependentName(
                                            dependentName),
                                  ),
                                  SizedBox(height: 12.h),
                                  PrimaryTextField(
                                    fontSize: 14.sp,
                                    isRequired: true,
                                    readOnly: true,
                                    ifReadOnlyTextColor:
                                        ColorManager.fontColor7,
                                    controller:
                                        controller.uplpoadPictureFileController,
                                    textDirection: TextDirection.ltr,
                                    title: LocaleKeys.person_picture,
                                    focusNode:
                                        controller.uplpoadPictureFileFocusNode,
                                    titleFontWeight:
                                        FontWeightManager.softLight,
                                    onTap: () async {
                                      handleAttachmentPressed();
                                    },
                                    suffixIcon: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 14.w),
                                      child: SvgPicture.asset(
                                        ImagesManager.uploadFileIcon,
                                        width: 22.w,
                                        height: 22.h,
                                        color: controller
                                                .uplpoadPictureFileIconErrorColor ??
                                            (controller
                                                    .uplpoadPictureFileFocusNode
                                                    .hasFocus
                                                ? (controller
                                                        .uplpoadPictureFileIconErrorColor ??
                                                    ColorManager.primary)
                                                : ColorManager.primaryLight),
                                      ),
                                    ),
                                    suffixIconConstraints: BoxConstraints(
                                      minHeight: 22.h,
                                      minWidth: 22.w,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                          color: ColorManager.borderColor2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                          color: ColorManager.primary),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide:
                                          BorderSide(color: ColorManager.red),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorManager.primary,
                                    ),
                                    hintText: LocaleKeys.upload_picture_or_pdf,
                                  ),
                                  // SizedBox(height: 12.h),
                                  // PrimaryTextField(
                                  //   fontSize: 14.sp,
                                  //   readOnly: true,
                                  //   ifReadOnlyTextColor:
                                  //       ColorManager.fontColor7,
                                  //   controller:
                                  //       controller.dateOfBirthController,
                                  //   title: LocaleKeys.date_of_birth,
                                  //   borderRadius: BorderRadius.circular(14),
                                  //   focusNode:
                                  //       controller.dateOfBirthFocusNode,
                                  //   titleFontWeight:
                                  //       FontWeightManager.softLight,
                                  //   onTap: () async {
                                  //     DateTime maxdate = DateTime(
                                  //       DateTime.now().year - 10,
                                  //       DateTime.now().month,
                                  //       DateTime.now().day,
                                  //     );
                                  //     await Get.bottomSheet(
                                  //       isScrollControlled: true,
                                  //       shape: const RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.only(
                                  //           topLeft: Radius.circular(20),
                                  //           topRight: Radius.circular(20),
                                  //         ),
                                  //       ),
                                  //       DateOfBirthBottomSheetContent(
                                  //           maxdate: maxdate),
                                  //       backgroundColor: ColorManager.white,
                                  //     );
                                  //   },
                                  //   suffixIcon: Container(
                                  //     margin: EdgeInsets.symmetric(
                                  //         horizontal: 14.w),
                                  //     child: SvgPicture.asset(
                                  //       ImagesManager.calendarIcon,
                                  //       width: 22.w,
                                  //       height: 22.h,
                                  //       color: controller
                                  //               .dateOfBirthIconErrorColor ??
                                  //           (controller.dateOfBirthFocusNode
                                  //                   .hasFocus
                                  //               ? (controller
                                  //                       .dateOfBirthIconErrorColor ??
                                  //                   ColorManager.primary)
                                  //               : ColorManager
                                  //                   .primaryLight),
                                  //     ),
                                  //   ),
                                  //   suffixIconConstraints: BoxConstraints(
                                  //     minHeight: 22.h,
                                  //     minWidth: 22.w,
                                  //   ),
                                  //   enabledBorder: OutlineInputBorder(
                                  //     borderRadius:
                                  //         BorderRadius.circular(14),
                                  //     borderSide: BorderSide(
                                  //         color: ColorManager.borderColor2),
                                  //   ),
                                  //   focusedBorder: OutlineInputBorder(
                                  //     borderRadius:
                                  //         BorderRadius.circular(14),
                                  //     borderSide: BorderSide(
                                  //         color: ColorManager.primary),
                                  //   ),
                                  //   errorBorder: OutlineInputBorder(
                                  //     borderRadius:
                                  //         BorderRadius.circular(14),
                                  //     borderSide: BorderSide(
                                  //         color: ColorManager.red),
                                  //   ),
                                  //   borderSide: BorderSide(
                                  //     color: ColorManager.primary,
                                  //   ),
                                  //   hintText:
                                  //       LocaleKeys.choose_date_of_birth,
                                  //   validator: (String? dateOfBirth) =>
                                  //       controller.validateDateOfBirth(
                                  //           dateOfBirth),
                                  // ),
                                  SizedBox(height: 12.h),
                                  Row(
                                    children: [
                                      PrimaryText(
                                        LocaleKeys.student_relation,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.fontColor,
                                      ),
                                      SizedBox(width: 2.w),
                                      PrimaryText(
                                        "*",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.accent,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  PrimaryDropDown(
                                    fontColor: ColorManager.fontColor5,
                                    items: controller.studentRelations.result !=
                                                null &&
                                            controller.studentRelations.result!
                                                .isNotEmpty
                                        ? (controller.studentRelations.result!
                                            .map((student_relation.Result
                                                    studentRelation) =>
                                                studentRelation.displayName ??
                                                "")).toList()
                                        : [""],
                                    hint: LocaleKeys.student_relation.tr,
                                    value: controller.studentRelations.result != null &&
                                            controller.studentRelations.result!
                                                .isNotEmpty
                                        ? controller.studentRelations.result!.firstWhereOrNull(
                                                    (student_relation.Result studentRelation) =>
                                                        (studentRelation.id ?? -1) ==
                                                        controller
                                                            .selectedStudentRelation
                                                            .id) !=
                                                null
                                            ? controller.studentRelations.result!
                                                    .firstWhereOrNull(
                                                        (student_relation.Result studentRelation) =>
                                                            (studentRelation.id ?? -1) ==
                                                            controller.selectedStudentRelation.id)!
                                                    .displayName ??
                                                ""
                                            : (controller.studentRelations.result![0].displayName ?? "")
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
                                    onChanged: (String? studentRelation) =>
                                        controller.changeStudentRelation(
                                            studentRelation),
                                  ),
                                  SizedBox(height: 12.h),
                                  Row(
                                    children: [
                                      PrimaryText(
                                        LocaleKeys.school_type,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.fontColor,
                                      ),
                                      SizedBox(width: 2.w),
                                      PrimaryText(
                                        "*",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.accent,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  PrimaryDropDown(
                                    fontColor: ColorManager.fontColor5,
                                    items: controller.schoolTypes.result !=
                                                null &&
                                            controller
                                                .schoolTypes.result!.isNotEmpty
                                        ? (controller.schoolTypes.result!.map(
                                            (school_type.Result schoolType) =>
                                                schoolType.displayName ??
                                                "")).toList()
                                        : [""],
                                    hint: LocaleKeys.school_type.tr,
                                    value: controller.schoolTypes.result != null &&
                                            controller
                                                .schoolTypes.result!.isNotEmpty
                                        ? controller.schoolTypes.result!.firstWhereOrNull(
                                                    (school_type.Result schoolType) =>
                                                        (schoolType.id ?? -1) ==
                                                        controller
                                                            .selectedSchoolType
                                                            .id) !=
                                                null
                                            ? controller.schoolTypes.result!
                                                    .firstWhereOrNull(
                                                        (school_type.Result schoolType) =>
                                                            (schoolType.id ?? -1) ==
                                                            controller
                                                                .selectedSchoolType
                                                                .id)!
                                                    .displayName ??
                                                ""
                                            : (controller.schoolTypes.result![0].displayName ?? "")
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
                                    onChanged: (String? schoolType) =>
                                        controller.changeSchoolType(schoolType),
                                  ),
                                  SizedBox(height: 12.h),
                                  PrimaryTextField(
                                    fontSize: 14.sp,
                                    isRequired: true,
                                    controller: controller.schoolNameController,
                                    title: LocaleKeys.school_name,
                                    titleFontWeight:
                                        FontWeightManager.softLight,
                                    onTap: () async {},
                                    prefixIcon: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 14.w,
                                      ),
                                      child: Icon(
                                        Icons.school_rounded,
                                        color: controller
                                                .schoolNameIconErrorColor ??
                                            ColorManager.primary,
                                        size: 22.sp,
                                      ),
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minHeight: 22.h,
                                      minWidth: 22.w,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                          color: ColorManager.borderColor2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                          color: ColorManager.primary),
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide:
                                          BorderSide(color: ColorManager.red),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorManager.primary,
                                    ),
                                    hintText: LocaleKeys.write_school_name,
                                    validator: (String? schoolName) =>
                                        controller
                                            .validateSchoolName(schoolName),
                                  ),
                                  SizedBox(height: 12.h),
                                  Row(
                                    children: [
                                      PrimaryText(
                                        LocaleKeys.studying_class,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.fontColor,
                                      ),
                                      SizedBox(width: 2.w),
                                      PrimaryText(
                                        "*",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.accent,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  PrimaryDropDown(
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
                                    onChanged: (String? level) =>
                                        controller.changeLevel(level),
                                  ),
                                  SizedBox(height: 12.h),
                                  PrimaryTextField(
                                    fontSize: 14.sp,
                                    multiLines: true,
                                    maxLines: 8,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 10.0),
                                    controller: controller.notesController,
                                    title: LocaleKeys.notes,
                                    borderRadius: BorderRadius.circular(14),
                                    titleFontWeight:
                                        FontWeightManager.softLight,
                                    onTap: () async {},
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                          color: ColorManager.borderColor2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                          color: ColorManager.primary),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide:
                                          BorderSide(color: ColorManager.red),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorManager.primary,
                                    ),
                                    hintText: LocaleKeys.notes_about_dependent,
                                  ),
                                  // PrimaryText(
                                  //   LocaleKeys.studying_subject,
                                  //   fontSize: 14.sp,
                                  //   fontWeight: FontWeightManager.softLight,
                                  //   color: ColorManager.fontColor,
                                  // ),
                                  // SizedBox(height: 12.h),
                                  // PrimaryDropDown(
                                  //   fontColor: ColorManager.fontColor5,
                                  //   items: controller.topics.result != null &&
                                  //           controller.topics.result!.isNotEmpty
                                  //       ? (controller.topics.result!.map(
                                  //               (topic.Result result) =>
                                  //                   result.displayName ?? ""))
                                  //           .toList()
                                  //       : [""],
                                  //   hint: LocaleKeys.studying_subject,
                                  //   value: controller.topics.result != null &&
                                  //           controller.topics.result!.isNotEmpty
                                  //       ? controller.topics.result!
                                  //                   .firstWhereOrNull(
                                  //                       (topic.Result topic) =>
                                  //                           (topic.id ?? -1) ==
                                  //                           controller
                                  //                               .selectedTopic
                                  //                               .id) !=
                                  //               null
                                  //           ? controller.topics.result!
                                  //                   .firstWhereOrNull(
                                  //                       (topic.Result topic) =>
                                  //                           (topic.id ?? -1) ==
                                  //                           controller
                                  //                               .selectedTopic
                                  //                               .id)!
                                  //                   .displayName ??
                                  //               ""
                                  //           : (controller.topics.result![0]
                                  //                   .displayName ??
                                  //               "")
                                  //       : "",
                                  //   disabledBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //       color: ColorManager.borderColor2,
                                  //       width: 1.2,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(12),
                                  //   ),
                                  //   width: Get.width,
                                  //   height: 50.h,
                                  //   enabledBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //       color: ColorManager.borderColor2,
                                  //       width: 1.2,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(12),
                                  //   ),
                                  //   focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //       color: ColorManager.borderColor2,
                                  //       width: 1.2,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(12),
                                  //   ),
                                  //   onChanged: (String? topic) =>
                                  //       controller.changeTopic(topic),
                                  // ),
                                  SizedBox(height: 24.h),
                                  Row(
                                    children: [
                                      PrimaryText(
                                        LocaleKeys.gender,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.fontColor,
                                      ),
                                      SizedBox(width: 2.w),
                                      PrimaryText(
                                        "*",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.accent,
                                      ),
                                      SizedBox(width: 5.w),
                                      Row(
                                        children: List.generate(2, (int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller
                                                  .changeDependentGender(index);
                                            },
                                            child: Container(
                                              width: 80.w,
                                              height: 40.h,
                                              margin: EdgeInsets.only(
                                                left: index == 0 ? 10.w : 0.w,
                                                right: index == 1 ? 0 : 10.w,
                                              ),
                                              decoration: BoxDecoration(
                                                color: controller
                                                            .dependentGender ==
                                                        index
                                                    ? ColorManager.primary
                                                    : ColorManager.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: controller
                                                            .dependentGender !=
                                                        index
                                                    ? Border.all(
                                                        color: ColorManager
                                                            .borderColor2,
                                                        width: 1,
                                                      )
                                                    : null,
                                              ),
                                              child: Center(
                                                child: PrimaryText(
                                                  index == 0
                                                      ? LocaleKeys.male
                                                      : index == 1
                                                          ? LocaleKeys.female
                                                          : LocaleKeys.both,
                                                  color: controller
                                                              .dependentGender ==
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
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom: Get.height * 0.08.h),
                        child: PrimaryButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.image == null) {
                                CustomSnackBar.showCustomErrorSnackBar(
                                  title: LocaleKeys.data_entry_error.tr,
                                  message: LocaleKeys.please_select_image.tr,
                                );
                              } else if (controller
                                          .selectedStudentRelation.id ==
                                      null ||
                                  controller.selectedStudentRelation.id == -1) {
                                CustomSnackBar.showCustomErrorSnackBar(
                                  title: LocaleKeys.data_entry_error.tr,
                                  message: LocaleKeys
                                      .please_select_student_relation.tr,
                                );
                              } else if (controller.selectedSchoolType.id ==
                                      null ||
                                  controller.selectedSchoolType.id == -1) {
                                CustomSnackBar.showCustomErrorSnackBar(
                                  title: LocaleKeys.data_entry_error.tr,
                                  message:
                                      LocaleKeys.please_select_school_type.tr,
                                );
                              } else if (controller.selectedClass.id == null ||
                                  controller.selectedClass.id == -1) {
                                CustomSnackBar.showCustomErrorSnackBar(
                                  title: LocaleKeys.data_entry_error.tr,
                                  message: LocaleKeys.please_select_class.tr,
                                );
                                // } else if (controller.selectedTopic.id == null ||
                                //     controller.selectedTopic.id == -1) {
                                //   CustomSnackBar.showCustomErrorSnackBar(
                                //     title: LocaleKeys.data_entry_error.tr,
                                //     message: LocaleKeys.please_select_subject.tr,
                                //   );
                              } else {
                                await controller.addNewStudent();
                              }
                            }
                          },
                          fontSize: 15.sp,
                          title: LocaleKeys.confirm,
                        ),
                      )
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
                  fontSize: 18.sp,
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
    );
  }
}
