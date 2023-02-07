import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/verify_account/data/models/generate_otp_code/generate_otp_code.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';

import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../../login/data/models/current_user_profile_info/current_user_profile_info.dart';
import '../data/repos/verify_account_repo.dart';
import '../data/repos/verify_account_repo_implement.dart';

class VerifyAccountController extends GetxController {
  late TextEditingController emailController, phoneNumberController;

  CurrentUserInfo currentUserInfo =
      CacheHelper.instance.getCachedCurrentUserInfo() ?? CurrentUserInfo();
  CurrentUserProfileInfo currentUserProfileInfo =
      CacheHelper.instance.getCachedCurrentUserProfileInfo() ??
          CurrentUserProfileInfo();
  RxBool isEmailConfirmed = false.obs;
  RxBool isPhoneNumberConfirmed = false.obs;
  FocusNode emailFocusNode = FocusNode(), phoneNumberFocusNode = FocusNode();
  final VerifyAccountRepo _verifyAccountRepo = VerifyAccountRepoImplement();
  GenerateOtpCode generateOtpCode = GenerateOtpCode();
  @override
  void onInit() {
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    initData();
    emailFocusNode.addListener(() => update());
    phoneNumberFocusNode.addListener(() => update());
    super.onInit();
  }

  void initData() {
    isEmailConfirmed.value = CacheHelper.instance.getIsEmailConfirmed();
    isPhoneNumberConfirmed.value = CacheHelper.instance.getIsPhoneConfirmed();
    if (currentUserInfo.result != null &&
        currentUserInfo.result!.emailAddress != null) {
      emailController.text = currentUserInfo.result!.emailAddress!;
    }
    if (currentUserProfileInfo.result != null &&
        currentUserProfileInfo.result!.phoneNumber != null) {
      phoneNumberController.text = currentUserProfileInfo.result!.phoneNumber!;
    }
  }

  Future sendOTPEmail() async {
    await sendOTP(email: emailController.text);
  }

  Future sendOTPPhoneNumber() async {
    await sendOTP(phoneNumber: phoneNumberController.text);
  }

  Future logout() async {
    showLoadingDialog();
    await _verifyAccountRepo.logout().then((int statusCode) async {
      if (statusCode == 200) {
        await CacheHelper.instance.setAccessToken("");
        await CacheHelper.instance.setRefreshToken("");
        await CacheHelper.instance.cacheCurrentUserInfo(null);
        await CacheHelper.instance.cacheCurrentUserProfileInfo(null);
        await CacheHelper.instance.setAuthed(false);
        await CacheHelper.instance.setIsEmailConfirmed(false);
        await CacheHelper.instance.setIsPhoneConfirmed(false);
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
  }

  Future sendOTP({String? phoneNumber, String? email}) async {
    showLoadingDialog();
    if (phoneNumber == null && email == null) {
      return;
    }
    if (phoneNumber != null) {
      generateOtpCode =
          await _verifyAccountRepo.sendOTP(phoneNumber: phoneNumber);
      if (generateOtpCode.result != null &&
          generateOtpCode.result!.numberOfSeconds != null) {
        await Get.toNamed(Routes.VERIFY_OTP, arguments: {
          "phoneNumber": phoneNumber,
        });
      }
    }
    if (email != null) {
      generateOtpCode = await _verifyAccountRepo.sendOTP(emailAddress: email);
      if (generateOtpCode.result != null &&
          generateOtpCode.result!.numberOfSeconds != null) {
        await Get.toNamed(Routes.VERIFY_OTP, arguments: {
          "email": email,
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneNumberController.dispose();
    emailFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
