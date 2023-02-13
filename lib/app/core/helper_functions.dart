import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo_implement.dart';
import 'package:hessa_student/app/modules/verify_account/data/repos/verify_account_repo.dart';
import 'package:intl/intl.dart';

import '../../generated/locales.g.dart';
import '../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../global_presentation/global_widgets/loading.dart';
import '../constants/exports.dart';
import '../data/cache_helper.dart';
import '../data/network_helper/firebase_social_auth_helpers.dart';
import '../modules/login/data/models/current_user_info/current_user_info.dart';
import '../modules/login/data/models/current_user_profile_info/current_user_profile_info.dart';
import '../modules/login/widgets/welcome_back_dialog_content.dart';
import '../modules/verify_account/data/repos/verify_account_repo_implement.dart';
import '../routes/app_pages.dart';

final VerifyAccountRepo _verifyAccountRepo = VerifyAccountRepoImplement();
final LoginRepo _loginRepo = LoginRepoImplement();

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}

Future getCurrentUserInfo() async {
  // information like: isProfileCompleted, isExternalUser (google or facecbook), isEmailConfirmed, isPhoneNumberConfirmed
  await _loginRepo
      .getCurrentUserInfo()
      .then((CurrentUserInfo currentUserInfo) async {
    await CacheHelper.instance.cacheCurrentUserInfo(currentUserInfo.toJson());
  });
}

Future getCurrentUserProfileInfo() async {
  // information like: userName, emailAddress, paymentMethodName, phoneNumber, addresses
  await _loginRepo
      .getCurrentUserProfileInfo()
      .then((CurrentUserProfileInfo currentUserProfileInfo) async {
    await CacheHelper.instance
        .cacheCurrentUserProfileInfo(currentUserProfileInfo.toJson());
  });
}

String formatTimeOfDay(DateTime? dateAndTime) {
  final format = DateFormat.jm();
  return format.format(dateAndTime!);
}

bool detectLang({required String text}) {
  // String pattern = r'^(?:[a-zA-Z]|\P{L})+$';
  String pattern = r'^(?:[a-zA-Z.,;:!?]|\P{L})+$';
  RegExp regex = RegExp(pattern, unicode: true);
  return regex.hasMatch(text);
}

Future<bool> checkInternetConnection({required int timeout}) async {
  try {
    final result = await InternetAddress.lookup('www.google.com')
        .timeout(Duration(seconds: timeout));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    developer.log('not connected');
    print('not connected: $_');
  } on TimeoutException catch (_) {
    developer.log('timeout not connected');
    print('timeout not connected: $_');
    // CustomSnackBar.showCustomErrorSnackBar(
    //   title: LocaleKeys.something_went_wrong.tr,
    //   message: LocaleKeys.check_your_internet_connection.tr,
    // );
  }
  return false;
}

String? seperatePhoneAndDialCode({required String phoneWithDialCode}) {
  List<Map<String, String>> allowedCountries = [
    {"name": "Palestine", "dial_code": "+970", "code": "PS"},
    {"name": "Israel", "dial_code": "+972", "code": "IL"},
  ];
  Map<String, String> foundCountry = {};
  for (Map<String, String> country in allowedCountries) {
    String dialCode = country["dial_code"].toString();
    if (phoneWithDialCode.contains(dialCode)) {
      foundCountry = country;
      break;
    }
  }
  if (foundCountry.isNotEmpty) {
    String dialCode = phoneWithDialCode.substring(
      0,
      foundCountry["dial_code"]!.length,
    );
    String phoneNumber = phoneWithDialCode.substring(
      foundCountry["dial_code"]!.length,
    );
    return phoneNumber;
  }
  return null;
}

Divider moreDivider({
  double thickness = 1.3,
  double? height,
  double opacity = 0.1,
  double? endIndent,
  double? indent,
}) {
  return Divider(
    thickness: thickness,
    height: height,
    endIndent: endIndent,
    indent: indent,
    color: ColorManager.grey5.withOpacity(opacity),
  );
}

bool hasDateExpired(int month, int? year) {
  return year != null && isNotExpired(year, month);
}

bool isNotExpired(int year, int month) {
  // It has not expired if both the year and date has not passed
  return !hasYearPassed(year) && !hasMonthPassed(year, month);
}

