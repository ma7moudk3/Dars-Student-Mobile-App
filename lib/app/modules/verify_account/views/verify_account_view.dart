import 'dart:developer';

import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/global_presentation/global_widgets/custom_snack_bar.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_field/countries.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_field/phone_number.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_widget.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/verify_account_controller.dart';

class VerifyAccountView extends GetView<VerifyAccountController> {
  const VerifyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesManager.verificationBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: ColorManager.black.withOpacity(0.60),
          ),
        ),
        Scaffold(
          backgroundColor: ColorManager.transparent,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 16.w,
                  top: 75.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PrimaryText(
                        LocaleKeys.verification_of_the_account,
                        fontSize: 18.sp,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.white,
                      ),
                      SizedBox(height: 5.h),
                      PrimaryText(
                        LocaleKeys.confirm_your_mail_and_your_phone_number,
                        fontSize: 14.sp,
                        fontWeight: FontWeightManager.softLight,
                        color: ColorManager.white,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 55.h,
                  left: 18.w,
                  right: 18.w,
                  child: GetX<VerifyAccountController>(
                      builder: (VerifyAccountController controller) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 28.h),
                      width: 355.w,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            offset: Offset(0, 0),
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: controller.emailForm,
                            child: PrimaryTextField(
                              cursorColor: ColorManager.primary,
                              contentPadding: const EdgeInsets.fromLTRB(
                                5.0,
                                10.0,
                                5.0,
                                10.0,
                              ),
                              focusNode: controller.emailFocusNode,
                              fontSize: 14.sp,
                              readOnly: controller.isEmailConfirmed.value,
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      if (!controller.isEmailConfirmed.value &&
                                          controller
                                              .emailController.text.isEmail) {
                                        await controller.sendOTPEmail();
                                      } else if (!controller
                                          .emailController.text.isEmail) {
                                        CustomSnackBar.showCustomErrorSnackBar(
                                          title: LocaleKeys.data_entry_error.tr,
                                          message: LocaleKeys
                                              .please_enter_a_valid_email.tr,
                                        );
                                      } else if (controller
                                          .isEmailConfirmed.value) {
                                        CustomSnackBar.showCustomSnackBar(
                                          title: LocaleKeys.success.tr,
                                          message: LocaleKeys
                                              .email_already_verified.tr,
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            !controller.isEmailConfirmed.value
                                                ? ColorManager.primary
                                                : ColorManager.green,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(14),
                                          bottomRight: Radius.circular(14),
                                        ),
                                      ),
                                      height: 50.h,
                                      width: 50.w,
                                      child: !controller.isEmailConfirmed.value
                                          ? Center(
                                              child: PrimaryText(
                                                LocaleKeys.confirm.tr,
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    FontWeightManager.light,
                                                color: ColorManager.white,
                                              ),
                                            )
                                          : Center(
                                              child: Icon(
                                                Icons.check,
                                                color: ColorManager.white,
                                                size: 22,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  SvgPicture.asset(
                                    ImagesManager.envelopeIcon,
                                    height: 18.h,
                                    width: 18.w,
                                  ),
                                  SizedBox(width: 10.w),
                                ],
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
                                borderSide: BorderSide(color: ColorManager.red),
                              ),
                              borderSide: BorderSide(
                                color: controller.emailFocusNode.hasFocus
                                    ? ColorManager.primary
                                    : ColorManager.borderColor2,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Form(
                            key: controller.phoneForm,
                            child: IntlPhoneNumberTextField(
                              readOnly: controller.isPhoneNumberConfirmed.value,
                              changeCountryEnabled:
                                  !controller.isPhoneNumberConfirmed.value,
                              suffix: Row(
                                mainAxisSize: MainAxisSize.min,
                                textDirection: TextDirection.rtl,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      log("sendOTPPhoneNumber");
                                      if (!controller
                                              .isPhoneNumberConfirmed.value &&
                                          controller.isValidPhoneNumber) {
                                        await controller.sendOTPPhoneNumber();
                                      } else if (!controller
                                          .isValidPhoneNumber) {
                                        CustomSnackBar.showCustomErrorSnackBar(
                                          title: LocaleKeys.data_entry_error.tr,
                                          message: LocaleKeys
                                              .please_enter_a_valid_phone_number
                                              .tr,
                                        );
                                      } else if (controller
                                          .isPhoneNumberConfirmed.value) {
                                        CustomSnackBar.showCustomSnackBar(
                                          title: LocaleKeys.success.tr,
                                          message: LocaleKeys
                                              .phone_number_already_verified.tr,
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: !controller
                                                .isPhoneNumberConfirmed.value
                                            ? ColorManager.primary
                                            : ColorManager.green,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(14),
                                          bottomRight: Radius.circular(14),
                                        ),
                                      ),
                                      height: 50.h,
                                      width: 50.w,
                                      child: !controller
                                              .isPhoneNumberConfirmed.value
                                          ? Center(
                                              child: PrimaryText(
                                                LocaleKeys.confirm.tr,
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    FontWeightManager.light,
                                                color: ColorManager.white,
                                              ),
                                            )
                                          : Center(
                                              child: Icon(
                                                Icons.check,
                                                color: ColorManager.white,
                                                size: 22,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  SvgPicture.asset(
                                    ImagesManager.mobileIcon,
                                    height: 27.h,
                                    width: 27.w,
                                  ),
                                ],
                              ),
                              controller: controller.phoneNumberController,
                              focusNode: controller.phoneNumberFocusNode,
                              validator: (PhoneNumber? phoneNumber) async =>
                                  controller.validatePhoneNumber(
                                      phoneNumber != null
                                          ? phoneNumber.completeNumber
                                          : ""),
                              onChanged: (PhoneNumber number) =>
                                  controller.changePhoneNumber(number),
                              onCountryChanged: (Country country) =>
                                  controller.changeCountry(country),
                              initialValue: controller.dialCode ?? "+970",
                              initialCountryCode:
                                  controller.countryCode ?? "PS",
                            ),
                          ),
                          SizedBox(height: 40.h),
                          PrimaryButton(
                            width: Get.width.w,
                            onPressed: () async {
                              if (controller.isEmailConfirmed.value &&
                                  controller.isPhoneNumberConfirmed.value) {
                                await CacheHelper.instance
                                    .setIsWelcomeBack(true);
                                await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
                              } else if (!controller.isEmailConfirmed.value) {
                                CustomSnackBar.showCustomInfoSnackBar(
                                  title: LocaleKeys.note.tr,
                                  message: LocaleKeys
                                      .please_confirm_email_first_before_keep_going
                                      .tr,
                                );
                              } else if (!controller
                                  .isPhoneNumberConfirmed.value) {
                                CustomSnackBar.showCustomInfoSnackBar(
                                  title: LocaleKeys.note.tr,
                                  message: LocaleKeys
                                      .please_confirm_phone_number_first_before_keep_going
                                      .tr,
                                );
                              }
                            },
                            title: LocaleKeys.keep_going.tr,
                            borderSide: BorderSide.none,
                            fontSize: 15,
                            color: ColorManager.primary,
                          ),
                          SizedBox(height: 25.h),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async => await logout(),
                            child: PrimaryText(
                              LocaleKeys.logout,
                              color: ColorManager.red,
                              fontWeight: FontWeightManager.light,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
