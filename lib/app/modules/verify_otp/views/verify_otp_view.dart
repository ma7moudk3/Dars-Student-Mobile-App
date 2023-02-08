import 'package:pinput/pinput.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/confirm_back_dialog_content.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyOtpController());
    PinTheme defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: ColorManager.primary,
        fontFamily: FontConstants.fontFamily,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorManager.primary,
            width: 2,
          ),
        ),
      ),
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 2.h,
          decoration: BoxDecoration(
            color: ColorManager.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

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
          title: LocaleKeys.otp,
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
              size: 20.sp,
            ),
          ),
          action: const SizedBox.shrink(),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: GetBuilder<VerifyOtpController>(
                builder: (VerifyOtpController controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Form(
                      key: controller.formKey,
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                            vertical: 40.h, horizontal: 16.w),
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
                            SvgPicture.asset(
                              ImagesManager.otp,
                              height: 160.h,
                              width: 160.w,
                            ),
                            SizedBox(height: 45.h),
                            Column(
                              children: [
                                PrimaryText(
                                  (controller.phoneNumber != null &&
                                          controller.phoneNumber!.isNotEmpty)
                                      ? LocaleKeys
                                          .the_verification_code_has_been_sent_to_the_phone_number
                                          .tr
                                      : (controller.email != null &&
                                              controller.email!.isNotEmpty)
                                          ? LocaleKeys
                                              .the_verification_code_has_been_sent_to_the_email
                                              .tr
                                          : "No Data",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeightManager.softLight,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.h),
                                PrimaryText(
                                  (controller.phoneNumber != null &&
                                          controller.phoneNumber!.isNotEmpty)
                                      ? controller.phoneNumber!
                                      : (controller.email != null &&
                                              controller.email!.isNotEmpty)
                                          ? controller.email!
                                          : "No Data",
                                  fontSize: 17.sp,
                                  textDirection: TextDirection.ltr,
                                  fontWeight: FontWeightManager.light,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(height: 38.h),
                            Column(
                              children: [
                                PrimaryText(
                                  LocaleKeys
                                      .enter_the_verification_code_here.tr,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeightManager.light,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15.h),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Pinput(
                                    controller: controller.pinController,
                                    focusNode: controller.pinFocusNode,
                                    defaultPinTheme: defaultPinTheme,
                                    pinAnimationType: PinAnimationType.slide,
                                    length: 6,
                                    // showCursor: true,
                                    // cursor: cursor,
                                    // autofocus: true,
                                    listenForMultipleSmsOnAndroid: true,
                                    onClipboardFound: (value) {
                                      String pattern = r'^[0-9]+$';
                                      RegExp regExp = RegExp(pattern);
                                      if (value.length == 6 &&
                                          regExp.hasMatch(value)) {
                                        controller.pinController.text = value;
                                      }
                                    },
                                    androidSmsAutofillMethod:
                                        AndroidSmsAutofillMethod
                                            .smsUserConsentApi,
                                    pinputAutovalidateMode:
                                        PinputAutovalidateMode.onSubmit,
                                    errorTextStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: ColorManager.red,
                                      fontFamily: FontConstants.fontFamily,
                                    ),
                                    errorBuilder: (String? error, String pin) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 10.h),
                                          PrimaryText(
                                            error ?? "",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeightManager.light,
                                            textAlign: TextAlign.start,
                                            color: ColorManager.red,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      );
                                    },
                                    validator: (String? value) =>
                                        controller.validatePIN(value),
                                    // obscureText: true,
                                    // obscuringCharacter: "*",
                                    // obscuringWidget: SizedBox(
                                    //   width: 56.w,
                                    //   height: 56.h,
                                    //   child: Center(
                                    //     child: Icon(
                                    //       Icons.lock,
                                    //       color: ColorManager.primary,
                                    //     ),
                                    //   ),
                                    // ),
                                    onCompleted: (String value) async {
                                      await controller.verifyOTP();
                                    },
                                    onTapOutside: (PointerDownEvent event) {
                                      controller.pinFocusNode.unfocus();
                                    },
                                    closeKeyboardWhenCompleted: true,
                                    preFilledWidget: preFilledWidget,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 60.h),
                            if (controller.start != 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PrimaryText(
                                    "${LocaleKeys.resend_code_after.tr}:",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeightManager.light,
                                    color: ColorManager.fontColor7,
                                  ),
                                  SizedBox(width: 5.w),
                                  PrimaryText(
                                    controller.start.toString(),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeightManager.light,
                                    color: ColorManager.fontColor7,
                                  ),
                                ],
                              )
                            else
                              GestureDetector(
                                onTap: () async {
                                  await controller.resendOTP().then((value) {
                                    controller.pinController.clear();
                                  });
                                },
                                child: PrimaryText(
                                  LocaleKeys.resend_code.tr,
                                  fontSize: 14.sp,
                                  textDecoration: TextDecoration.underline,
                                  decorationColor: ColorManager.accent,
                                  color: ColorManager.accent,
                                ),
                              ),
                            SizedBox(height: 15.h),
                            PrimaryButton(
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  await controller.verifyOTP();
                                }
                              },
                              borderRadius: BorderRadius.circular(15.h),
                              title: LocaleKeys.check_pin.tr,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
