import 'package:flutter/services.dart';
import 'package:hessa_student/app/modules/wallet/widgets/visa_card_widget.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/card_month_input_formatter.dart';
import '../../../../global_presentation/global_features/card_number_formatter.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/add_payment_way_controller.dart';
import '../widgets/payment_ways_bottom_sheet_content.dart';

class AddPaymentWayView extends GetView<AddPaymentWayController> {
  const AddPaymentWayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.adding_new_payment_method,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 32.w,
            right: 32.w,
            bottom: 20.h,
          ),
          child: GetBuilder<AddPaymentWayController>(
              builder: (AddPaymentWayController controller) {
            return Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  VisaCardWidget(
                    isAddCard: true,
                    cardHolderName: controller.cardHolderNameController.text,
                    cardNumber: controller.cardNumberController.text,
                    expDate: controller.cardExpiryDateController.text,
                  ),
                  SizedBox(height: 30.h),
                  PrimaryTextField(
                    fontSize: 14,
                    readOnly: true,
                    textDirection: TextDirection.ltr,
                    controller: controller.cardTypeController,
                    prefixIcon: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: controller.cardTypeErrorIconColor ??
                          ColorManager.borderColor2,
                    ),
                    title: LocaleKeys.card_type,
                    borderRadius: BorderRadius.circular(14),
                    titleFontWeight: FontWeightManager.softLight,
                    onTap: () async {
                      await Get.bottomSheet(
                        backgroundColor: ColorManager.white,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        const PaymentWaysBottomSheetContent(),
                      );
                    },
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: ColorManager.borderColor2),
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
                    hintText: LocaleKeys.choose_card_type.tr,
                    validator: (String? value) =>
                        controller.validateCardType(value),
                  ),
                  SizedBox(height: 20.h),
                  PrimaryTextField(
                    fontSize: 14,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    textDirection: TextDirection.ltr,
                    controller: controller.cardHolderNameController,
                    title: LocaleKeys.card_holder.tr,
                    borderRadius: BorderRadius.circular(14),
                    titleFontWeight: FontWeightManager.softLight,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: ColorManager.borderColor2),
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
                    hintText: LocaleKeys.write_card_holder.tr,
                    validator: (String? value) =>
                        controller.validateCardHolderName(value),
                  ),
                  SizedBox(height: 20.h),
                  PrimaryTextField(
                    fontSize: 14,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19),
                      CardNumberFormatter(),
                    ],
                    controller: controller.cardNumberController,
                    title: LocaleKeys.card_number.tr,
                    textDirection: TextDirection.ltr,
                    borderRadius: BorderRadius.circular(14),
                    titleFontWeight: FontWeightManager.softLight,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    keyboardType: TextInputType.number,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: ColorManager.borderColor2),
                    ),
                    counterText: "",
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
                    hintText: "3384 4003 4885 2334",
                    maxLength: 19,
                    validator: (String? value) =>
                        controller.validateCardNumber(value),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: (Get.width * 0.37).w,
                        child: PrimaryTextField(
                          fontSize: 14.5,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            CardMonthInputFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                          focusNode: controller.expiryDateFocusNode,
                          controller: controller.cardExpiryDateController,
                          title: LocaleKeys.expiry_date.tr,
                          suffixIcon: Container(
                            margin: EdgeInsets.only(left: 10.w),
                            child: SvgPicture.asset(
                              ImagesManager.calendarIcon,
                              color: controller.expiryDateErrorIconColor,
                            ),
                          ),
                          suffixIconConstraints: BoxConstraints(
                            minWidth: 21.w,
                            minHeight: 21.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: ColorManager.borderColor2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: ColorManager.yellow),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: ColorManager.red),
                          ),
                          borderSide: BorderSide(
                            color: ColorManager.primary,
                          ),
                          // hintText: LocaleKeys.choose_expiry_date,
                          hintText: "MM/YY",
                          borderRadius: BorderRadius.circular(14),
                          titleFontWeight: FontWeightManager.softLight,
                          validator: (String? value) =>
                              controller.validateCardExpiryDate(value),
                        ),
                      ),
                      SizedBox(
                        width: (Get.width * 0.37).w,
                        child: PrimaryTextField(
                          fontSize: 14.5,
                          textDirection: TextDirection.ltr,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          keyboardType: TextInputType.number,
                          controller: controller.cardCvvController,
                          title: "CVV",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: ColorManager.borderColor2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: ColorManager.yellow),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.w),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: ColorManager.red),
                          ),
                          borderSide: BorderSide(
                            color: ColorManager.primary,
                          ),
                          hintText: "344",
                          borderRadius: BorderRadius.circular(14),
                          titleFontWeight: FontWeightManager.softLight,
                          validator: (String? value) =>
                              controller.validateCVV(value),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 38.h),
                  PrimaryButton(
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        // await controller.addPaymentWay();
                      }
                    },
                    title: LocaleKeys.add.tr,
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
