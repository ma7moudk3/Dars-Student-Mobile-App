import 'dart:developer';
import 'dart:io';

import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_profile_info/current_user_profile_info.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../../login/data/repos/login_repo_implement.dart';
import '../data/repos/edit_profile_repo.dart';
import '../data/repos/edit_profile_repo_implement.dart';

class EditProfileController extends GetxController {
  late TextEditingController fullNameController,
      emailController,
      phoneController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode fullNameFocusNode = FocusNode(),
      emailFocusNode = FocusNode(),
      phoneFocusNode = FocusNode();
  Color? fullNameErrorIconColor, emailErrorIconColor;
  String? phoneNumber;
  int gender = 1; // 1 male, 2 female
  File? image;
  final EditProfileRepo _editProfileRepo = EditProfileRepoImplement();
  CurrentUserInfo currentUserInfo =
      CacheHelper.instance.getCachedCurrentUserInfo() ?? CurrentUserInfo();
  CurrentUserProfileInfo currentUserProfileInfo =
      CacheHelper.instance.getCachedCurrentUserProfileInfo() ??
          CurrentUserProfileInfo();
  final LoginRepo _loginRepo = LoginRepoImplement();
  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
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
    emailFocusNode.addListener(() => update());
    phoneController = TextEditingController(
      text: currentUserProfileInfo.result != null
          ? seperatePhoneAndDialCode(
                  phoneWithDialCode:
                      currentUserProfileInfo.result!.phoneNumber ?? "") ??
              ""
          : "",
    );
    gender = currentUserProfileInfo.result != null
        ? currentUserProfileInfo.result!.requester != null
            ? currentUserProfileInfo.result!.requester!.gender ?? 1
            : 1
        : 1;
    phoneFocusNode.addListener(() => update());
    update();
  }

  Future updateProfile() async {
    showLoadingDialog();
    await Future.wait([updateImage(), updateProfileData()]).then((value) async {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }).then((value) async {
      await Future.wait([
        getCurrentUserInfo(),
        getCurrentUserProfileInfo(),
        _loginRepo.getCurrentUserProfilePicture()
      ]).then((value) async {
        CustomSnackBar.showCustomSnackBar(
          title: LocaleKeys.success.tr,
          message: LocaleKeys.profile_edited_succesfully.tr,
          duration: const Duration(seconds: 2),
        );
        await Future.delayed(const Duration(milliseconds: 1000))
            .then((value) async {
          await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
        });
      });
    });
  }

  Future updateProfileData() async {
    if (currentUserProfileInfo.result != null &&
        currentUserProfileInfo.result!.requester != null) {
      await _editProfileRepo.updateProfile(
        firstName: fullNameController.text.split(" ")[0],
        surname: fullNameController.text.split(" ").length > 1
            ? fullNameController.text.split(" ")[1]
            : "",
        id: currentUserProfileInfo.result!.requester!.userId ?? -1,
        email: emailController.text,
        phoneNumber: phoneNumber,
        gender: gender,
      );
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
      image = File(pickedImage.path);
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

  void changePhoneNumber(PhoneNumber number) {
    phoneNumber = number.completeNumber.toString();
    update();
  }

  Future updateImage() async {
    if (image != null) {
      log("image is not null");
      await _editProfileRepo.updateProfilePicture(
        image: image!,
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
    emailFocusNode.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
