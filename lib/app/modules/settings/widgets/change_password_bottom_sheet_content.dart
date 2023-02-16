import 'package:hessa_student/app/modules/settings/controllers/settings_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/confirm_back_dialog_content.dart';
import '../../../constants/exports.dart';

class ChangePasswordBottomSheetContent extends GetView<SettingsController> {
  const ChangePasswordBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
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
      child: SafeArea(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 26.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorManager.borderColor3,
                      ),
                    ),
                  ),
                  Container(
                    height: (Get.height * 0.68).h,
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.white,
                    ),
                    child: GetBuilder<SettingsController>(
                        builder: (SettingsController controller) {
                      return Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PrimaryText(
                              LocaleKeys.change_password,
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.light,
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              children: [
                                PasswordTextField(
                                  isRequired: true,
                                  titleFontSize: 14.sp,
                                  titleSpacing: 15,
                                  titleFontWeight: FontWeightManager.softLight,
                                  focusNode: controller.oldPasswordFocusNode,
                                  controller: controller.oldPasswordController,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide:
                                        BorderSide(color: ColorManager.red),
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
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: controller
                                            .oldPasswordFocusNode.hasFocus
                                        ? controller
                                                .oldPasswordErrorIconColor ??
                                            ColorManager.primary
                                        : ColorManager.grey,
                                    size: 23.w,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color:
                                        controller.oldPasswordFocusNode.hasFocus
                                            ? ColorManager.primary
                                            : ColorManager.borderColor2,
                                  ),
                                  cursorColor: ColorManager.primary,
                                  title: LocaleKeys.old_password.tr,
                                  hintText: LocaleKeys.enter_old_password.tr,
                                  validator: (String? oldPassword) => controller
                                      .validateOldPassword(oldPassword),
                                ),
                                SizedBox(height: 20.h),
                                PasswordTextField(
                                  titleFontSize: 14.sp,
                                  isRequired: true,
                                  titleSpacing: 15,
                                  titleFontWeight: FontWeightManager.softLight,
                                  focusNode: controller.newPasswordFocusNode,
                                  controller: controller.newPasswordController,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide:
                                        BorderSide(color: ColorManager.red),
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
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: controller
                                            .newPasswordFocusNode.hasFocus
                                        ? controller
                                                .newPasswordErrorIconColor ??
                                            ColorManager.primary
                                        : ColorManager.grey,
                                    size: 23.w,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color:
                                        controller.newPasswordFocusNode.hasFocus
                                            ? ColorManager.primary
                                            : ColorManager.borderColor2,
                                  ),
                                  cursorColor: ColorManager.primary,
                                  title: LocaleKeys.new_password.tr,
                                  hintText: LocaleKeys.enter_new_password.tr,
                                  validator: (String? newPassword) => controller
                                      .validateNewPassword(newPassword),
                                ),
                                SizedBox(height: 20.h),
                                PasswordTextField(
                                  isRequired: true,
                                  titleFontSize: 14.sp,
                                  titleSpacing: 15,
                                  titleFontWeight: FontWeightManager.softLight,
                                  focusNode:
                                      controller.confirmPasswordFocusNode,
                                  controller:
                                      controller.confirmPasswordController,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide:
                                        BorderSide(color: ColorManager.red),
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
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: controller
                                            .confirmPasswordFocusNode.hasFocus
                                        ? controller
                                                .confirmPasswordErrorIconColor ??
                                            ColorManager.primary
                                        : ColorManager.grey,
                                    size: 23.w,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: controller
                                            .confirmPasswordFocusNode.hasFocus
                                        ? ColorManager.primary
                                        : ColorManager.borderColor2,
                                  ),
                                  cursorColor: ColorManager.primary,
                                  title: LocaleKeys.confirm_password.tr,
                                  hintText:
                                      LocaleKeys.enter_confirmation_password.tr,
                                  validator: (String? confirmPassword) =>
                                      controller.validateConfirmNewPassword(
                                          confirmPassword),
                                ),
                              ],
                            ),
                            const Spacer(),
                            PrimaryButton(
                              width: Get.width,
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  await controller.changePassword();
                                }
                              },
                              title: LocaleKeys.save.tr,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
