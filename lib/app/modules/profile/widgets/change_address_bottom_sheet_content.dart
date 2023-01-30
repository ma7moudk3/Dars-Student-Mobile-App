import 'package:hessa_student/app/modules/profile/controllers/profile_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/global_dropdown.dart';
import '../../../constants/exports.dart';

class ChangeAddressBottomSheetContent extends GetView<ProfileController> {
  const ChangeAddressBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Wrap(
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
                height: (Get.height * 0.65).h,
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 16.h,
                  bottom: 16.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.white,
                ),
                child: GetBuilder<ProfileController>(
                    builder: (ProfileController controller) {
                  return Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryText(
                          LocaleKeys.change_address,
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.light,
                        ),
                        SizedBox(height: 25.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              LocaleKeys.city,
                              fontSize: 14.sp,
                              fontWeight: FontWeightManager.softLight,
                              color: ColorManager.fontColor,
                            ),
                            SizedBox(height: 12.h),
                            PrimaryDropDown(
                              items: [LocaleKeys.choose_city.tr],
                              hint: LocaleKeys.city,
                              value: LocaleKeys.choose_city.tr,
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
                              onChanged: (String? value) {},
                            ),
                            SizedBox(height: 12.h),
                            PrimaryTextField(
                              cursorColor: ColorManager.primary,
                              titleFontSize: 14.sp,
                              titleFontWeight: FontWeightManager.softLight,
                              focusNode: controller.areaFocusNode,
                              borderRadius: BorderRadius.circular(14),
                              controller: controller.areaController,
                              title: LocaleKeys.area.tr,
                              hintText: LocaleKeys.enter_area.tr,
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
                                color: controller.areaFocusNode.hasFocus
                                    ? ColorManager.primary
                                    : ColorManager.borderColor2,
                              ),
                              validator: (String? area) =>
                                  controller.validateArea(area),
                            ),
                            SizedBox(height: 12.h),
                            PrimaryTextField(
                              cursorColor: ColorManager.primary,
                              focusNode: controller.currentAddressFocusNode,
                              titleFontSize: 14.sp,
                              titleFontWeight: FontWeightManager.softLight,
                              borderRadius: BorderRadius.circular(14),
                              controller: controller.currentAddressController,
                              title: LocaleKeys.current_address.tr,
                              hintText: LocaleKeys.enter_current_address.tr,
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
                                color:
                                    controller.currentAddressFocusNode.hasFocus
                                        ? ColorManager.primary
                                        : ColorManager.borderColor2,
                              ),
                              validator: (String? currentAddress) => controller
                                  .validateCurrentAddress(currentAddress),
                            ),
                          ],
                        ),
                        const Spacer(),
                        PrimaryButton(
                          height: 50.h,
                          width: Get.width,
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              Get.back(); // currently
                              // await controller.changePassword();
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
    );
  }
}
