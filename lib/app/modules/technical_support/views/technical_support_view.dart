import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/technical_support/data/models/urgency_type/result.dart';
import 'package:hessa_student/app/routes/app_pages.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/global_dropdown.dart';
import '../../../constants/exports.dart';
import '../controllers/technical_support_controller.dart';

class TechnicalSupportView extends GetView<TechnicalSupportController> {
  const TechnicalSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.title_technical_support,
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
        action: const SizedBox.shrink(),
      ),
      body: GetX<TechnicalSupportController>(
          builder: (TechnicalSupportController controller) {
        if (controller.isInternetConnected.value) {
          if (controller.isLoading.value == false) {
            return GetBuilder<TechnicalSupportController>(
                builder: (TechnicalSupportController controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 32.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryText(
                                LocaleKeys.contact_us,
                                fontSize: 16.sp,
                                color: ColorManager.primary,
                                fontWeight: FontWeightManager.softLight,
                              ),
                              SizedBox(height: 3.h),
                              PrimaryText(
                                LocaleKeys.do_not_hesitate_to_contact_us,
                                fontSize: 14.sp,
                                color: ColorManager.fontColor7,
                                fontWeight: FontWeightManager.softLight,
                              ),
                              SizedBox(height: 20.h),
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
                                    color: controller.fullNameIconErrorColor ??
                                        (controller.fullNameFocusNode.hasFocus
                                            ? (controller
                                                    .fullNameIconErrorColor ??
                                                ColorManager.primary)
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
                                fontSize: 14.sp,
                                controller: controller.emailController,
                                title: LocaleKeys.email,
                                focusNode: controller.emailFocusNode,
                                titleFontWeight: FontWeightManager.softLight,
                                onTap: () async {},
                                prefixIcon: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: SvgPicture.asset(
                                    ImagesManager.personIcon,
                                    width: 22.w,
                                    height: 22.h,
                                    color: controller.emailIconErrorColor ??
                                        (controller.emailFocusNode.hasFocus
                                            ? (controller.emailIconErrorColor ??
                                                ColorManager.primary)
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
                                hintText: LocaleKeys.enter_email,
                                validator: (String? email) =>
                                    controller.validateEmail(email),
                              ),
                              SizedBox(height: 20.h),
                              PrimaryText(
                                LocaleKeys.message_type,
                                fontSize: 14.sp,
                                fontWeight: FontWeightManager.softLight,
                                color: ColorManager.fontColor,
                              ),
                              SizedBox(height: 10.h),
                              PrimaryDropDown(
                                items: controller.urgencyType.result != null &&
                                        controller
                                            .urgencyType.result!.isNotEmpty
                                    ? (controller.urgencyType.result!.map(
                                        (Result result) =>
                                            result.displayName ?? "")).toList()
                                    : [""],
                                fontColor: ColorManager.fontColor5,
                                hint: LocaleKeys.message_type,
                                value: controller.urgencyType.result != null &&
                                        controller
                                            .urgencyType.result!.isNotEmpty
                                    ? (controller.urgencyType.result![0]
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
                                    controller.changeMessageType(value ?? ""),
                              ),
                              SizedBox(height: 20.h),
                              PrimaryTextField(
                                fontSize: 14.sp,
                                multiLines: true,
                                maxLines: 8,
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 20.0, 20.0, 10.0),
                                controller: controller.messageController,
                                title: LocaleKeys.message_content,
                                borderRadius: BorderRadius.circular(14),
                                titleFontWeight: FontWeightManager.softLight,
                                onTap: () async {},
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
                                hintText: LocaleKeys.how_can_we_help_you,
                                validator: (String? message) =>
                                    controller.validateMessage(message),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 16.h),
                      child: PrimaryButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.urgencyType.result != null &&
                                controller.selectedUrgency.id != null) {
                              if (await checkInternetConnection(timeout: 5)) {
                                await controller.sendMessage();
                              } else {
                                await Get.toNamed(Routes.CONNECTION_FAILED);
                              }
                            } else {
                              CustomSnackBar.showCustomErrorToast(
                                message: LocaleKeys
                                    .chech_that_you_choose_the_message_type.tr,
                              );
                            }
                          }
                        },
                        title: LocaleKeys.submit_form,
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(
                  LocaleKeys.check_your_internet_connection.tr,
                  fontSize: 18,
                  fontWeight: FontWeightManager.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: Get.height * 0.5,
                  child: Lottie.asset(
                    LottiesManager.noInernetConnection,
                    animate: true,
                  ),
                ),
                SizedBox(height: 10.h),
                PrimaryButton(
                  onPressed: () async {
                    await controller.checkInternet();
                  },
                  title: LocaleKeys.retry.tr,
                  width: Get.width * 0.5,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
