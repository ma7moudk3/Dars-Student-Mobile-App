import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_widget.dart';
import '../../../constants/exports.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.personal_profile,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.fontColor,
            size: 20,
          ),
        ),
        action: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {},
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: ColorManager.primary,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: ColorManager.primary,
                size: 16,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<EditProfileController>(
              builder: (EditProfileController controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                            child: Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: controller.image != null
                                      ? FileImage(controller.image!) as ImageProvider
                                      : AssetImage(ImagesManager.avatar),
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
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryTextField(
                                fontSize: 14.sp,
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
                                    color: controller.fullNameErrorIconColor ??
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
                                fontSize: 14.5.sp,
                                validator: (String? email) =>
                                    controller.validateEmail(email),
                              ),
                              SizedBox(height: 13.h),
                              IntlPhoneNumberTextField(
                                controller: controller.phoneController,
                                focusNode: controller.phoneFocusNode,
                                onChanged: (PhoneNumber phoneNumber) =>
                                    controller.changePhoneNumber(phoneNumber),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  PrimaryText(
                                    LocaleKeys.gender,
                                    color: ColorManager.fontColor,
                                    fontWeight: FontWeightManager.light,
                                    fontSize: 14.sp,
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
                                            color: controller.gender == index
                                                ? ColorManager.primary
                                                : ColorManager.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: controller.gender != index
                                                ? Border.all(
                                                    color: ColorManager.primary,
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
                                              color: controller.gender == index
                                                  ? ColorManager.white
                                                  : ColorManager.borderColor,
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 36.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: PrimaryButton(
                      title: LocaleKeys.save,
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {}
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
