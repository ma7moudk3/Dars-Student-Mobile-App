import 'dart:developer';
import 'dart:io';

import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_profile_info/current_user_profile_info.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_field/countries.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_field/phone_number.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../../login/data/repos/login_repo_implement.dart';
import '../../verify_account/data/models/generate_otp_code/generate_otp_code.dart';
import '../../verify_account/data/repos/verify_account_repo.dart';
import '../../verify_account/data/repos/verify_account_repo_implement.dart';
import '../data/repos/edit_profile_repo.dart';
import '../data/repos/edit_profile_repo_implement.dart';

class EditProfileController extends GetxController {
  late TextEditingController fullNameController,
      emailController,
      phoneController,
      dateOfBirthController;
  late DateRangePickerController dateOfBirthRangeController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime dateOfBirth = DateTime.now();
  FocusNode fullNameFocusNode = FocusNode(),
      emailFocusNode = FocusNode(),
      phoneFocusNode = FocusNode(),
      dateOfBirthFocusNode = FocusNode();
  Color? fullNameErrorIconColor, emailErrorIconColor, dateOfBirthIconErrorColor;
  PhoneNumber phoneNumber =
      PhoneNumber(countryISOCode: "", countryCode: "", number: "");
  String? dialCode, countryCode;
  int gender =
      0; // 0 male 1 female (starts from zero just for indexing) in the view, but 1 male, 2 female in the api
  Rx<File?> image = Rx<File?>(null);
  final EditProfileRepo _editProfileRepo = EditProfileRepoImplement();
  CurrentUserInfo currentUserInfo =
      CacheHelper.instance.getCachedCurrentUserInfo() ?? CurrentUserInfo();
  CurrentUserProfileInfo currentUserProfileInfo =
      CacheHelper.instance.getCachedCurrentUserProfileInfo() ??
          CurrentUserProfileInfo();
  final LoginRepo _loginRepo = LoginRepoImplement();
  bool isEmailChanged = false,
      isPhoneChanged = false,
      isEmailConfirmed = false,
      isPhoneConfirmed = false;
  GenerateOtpCode generateOtpCode = GenerateOtpCode();
  final VerifyAccountRepo _verifyAccountRepo = VerifyAccountRepoImplement();

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  String? validateDateOfBirth(String? dateOfBirth) {
    if (dateOfBirth != null && dateOfBirth.isNotEmpty) {
      // DateTime tempDateTime =
      //     DateFormat("dd MMMM yyyy", "ar_SA").parse(dateOfBirth);
      if (dateOfBirth.isEmpty) {
        dateOfBirthIconErrorColor = Colors.red;
        update();
        return LocaleKeys.please_enter_dob.tr;
        // } else if (!tempDateTime.isAtLeastYearsOld(18)) {
        //   dateOfBirthIconErrorColor = Colors.red;
        //   update();
        //   return LocaleKeys.check_dependent_dob.tr;
      } else {
        dateOfBirthIconErrorColor = null;
        update();
        return null;
      }
    } else {
      dateOfBirthIconErrorColor = Colors.red;
      update();
      return LocaleKeys.please_enter_dob.tr;
    }
  }

  void changeDate(DateRangePickerSelectionChangedArgs dateAndTime) {
    dateOfBirth = dateAndTime.value;
    dateOfBirthController.text =
        DateFormat("dd MMMM yyyy", "ar_SA").format(dateOfBirth);
    update();
  }

