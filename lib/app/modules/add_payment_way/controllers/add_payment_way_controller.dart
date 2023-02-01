import 'package:hessa_student/app/constants/exports.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/helper_functions.dart';

class AddPaymentWayController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime cardExpiryDate = DateTime.now();
  late TextEditingController cardTypeController,
      cardHolderNameController,
      cardNumberController,
      cardExpiryDateController,
      cardCvvController;

  FocusNode expiryDateFocusNode = FocusNode();
  Color? expiryDateErrorIconColor, cardTypeErrorIconColor;

  @override
  void onInit() {
    cardTypeController = TextEditingController();
    cardHolderNameController = TextEditingController();
    cardNumberController = TextEditingController();
    cardExpiryDateController = TextEditingController();
    cardCvvController = TextEditingController();
    super.onInit();
  }

  String? validateCardExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      expiryDateErrorIconColor = Colors.red;
      update();
      return LocaleKeys.enter_card_expiry_date.tr;
    }
    int year;
    int month;
    // The value contains a forward slash if the month and year has been entered.
    if (value.contains(RegExp(r'(\/)'))) {
      var split = value.split(RegExp(r'(\/)'));
      // The value before the slash is the month while the value to right of it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      expiryDateErrorIconColor = Colors.red;
      update();
      return LocaleKeys.expiry_month_invalid.tr;
    }
    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid year should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      expiryDateErrorIconColor = Colors.red;
      update();
      return LocaleKeys.expiry_year_invalid.tr;
    }

    if (!hasDateExpired(month, year)) {
      expiryDateErrorIconColor = Colors.red;
      update();
      return LocaleKeys.card_has_expired.tr;
    }
    expiryDateErrorIconColor = null;
    update();
    return null;
  }

  String? validateCardType(String? cardType) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (cardType == null || cardType.isEmpty) {
      cardTypeErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_choose_card_type.tr;
    } else if (regExp.hasMatch(cardType)) {
      cardTypeErrorIconColor = Colors.red;
      update();
      return LocaleKeys.check_card_type.tr;
    }
    cardTypeErrorIconColor = null;
    update();
    return null;
  }

  String? validateCardHolderName(String? cardHolderName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (cardHolderName == null || cardHolderName.isEmpty) {
      return LocaleKeys.please_enter_card_holder_name.tr;
    } else if (!regExp.hasMatch(cardHolderName)) {
      if (!cardHolderName.contains(" ")) {
        return LocaleKeys.card_holder_name_should_have_space.tr;
      } else {
        return null;
      }
    } else if (regExp.hasMatch(cardHolderName)) {
      return LocaleKeys.check_card_holder_name.tr;
    }
    return null;
  }

  String? validateCardNumber(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) {
      return LocaleKeys.please_enter_card_number.tr;
    } else if (cardNumber.length < 19) {
      return LocaleKeys.card_number_should_be_19_digits.tr;
    }
    return null;
  }

  String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.please_enter_cvv.tr;
    }

    if (value.length < 3 || value.length > 4) {
      return LocaleKeys.cvv_is_invalid.tr;
    }
    return null;
  }

  @override
  void dispose() {
    cardTypeController.dispose();
    cardHolderNameController.dispose();
    cardNumberController.dispose();
    cardExpiryDateController.dispose();
    cardCvvController.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
