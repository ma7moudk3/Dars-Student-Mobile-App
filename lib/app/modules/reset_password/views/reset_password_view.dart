import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: LocaleKeys.reset_password.tr,
        leading: GestureDetector(
          onTap: () {
            Get.back();
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
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<ResetPasswordController>(
              builder: (ResetPasswordController controller) {
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
                          SvgPicture.asset(ImagesManager.lockPassword),
                          SizedBox(height: 50.h),
                          PasswordTextField(
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: ColorManager.red),
                            ),
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
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: controller.passwordFocusNode.hasFocus
                                  ? controller.passwordErrorIconColor ??
                                      ColorManager.primary
                                  : ColorManager.grey,
                              size: 23.w,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: controller.passwordFocusNode.hasFocus
                                  ? ColorManager.primary
                                  : ColorManager.borderColor2,
                            ),
                            cursorColor: ColorManager.primary,
                            focusNode: controller.passwordFocusNode,
                            controller: controller.passwordController,
                            title: LocaleKeys.new_password.tr,
                            hintText: LocaleKeys.enter_new_password.tr,
                            validator: (String? password) =>
                                controller.validatePassword(password),
                          ),
                          SizedBox(height: 26.h),
                          PasswordTextField(
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: ColorManager.red),
                            ),
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
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: controller
                                      .confirmPasswordFocusNode.hasFocus
                                  ? controller.confirmPasswordErrorIconColor ??
                                      ColorManager.primary
                                  : ColorManager.grey,
                              size: 23.w,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color:
                                  controller.confirmPasswordFocusNode.hasFocus
                                      ? ColorManager.primary
                                      : ColorManager.borderColor2,
                            ),
                            cursorColor: ColorManager.primary,
                            focusNode: controller.confirmPasswordFocusNode,
                            controller: controller.confirmPasswordController,
                            title: LocaleKeys.confirm_password.tr,
                            hintText: LocaleKeys.enter_confirmation_password.tr,
                            validator: (String? confirmPassword) => controller
                                .validateConfirmPassword(confirmPassword),
                          ),
                          SizedBox(height: 40.h),
                          PrimaryButton(
                            onPressed: () async {
                              if (controller.formKey.currentState!
                                  .validate()) {}
                            },
                            borderRadius: BorderRadius.circular(15.h),
                            title: LocaleKeys.restore.tr,
                            fontSize: 14,
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
                      height: isKeyboardVisibile ? Get.height * 0.3 : 0,
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