  void initData() {
    changeIsEmailAndPhoneConfirmed();
    fullNameController = TextEditingController(
        text: currentUserInfo.result != null
            ? ("${currentUserInfo.result!.name ?? ""} ${currentUserInfo.result!.surname ?? ""}")
            : "");
    fullNameFocusNode.addListener(() => update());
    emailController = TextEditingController(
      text: currentUserInfo.result != null
          ? currentUserInfo.result!.emailAddress ?? ""
          : "",
    );
    dateOfBirth = currentUserProfileInfo.result != null
        ? currentUserProfileInfo.result!.requester != null
            ? currentUserProfileInfo.result!.requester!.doB != null &&
                    currentUserProfileInfo.result!.requester!.doB!.isNotEmpty
                ? DateTime.parse(currentUserProfileInfo.result!.requester!.doB!)
                : DateTime.now()
            : DateTime.now()
        : DateTime.now();
    dateOfBirthController = TextEditingController(
      text: DateFormat("dd MMMM yyyy", "ar_SA").format(dateOfBirth),
    );
    dateOfBirthRangeController = DateRangePickerController();
    dateOfBirthRangeController.selectedDate = dateOfBirth;
    emailController.addListener(_onEmailChanged);
    emailFocusNode.addListener(() => update());
    dateOfBirthFocusNode.addListener(() => update());
    phoneController = TextEditingController();
    if (currentUserProfileInfo.result != null &&
        currentUserProfileInfo.result!.phoneNumber != null) {
      _separatePhoneAndDialCode(
          phoneWithDialCode: currentUserProfileInfo.result!.phoneNumber!);
    }
    gender = currentUserProfileInfo.result != null
        ? currentUserProfileInfo.result!.requester != null
            ? currentUserProfileInfo.result!.requester!.gender != null
                ? ((currentUserProfileInfo.result!.requester!.gender! - 1) >= 0)
                    ? (currentUserProfileInfo.result!.requester!.gender! - 1)
                    : 0
                : 0
            : 0
        : 0;
    phoneFocusNode.addListener(() => update());
    update();
  }

  bool isDataChanged() {
    bool isEmailChanged =
        emailController.text != currentUserProfileInfo.result!.emailAddress;
    isPhoneChanged = phoneNumber.completeNumber !=
        currentUserProfileInfo.result!.phoneNumber;
    // ~ doB could be inserted here later if needed + the gender ~
    return isEmailChanged ||
        isPhoneChanged ||
        image.value != null ||
        (fullNameController.text !=
            ("${currentUserInfo.result!.name ?? ""} ${currentUserInfo.result!.surname ?? ""}"));
  }

  void changeIsEmailAndPhoneConfirmed() {
    isEmailConfirmed = CacheHelper.instance.getIsEmailConfirmed();
    isPhoneConfirmed = CacheHelper.instance.getIsPhoneConfirmed();
    update();
  }

  void _onEmailChanged() {
    isEmailChanged = currentUserProfileInfo.result!.emailAddress != null &&
            emailController.text.isNotEmpty &&
            emailController.text.isEmail
        ? emailController.text != currentUserProfileInfo.result!.emailAddress!
        : false;
    update();
  }

  Future updateProfile() async {
    showLoadingDialog();
    await Future.wait([updateImage()]).then((List<dynamic> values) async {
      await updateProfileData().then((int statusCode) async {
        if (statusCode == 200) {
          await Future.wait([
            getCurrentUserInfo(),
            getCurrentUserProfileInfo(),
            _loginRepo.getCurrentUserProfilePicture()
          ]).then((value) async {
            if (Get.isDialogOpen!) {
              Get.back();
            }
            await Future.delayed(const Duration(milliseconds: 550))
                .then((value) async {
              CustomSnackBar.showCustomSnackBar(
                title: LocaleKeys.success.tr,
                message: LocaleKeys.profile_edited_succesfully.tr,
              );
              await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
            });
          });
        }
      });
    });
  }

  Future<int> updateProfileData() async {
    int statusCode = 500;
    if (currentUserProfileInfo.result != null &&
        currentUserProfileInfo.result!.requester != null) {
      statusCode = await _editProfileRepo.updateProfile(
        firstName: fullNameController.text.split(" ")[0],
        surname: fullNameController.text.split(" ").length > 1
            ? fullNameController.text.split(" ")[1]
            : "",
        id: currentUserProfileInfo.result!.requester!.userId ?? -1,
        email: emailController.text,
        dateOfBirth: dateOfBirth.toUtc().toString(),
        phoneNumber: phoneNumber.completeNumber,
        gender: gender + 1,
      );
    }
    return statusCode;
  }

  Future sendOTPEmail() async {
    if (emailController.text.isNotEmpty) {
      await _sendOTP(email: emailController.text);
    }
  }

  Future sendOTPPhoneNumber() async {
    if (phoneNumber.completeNumber.isNotEmpty) {
      await _sendOTP(
        phoneNumber: phoneNumber.completeNumber,
      );
    }
  }