List<int> getExpiryDate(String value) {
  var split = value.split(RegExp(r'(\/)'));
  return [int.parse(split[0]), int.parse(split[1])];
}

/// Convert the two-digit year to four-digit year if necessary
int convertYearTo4Digits(int year) {
  if (year < 100 && year >= 0) {
    var now = DateTime.now();
    String currentYear = now.year.toString();
    String prefix = currentYear.substring(0, currentYear.length - 2);
    year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
  }
  return year;
}

bool hasMonthPassed(int year, int month) {
  var now = DateTime.now();
  // The month has passed if:
  // 1. The year is in the past. In that case, we just assume that the month
  // has passed
  // 2. Card's month (plus another month) is less than current month.
  return hasYearPassed(year) ||
      convertYearTo4Digits(year) == now.year && (month < now.month + 1);
}

bool hasYearPassed(int year) {
  int fourDigitsYear = convertYearTo4Digits(year);
  var now = DateTime.now();
  // The year has passed if the year we are currently, is greater than card's
  // year
  return fourDigitsYear < now.year;
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? 'one_week_ago'.tr : 'last_week'.tr;
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} ${"days_ago".tr}';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? 'one_day_ago'.tr : 'yesterday'.tr;
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} ${"hours_ago".tr}';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? 'one_hour_ago'.tr : 'an_hour_ago'.tr;
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} ${"minutes_ago".tr}';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? 'one_minute_ago'.tr : 'a_minute_ago'.tr;
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} ${"seconds_ago".tr}';
    } else {
      return 'just_now'.tr;
    }
  }

  String timeAgoCustom() {
    Duration diff = DateTime.now().difference(this);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? LocaleKeys.year.tr : LocaleKeys.years.tr} ${LocaleKeys.ago.tr}";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? LocaleKeys.month.tr : LocaleKeys.months.tr} ${LocaleKeys.ago.tr}";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? LocaleKeys.week.tr : LocaleKeys.weeks.tr} ${LocaleKeys.ago.tr}";
    }
    if (diff.inDays > 0) return DateFormat.E().add_jm().format(this);
    if (diff.inHours > 0) {
      return "${LocaleKeys.today.tr} ${DateFormat('jm').format(this)}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? LocaleKeys.minute.tr : LocaleKeys.minutes.tr} ${LocaleKeys.ago.tr}";
    }
    return "just_now".tr;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future welcomeBack() async {
  await Future.delayed(const Duration(microseconds: 1200), () async {
    await Get.dialog(
      Container(
        color: ColorManager.black.withOpacity(0.1),
        height: 140.h,
        width: 140.w,
        child: Center(
          child: Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 18.w),
            child: const WelcomeBackDialogContent(),
          ),
        ),
      ),
    );
  });
}

Future _clearAllCaches() async {
  await Future.wait([
    CacheHelper.instance.setAccessToken(""),
    CacheHelper.instance.setRefreshToken(""),
    CacheHelper.instance.setEncryptedToken(""),
    CacheHelper.instance.setFcmToken(""),
    CacheHelper.instance.setUserProfilePicture(""),
    FirebaseMessaging.instance.deleteToken(),
    CacheHelper.instance.cacheCurrentUserInfo({}),
    CacheHelper.instance.cacheCurrentUserProfileInfo({}),
    CacheHelper.instance.setAuthed(false),
    CacheHelper.instance.setIsEmailConfirmed(false),
    CacheHelper.instance.setIsPhoneConfirmed(false),
  ]);
}

Future logout() async {
  showLoadingDialog();
  if (await checkInternetConnection(timeout: 10)) {
    await _verifyAccountRepo.logout().then((int statusCode) async {
      if (statusCode == 200) {
        await _clearAllCaches();
        await GoogleSignInHelper.googleLogout();
        // await AppleSignInHelper.appleLogout();
        // await FacebookSignInHelper.facebookLogout().then((value) {
        //   if (Get.isDialogOpen!) {
        //     Get.back();
        //   }
        // });
        if (Get.isDialogOpen!) {
          Get.back();
        }
        await Get.offAllNamed(Routes.LOGIN_OR_SIGN_UP, arguments: {
          "isFromOnboarding": false,
        });
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
          title: LocaleKeys.error.tr,
          message: LocaleKeys.something_went_wrong.tr,
        );
      }
    });
  } else {
    await Get.toNamed(Routes.CONNECTION_FAILED);
  }
}
