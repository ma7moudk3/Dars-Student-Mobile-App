
import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/order_details_controller.dart';
import 'you_cant_cancel_dars_dialog_content.dart';

class CancelDarsBottomSheetContent extends GetView<OrderDetailsController> {
  const CancelDarsBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
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
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.white,
                  ),
                  child: GetBuilder<OrderDetailsController>(
                      builder: (OrderDetailsController controller) {
                    return Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            ImagesManager.cancelDarsIcon,
                            width: 122.w,
                            height: 122.h,
                          ),
                          SizedBox(height: 10.h),
                          PrimaryText(
                            LocaleKeys.confirm_canceling_dars,
                            fontSize: 16,
                            fontWeight: FontWeightManager.light,
                          ),
                          SizedBox(height: 5.h),
                          PrimaryText(
                            LocaleKeys
                                .to_help_you_please_enter_canceling_dars_reason,
                            fontSize: 14,
                            fontWeight: FontWeightManager.light,
                            color: ColorManager.fontColor7,
                          ),
                          SizedBox(height: 20.h),
                          PrimaryTextField(
                            fontSize: 14,
                            multiLines: true,
                            maxLines: 6,
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 20.0, 20.0, 10.0),
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
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: ColorManager.red),
                            ),
                            borderSide: BorderSide(
                              color: ColorManager.primary,
                            ),
                            hintText: LocaleKeys.canceling_dars_reason,
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
                                    // await controller.cancelDars();
                                    // or currently you can't cancel dars dialog
                                    Get.back();
                                    await Get.dialog(
                                      Container(
                                        color:
                                            ColorManager.black.withOpacity(0.1),
                                        height: 230.h,
                                        width: 312.w,
                                        child: Center(
                                          child: Container(
                                            width: Get.width,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 18.w,
                                            ),
                                            child:
                                                const CannotCancelDarsDialogContent(),
                                          ),
                                        ),
                                      ),
                                      transitionCurve: Curves.easeInOutBack,
                                      barrierDismissible: true,
                                    );
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
                                    // await controller.cancelDars();
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
      ),
    );
  }
}
