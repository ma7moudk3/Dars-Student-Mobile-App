import 'package:hessa_student/app/modules/hessa_details/controllers/hessa_details_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class CancelHessaBottomSheetContent extends GetView<HessaDetailsController> {
  const CancelHessaBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
                height: (Get.height * 0.57).h,
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
                child: GetBuilder<HessaDetailsController>(
                    builder: (HessaDetailsController controller) {
                  return Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          ImagesManager.cancelHessaIcon,
                          width: 122.w,
                          height: 122.h,
                        ),
                        SizedBox(height: 10.h),
                        PrimaryText(
                          LocaleKeys.confirm_canceling_hessa,
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.light,
                        ),
                        SizedBox(height: 5.h),
                        PrimaryText(
                          LocaleKeys
                              .to_help_you_please_enter_canceling_hessa_reason,
                          fontSize: 14.sp,
                          fontWeight: FontWeightManager.light,
                          color: ColorManager.fontColor7,
                        ),
                        SizedBox(height: 20.h),
                        PrimaryTextField(
                          fontSize: 14.sp,
                          multiLines: true,
                          maxLines: 6,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                          controller: controller.cancelReasonController,
                          title: "",
                          borderRadius: BorderRadius.circular(14),
                          titleFontWeight: FontWeightManager.softLight,
                          onTap: () async {},
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
                            color: ColorManager.primary,
                          ),
                          hintText: LocaleKeys.canceling_hessa_reason,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryButton(
                              width: 160.w,
                              color: ColorManager.red,
                              borderSide: BorderSide.none,
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.clearData();

                                  Get.back(); // currently
                                  // await controller.cancelHessa();
                                }
                              },
                              title: LocaleKeys.cofirm_canceling.tr,
                            ),
                            PrimaryButton(
                              width: 160.w,
                              color: ColorManager.fontColor6,
                              fontColor: ColorManager.grey5,
                              borderSide: BorderSide.none,
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.clearData();
                                  Get.back(); // currently
                                  // await controller.cancelHessa();
                                }
                              },
                              title: LocaleKeys.back.tr,
                            ),
                          ],
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
