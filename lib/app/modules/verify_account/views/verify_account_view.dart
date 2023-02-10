import 'package:hessa_student/app/constants/exports.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_widget.dart';
import '../../../core/helper_functions.dart';
import '../controllers/verify_account_controller.dart';

class VerifyAccountView extends GetView<VerifyAccountController> {
  const VerifyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: LocaleKeys.verify_account.tr,
        leading: const SizedBox.shrink(),
        action: const SizedBox.shrink(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GetX<VerifyAccountController>(
            builder: (VerifyAccountController controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImagesManager.hessaLogo,
                width: 120.w,
                height: 120.h,
              ),
              SizedBox(height: 20.h),
              Visibility(
                visible: !controller.isEmailConfirmed.value,
                child: Form(
                  key: controller.emailForm,
                  child: Column(
                    children: [
                      PrimaryTextField(
                        cursorColor: ColorManager.primary,
                        focusNode: controller.emailFocusNode,
                        fontSize: 14.sp,
                        // readOnly: true,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          size: 25,
                          color: ColorManager.borderColor2,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        controller: controller.emailController,
                        title: LocaleKeys.email.tr,
                        hintText: LocaleKeys.enter_email.tr,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide:
                              BorderSide(color: ColorManager.borderColor2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: ColorManager.primary),
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
                      SizedBox(height: 20.h),
                      PrimaryButton(
                        onPressed: () async {
                          await controller.sendOTPEmail();
                        },
                        title: LocaleKeys.verify_email.tr,
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !controller.isPhoneNumberConfirmed.value &&
                    controller.phoneNumber.completeNumber.isPhoneNumber,
                child: Form(
                  key: controller.phoneForm,
                  child: Column(
                    children: [
                      IntlPhoneNumberTextField(
                        controller: controller.phoneNumberController,
                        focusNode: controller.phoneNumberFocusNode,
                        validator: (PhoneNumber? phoneNumber) async =>
                            controller.validatePhoneNumber(phoneNumber != null
                                ? phoneNumber.completeNumber
                                : ""),
                        onChanged: (PhoneNumber number) =>
                            controller.changePhoneNumber(number),
                        onCountryChanged: (Country country) =>
                            controller.changeCountry(country),
                        initialValue: controller.dialCode ?? "+970",
                        initialCountryCode: controller.countryCode ?? "PS",
                      ),
                      SizedBox(height: 20.h),
                      PrimaryButton(
                        onPressed: () async {
                          if (controller.phoneForm.currentState!.validate()) {
                            await controller.sendOTPPhoneNumber();
                          }
                        },
                        title: LocaleKeys.verify_phone_number.tr,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              PrimaryButton(
                width: 150.w,
                onPressed: () async {
                  await logout();
                },
                title: LocaleKeys.logout.tr,
                borderSide: BorderSide.none,
                color: ColorManager.red,
              ),
            ],
          );
        }),
      ),
    );
  }
}