  Future _sendOTP({String? phoneNumber, String? email}) async {
    showLoadingDialog();
    if (phoneNumber == null && email == null) {
      return;
    }
    if (phoneNumber != null) {
      generateOtpCode = await _verifyAccountRepo.sendOTP(
        phoneNumber: phoneNumber,
        isPhoneChanged: isPhoneChanged,
      );
      if (generateOtpCode.result != null &&
          generateOtpCode.result!.numberOfSeconds != null) {
        await Get.toNamed(Routes.VERIFY_OTP, arguments: {
          "phoneNumber": phoneNumber,
          "isEditProfile": true,
          "numberOfSeconds": generateOtpCode.result!.numberOfSeconds,
        });
      }
    }
    if (email != null) {
      generateOtpCode = await _verifyAccountRepo.sendOTP(
        emailAddress: email,
        isEmailChanged: isEmailChanged,
      );
      if (generateOtpCode.result != null &&
          generateOtpCode.result!.numberOfSeconds != null) {
        await Get.toNamed(Routes.VERIFY_OTP, arguments: {
          "email": email,
          "isEditProfile": true,
          "numberOfSeconds": generateOtpCode.result!.numberOfSeconds,
        });
      }
    }
  }

  Future getCurrentUserInfo() async {
    await _loginRepo
        .getCurrentUserInfo()
        .then((CurrentUserInfo currentUserInfo) async {
      await CacheHelper.instance.cacheCurrentUserInfo(currentUserInfo.toJson());
    });
    update();
  }

  Future getCurrentUserProfileInfo() async {
    await _loginRepo
        .getCurrentUserProfileInfo()
        .then((CurrentUserProfileInfo currentUserProfileInfo) async {
      await CacheHelper.instance
          .cacheCurrentUserProfileInfo(currentUserProfileInfo.toJson());
    });
    update();
  }

  void changeGender(int genderValue) {
    gender = genderValue;
    update();
  }

  Future pickImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      image.value = File(pickedImage.path);
    }
    update();
  }

  String? validateFullName(String? fullName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (fullName == null || fullName.isEmpty) {
      fullNameErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_fullname.tr;
    } else if (!regExp.hasMatch(fullName)) {
      if (!fullName.contains(" ")) {
        fullNameErrorIconColor = Colors.red;
        update();
        return LocaleKeys.should_have_space.tr;
      } else {
        fullNameErrorIconColor = null;
        update();
        return null;
      }
    } else if (regExp.hasMatch(fullName)) {
      fullNameErrorIconColor = Colors.red;
      update();
      return LocaleKeys.check_your_full_name.tr;
    } else {
      fullNameErrorIconColor = null;
    }
    update();
    return null;
  }

  void changeCountry(Country country) {
    phoneNumber.countryCode = "+${country.dialCode}";
    isPhoneChanged = currentUserProfileInfo.result!.phoneNumber != null &&
            phoneNumber.completeNumber.isPhoneNumber
        ? phoneNumber.completeNumber !=
            currentUserProfileInfo.result!.phoneNumber!
        : false;
    update();
  }

  void changePhoneNumber(PhoneNumber number) {
    phoneNumber = number;
    isPhoneChanged = currentUserProfileInfo.result!.phoneNumber != null &&
            phoneNumber.completeNumber.isPhoneNumber
        ? phoneNumber.completeNumber !=
            currentUserProfileInfo.result!.phoneNumber!
        : false;
    update();
  }

  void _separatePhoneAndDialCode({required String phoneWithDialCode}) {
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
      this.dialCode = dialCode;
      countryCode = foundCountry["code"];
      String phoneNumber = phoneWithDialCode.substring(
        foundCountry["dial_code"]!.length,
      );
      phoneController.text = phoneNumber;
      this.phoneNumber = PhoneNumber(
          countryISOCode: dialCode, countryCode: dialCode, number: phoneNumber);
    }
    update();
  }

  Future updateImage() async {
    if (image.value != null) {
      log("image is not null");
      await _editProfileRepo.updateProfilePicture(
        image: image.value!,
      );
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      emailErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_email.tr;
    } else if (email.isEmail == false) {
      emailErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_valid_email.tr;
    } else {
      emailErrorIconColor = null;
    }
    update();
    return null;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    fullNameFocusNode.dispose();
    emailController.dispose();
    dateOfBirthController.dispose();
    emailFocusNode.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
    dateOfBirthRangeController.dispose();
    dateOfBirthFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
