import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';

import '../../app/constants/exports.dart';
import '../../generated/locales.g.dart';
import 'intl_phone_number_field/countries.dart';
import 'intl_phone_number_field/country_picker_dialog.dart';
import 'intl_phone_number_field/intl_phone_field.dart';
import 'intl_phone_number_field/phone_number.dart';

class IntlPhoneNumberTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(PhoneNumber)? onChanged;
  final void Function(Country)? onCountryChanged;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final bool readOnly, enabled, changeCountryEnabled;
  final Widget? prefix, suffix;
  final BorderRadius? borderRadius;
  final bool isRequired;
  final String initialValue, initialCountryCode;
  final EdgeInsetsGeometry? contentPadding;
  const IntlPhoneNumberTextField({
    Key? key,
    this.controller,
    this.initialValue = "+970",
    this.initialCountryCode = "PS",
    this.focusNode,
    this.prefix,
    this.suffix,
    this.borderRadius,
    this.validator,
    this.contentPadding,
    this.readOnly = false,
    this.enabled = true,
    this.isRequired = false,
    this.changeCountryEnabled = true,
    this.onChanged,
    this.onCountryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: ColorManager.fontColor,
      fontSize: (14).sp,
      fontWeight: FontWeightManager.softLight,
      fontFamily: FontConstants.fontFamily,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        isRequired
            ? Row(
                children: [
                  PrimaryText(LocaleKeys.phone_number),
                  SizedBox(width: 2.w),
                  PrimaryText(
                    "*",
                    fontSize: 16.sp,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.accent,
                  ),
                ],
              )
            : PrimaryText(LocaleKeys.phone_number),
        SizedBox(height: 5.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IntlPhoneField(
            validator: validator,
            readOnly: readOnly,
            suffix: suffix,
            prefix: prefix,
            enabled: enabled,
            changeCountryEnabled: changeCountryEnabled,
            style: textStyle,
            initialValue: initialValue,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
              LengthLimitingTextInputFormatter(9)
            ],
            onChanged: onChanged,
            countries: const ['PS', 'IL'],
            invalidNumberMessage: LocaleKeys.invalid_phone_number.tr,
            initialCountryCode: initialCountryCode,
            dropdownTextStyle: textStyle,
            onCountryChanged: onCountryChanged ??
                (Country country) {
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
                labelText : LocaleKeys.search.tr,
                counterStyle: textStyle,
                labelStyle: textStyle,
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
              enabled: !enabled,
              contentPadding: contentPadding ??
                  const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                borderRadius: borderRadius ?? BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.borderColor2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.borderColor2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.red),
              ),
              labelStyle: TextStyle(
                color: ColorManager.borderColor2,
                fontSize: (14).sp,
                fontWeight: FontWeightManager.softLight,
                fontFamily: FontConstants.fontFamily,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.primary),
              ),
              border: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
