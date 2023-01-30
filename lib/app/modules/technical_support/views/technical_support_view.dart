import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
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
      body: GetBuilder<TechnicalSupportController>(
          builder: (TechnicalSupportController controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  width: Get.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                            margin: EdgeInsets.symmetric(horizontal: 14.w),
                            child: SvgPicture.asset(
                              ImagesManager.personIcon,
                              width: 22.w,
                              height: 22.h,
                              color: controller.fullNameIconErrorColor ??
                                  (controller.fullNameFocusNode.hasFocus
                                      ? (controller.fullNameIconErrorColor ??
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
                            borderSide:
                                BorderSide(color: ColorManager.borderColor2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          borderRadius: BorderRadius.circular(14),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: ColorManager.red),
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
                            margin: EdgeInsets.symmetric(horizontal: 14.w),
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
                            borderSide:
                                BorderSide(color: ColorManager.borderColor2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          borderRadius: BorderRadius.circular(14),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: ColorManager.red),
                          ),
                          borderSide: BorderSide(
                            color: ColorManager.primary,
                          ),
                          hintText: LocaleKeys.enter_email,
                          validator: (String? email) =>
                              controller.validateEmail(email),
                        ),
                        SizedBox(height: 20.h),
                        PrimaryTextField(
                          fontSize: 14.sp,
                          multiLines: true,
                          maxLines: 8,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                          controller: controller.messageController,
                          title: LocaleKeys.message_content,
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
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                child: PrimaryButton(
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      // await controller.orderHessa();
                    }
                  },
                  title: LocaleKeys.submit_form,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
