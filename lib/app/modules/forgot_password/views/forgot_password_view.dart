import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/routes/app_pages.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: LocaleKeys.forgot_password,
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
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: GetBuilder<ForgotPasswordController>(
              builder: (ForgotPasswordController controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                            ImagesManager.forgotPassword,
                          ),
                          SizedBox(height: 55.h),
                          PrimaryTextField(
                            isRequired: true,
                            cursorColor: ColorManager.primary,
                            focusNode: controller.emailFocusNode,
                            textDirection: TextDirection.rtl,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 25,
                              color: controller.emailFocusNode.hasFocus
                                  ? controller.emailErrorIconColor ??
                                      ColorManager.primary
                                  : ColorManager.borderColor2,
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
                            fontSize: 14.5.sp,
                            validator: (String? email) =>
                                controller.validateEmail(email),
                          ),
                          SizedBox(height: 40.h),
                          PrimaryButton(
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                if (await checkInternetConnection(timeout: 5)) {
                                  await controller.sendPasswordResetCode();
                                } else {
                                  await Get.toNamed(Routes.CONNECTION_FAILED);
                                }
                              }
                            },
                            fontSize: 15.sp,
                            title: LocaleKeys.restore,
                          ),
                        ],
                      ),
                    ),
                  ),
                  KeyboardVisibilityBuilder(
                      builder: (BuildContext context, bool isKeyboardVisibile) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      height: isKeyboardVisibile ? Get.height * 0.25 : 0,
                    );
                  }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
