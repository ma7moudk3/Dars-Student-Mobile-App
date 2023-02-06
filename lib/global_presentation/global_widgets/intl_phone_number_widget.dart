import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../app/constants/exports.dart';
import '../../generated/locales.g.dart';

class IntlPhoneNumberTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(PhoneNumber)? onChanged;
  const IntlPhoneNumberTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: ColorManager.fontColor,
      fontSize: (14).sp,
      fontWeight: FontWeightManager.softLight,
      fontFamily: FontConstants.fontFamily,
    );
    var palestineValue = "+970";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        PrimaryText(LocaleKeys.phone_number),
        SizedBox(height: 5.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IntlPhoneField(
            initialValue: palestineValue,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
              LengthLimitingTextInputFormatter(9)
            ],
            onChanged: onChanged,
            countries: const ['PS', 'IL'],
            invalidNumberMessage: LocaleKeys.invalid_phone_number.tr,
            initialCountryCode: 'PS',
            dropdownTextStyle: textStyle,
            onCountryChanged: (country) {
              log(country.dialCode.toString());
            },
            dropdownIcon: Icon(
              Icons.arrow_drop_down,
              color: ColorManager.primary,
            ),
            focusNode: focusNode,
            cursorColor: ColorManager.primary,
            pickerDialogStyle: PickerDialogStyle(
              searchFieldInputDecoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: ColorManager.borderColor2),
                ),
                counterStyle: textStyle,
                border: OutlineInputBorder(
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
              ),
              backgroundColor: ColorManager.white,
              countryCodeStyle: textStyle,
              countryNameStyle: textStyle,
            ),
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              hintMaxLines: null,
              counterText: "",
              // hintText:  "(59 | 56) XXXXXXX",
              hintText: LocaleKeys.enter_phone_number.tr,
              hintStyle: TextStyle(
                color: ColorManager.borderColor2,
                fontSize: (14).sp,
                fontWeight: FontWeightManager.softLight,
                fontFamily: FontConstants.fontFamily,
              ),
              errorStyle: TextStyle(
                color: ColorManager.red,
                fontSize: (11).sp,
                fontWeight: FontWeightManager.softLight,
                fontFamily: FontConstants.fontFamily,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.borderColor2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.red),
              ),
              labelStyle: TextStyle(
                color: ColorManager.borderColor2,
                fontSize: (14).sp,
                fontWeight: FontWeightManager.softLight,
                fontFamily: FontConstants.fontFamily,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.primary),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
