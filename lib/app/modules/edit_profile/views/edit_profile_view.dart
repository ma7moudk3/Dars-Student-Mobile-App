import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/confirm_back_dialog_content.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_field/countries.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_field/phone_number.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_widget.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../../data/cache_helper.dart';
import '../../../routes/app_pages.dart';
import '../../add_new_dependent/widgets/date_of_birth_bottom_sheet_content.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    String userPicture =
        "${Links.baseLink}${Links.profileImageById}?userid=${controller.currentUserProfileInfo.result?.requester?.userId ?? -1}";
    return WillPopScope(
      onWillPop: () async {
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
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.edit_profile,
          leading: GestureDetector(
            onTap: () async {
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
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.fontColor,
                size: 20,
              ),
            ),
          ),
          action: const SizedBox.shrink(),
          // action: GestureDetector(
          //   behavior: HitTestBehavior.opaque,
          //   onTap: () async {},
          //   child: Container(
          //     width: 20.w,
          //     height: 20.h,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         width: 2,
          //         color: ColorManager.primary,
          //       ),
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     child: Center(
          //       child: Icon(
          //         Icons.check,
          //         color: ColorManager.primary,
          //         size: 16,
          //       ),
          //     ),
          //   ),
          // ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 25.h,
                left: 16.w,
                right: 16.w,
                bottom: 20.h,
              ),
              child: Column(
                children: [
                  Form(
                    key: controller.formKey,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                          vertical: 30.h, horizontal: 16.w),
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
                      child: Column(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              if (Platform.isIOS) {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoActionSheet(
                                        actions: [
                                          CupertinoActionSheetAction(
                                            child: PrimaryText(
                                                LocaleKeys.camera.tr),
                                            onPressed: () async {
                                              Get.back();
                                              await controller.pickImage(
                                                  ImageSource.camera);
                                            },
                                          ),
                                          CupertinoActionSheetAction(
                                            child: PrimaryText(
                                                LocaleKeys.gallery.tr),
                                            onPressed: () async {
                                              Get.back();
                                              await controller.pickImage(
                                                  ImageSource.gallery);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                Get.bottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 20.h),
                                    child: SizedBox(
                                      height: Get.height * 0.13,
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            leading: const Icon(
                                                Icons.camera_alt_rounded),
                                            title: PrimaryText(
                                                LocaleKeys.camera.tr),
                                            onTap: () async {
                                              Get.back();
                                              await controller.pickImage(
                                                  ImageSource.camera);
                                            },
                                          ),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.photo_rounded),
                                            title: PrimaryText(
                                                LocaleKeys.gallery.tr),
                                            onTap: () async {
                                              Get.back();
                                              await controller.pickImage(
                                                  ImageSource.gallery);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  backgroundColor: ColorManager.white,
                                );
                              }
                            },
                            child: StatefulBuilder(
                                builder: (BuildContext context, setState) {
                              return GetX<EditProfileController>(
                                  builder: (EditProfileController controller) {
                                return Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: controller.image.value != null
                                          ? FileImage(controller.image.value!)
                                          : (CacheHelper.instance
                                                          .getUserProfilePicture() !=
                                                      null &&
                                                  CacheHelper.instance
                                                      .getUserProfilePicture()!
                                                      .isNotEmpty
                                              ? MemoryImage(base64Decode(
                                                  CacheHelper.instance
                                                      .getUserProfilePicture()!))
                                              : CachedNetworkImageProvider(
                                                  userPicture,
                                                  errorListener: () {
                                                    setState(() {
                                                      userPicture =
                                                          "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                                                    });
                                                  },
                                                )) as ImageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        ColorManager.black.withOpacity(0.1),
                                        BlendMode.srcOver,
                                      ),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x1a000000),
                                        offset: Offset(0, 1),
                                        blurRadius: 8,
                                      ),
                                    ],
                                    border: Border.all(
                                      width: 1,
                                      color: ColorManager.primary,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      ImagesManager.cameraIcon,
                                      width: 27.w,
                                      height: 27.h,
                                    ),
                                  ),
                                );
                              });
                            }),
                          ),
                          const SizedBox(height: 20),
                          GetBuilder<EditProfileController>(
                              builder: (EditProfileController controller) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryTextField(
                                  fontSize: 14,
                                  isRequired: true,
                                  controller: controller.fullNameController,
                                  title: LocaleKeys.full_name,
                                  focusNode: controller.fullNameFocusNode,
                                  titleFontWeight: FontWeightManager.softLight,
                                  onTap: () async {},
                                  prefixIcon: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 14.w),
                                    child: SvgPicture.asset(
                                      ImagesManager.personIcon,
                                      width: 22.w,
                                      height: 22.h,
                                      color: controller
                                              .fullNameErrorIconColor ??
                                          (controller.fullNameFocusNode.hasFocus
                                              ? ColorManager.primary
                                              : ColorManager.borderColor2),
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
                                    borderSide:
                                        BorderSide(color: ColorManager.primary),
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
                                  hintText: LocaleKeys.write_full_name,
                                  validator: (String? fullName) =>
                                      controller.validateFullName(fullName),
                                ),
                                SizedBox(height: 20.h),
                                PrimaryTextField(
                                  cursorColor: ColorManager.primary,
                                  focusNode: controller.emailFocusNode,
                                  isRequired: true,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    size: 25,
                                    color: controller.emailErrorIconColor ??
                                        (controller.emailFocusNode.hasFocus
                                            ? ColorManager.primary
                                            : ColorManager.borderColor2),
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  controller: controller.emailController,
                                  title: LocaleKeys.email.tr,
                                  hintText: LocaleKeys.enter_email.tr,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: ColorManager.borderColor2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide:
                                        BorderSide(color: ColorManager.primary),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide:
                                        BorderSide(color: ColorManager.red),
                                  ),
                                  borderSide: BorderSide(
                                    color: controller.emailFocusNode.hasFocus
                                        ? ColorManager.primary
                                        : ColorManager.borderColor2,
                                  ),
                                  fontSize: 14.5,
                                  validator: (String? email) =>
                                      controller.validateEmail(email),
                                ),
                                Visibility(
                                  visible: !controller.isEmailConfirmed,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20.h),
                                      PrimaryButton(
                                        onPressed: () async {
                                          await controller.sendOTPEmail();
                                        },
                                        title: LocaleKeys.verify_email.tr,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                PrimaryTextField(
                                  fontSize: 14,
                                  readOnly: true,
                                  ifReadOnlyTextColor: ColorManager.fontColor7,
                                  controller: controller.dateOfBirthController,
                                  title: LocaleKeys.date_of_birth,
                                  borderRadius: BorderRadius.circular(14),
                                  focusNode: controller.dateOfBirthFocusNode,
                                  titleFontWeight: FontWeightManager.softLight,
                                  onTap: () async {
                                    DateTime maxdate = DateTime(
                                      DateTime.now().year - 18,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                    );
                                    await Get.bottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      DateOfBirthBottomSheetContent(
                                        maxdate: maxdate,
                                        onSelectionChanged:
                                            (DateRangePickerSelectionChangedArgs
                                                dateRangePickerSelectionChangedArgs) {
                                          controller.changeDate(
                                              dateRangePickerSelectionChangedArgs);
                                        },
                                        dateOfBirth: controller.dateOfBirth,
                                        dateOfBirthRangeController: controller
                                            .dateOfBirthRangeController,
                                      ),
                                      backgroundColor: ColorManager.white,
                                    );
                                  },
                                  suffixIcon: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 14.w),
                                    child: SvgPicture.asset(
                                      ImagesManager.calendarIcon,
                                      width: 22.w,
                                      height: 22.h,
                                      color: controller
                                              .dateOfBirthIconErrorColor ??
                                          (controller
                                                  .dateOfBirthFocusNode.hasFocus
                                              ? (controller
                                                      .dateOfBirthIconErrorColor ??
                                                  ColorManager.primary)
                                              : ColorManager.primaryLight),
                                    ),
                                  ),
                                  suffixIconConstraints: BoxConstraints(
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
                                    borderSide:
                                        BorderSide(color: ColorManager.primary),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide:
                                        BorderSide(color: ColorManager.red),
                                  ),
                                  borderSide: BorderSide(
                                    color: ColorManager.primary,
                                  ),
                                  hintText: LocaleKeys.choose_date_of_birth,
                                  validator: (String? dateOfBirth) => controller
                                      .validateDateOfBirth(dateOfBirth),
                                ),
                                IntlPhoneNumberTextField(
                                  isRequired: true,
                                  controller: controller.phoneController,
                                  focusNode: controller.phoneFocusNode,
                                  onCountryChanged: (Country country) {
                                    controller.changeCountry(country);
                                  },
                                  initialValue: controller.dialCode ?? "+970",
                                  initialCountryCode:
                                      controller.countryCode ?? "PS",
                                  onChanged: (PhoneNumber phoneNumber) =>
                                      controller.changePhoneNumber(phoneNumber),
                                ),
                                Visibility(
                                  visible: !controller.isPhoneConfirmed,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20.h),
                                      PrimaryButton(
                                        onPressed: () async {
                                          await controller.sendOTPPhoneNumber();
                                        },
                                        title:
                                            LocaleKeys.verify_phone_number.tr,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                // Row(
                                //   children: [
                                //     PrimaryText(
                                //       "${LocaleKeys.gender.tr} : ",
                                //       color: ColorManager.fontColor,
                                //       fontWeight: FontWeightManager.light,
                                //       fontSize: 14,
                                //     ),
                                //     SizedBox(width: 10.w),
                                //     PrimaryText(
                                //       controller.gender == 0
                                //           ? LocaleKeys.male.tr
                                //           : LocaleKeys.female.tr,
                                //       color: ColorManager.primary,
                                //       fontWeight: FontWeightManager.light,
                                //       fontSize: 14,
                                //     ),
                                //   ],
                                // ),
                                Visibility(
                                  visible: true,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          PrimaryText(
                                            LocaleKeys.gender.tr,
                                            color: ColorManager.fontColor,
                                            fontWeight: FontWeightManager.light,
                                            fontSize: 14,
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
                                      SizedBox(width: 38.w),
                                      Row(
                                        children: List.generate(2, (int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.changeGender(index);
                                            },
                                            child: Container(
                                              width: 60.w,
                                              height: 32.h,
                                              margin: EdgeInsets.only(
                                                right: index == 0 ? 0 : 10.w,
                                              ),
                                              decoration: BoxDecoration(
                                                color: controller.gender ==
                                                        index
                                                    ? ColorManager.primary
                                                    : ColorManager.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border:
                                                    controller.gender != index
                                                        ? Border.all(
                                                            color: ColorManager
                                                                .primary,
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
                                                  color:
                                                      controller.gender == index
                                                          ? ColorManager.white
                                                          : ColorManager
                                                              .borderColor,
                                                  fontWeight:
                                                      FontWeightManager.light,
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
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: PrimaryButton(
                        title: LocaleKeys.save,
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            if (await checkInternetConnection(timeout: 5)) {
                              await controller.updateProfile();
                            } else {
                              await Get.toNamed(Routes.CONNECTION_FAILED);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
