import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';
import 'package:hessa_student/app/modules/login/data/repos/login_repo.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../constants/exports.dart';
import '../../../data/cache_helper.dart';
import '../../../data/network_helper/firebase_social_auth_helpers.dart';
import '../../../routes/app_pages.dart';
import '../../edit_profile/data/repos/edit_profile_repo.dart';
import '../../edit_profile/data/repos/edit_profile_repo_implement.dart';
import '../data/models/current_user_profile_info/current_user_profile_info.dart';
import '../data/repos/login_repo_implement.dart';

class LoginController extends GetxController {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  late TextEditingController emailController, passwordController;
  Color? emailErrorIconColor, passwordErrorIconColor;
  GoogleSignInAccount? googleAccount;
  final GlobalKey<FormState> formKey = GlobalKey();
  final LoginRepo _loginRepo = LoginRepoImplement();
  final EditProfileRepo _editProfileRepo = EditProfileRepoImplement();

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode.addListener(() => update());
    passwordFocusNode.addListener(() => update());
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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

  Future login() async {
    try {
      showLoadingDialog();
      await _loginRepo
          .login(
        login: emailController.text,
        password: passwordController.text,
      )
          .then((int statusCode) async {
        if (statusCode == 200) {
          Future.wait([
            _getCurrentUserInfo(),
            _getCurrentUserProfileInfo(),
            _getCurrentUserProfilePicture()
          ]).then((value) async {
            CurrentUserInfo currentUserInfo =
                CacheHelper.instance.getCachedCurrentUserInfo() ??
                    CurrentUserInfo();
            bool isEmailConfirmed = currentUserInfo.result != null
                ? currentUserInfo.result!.isEmailConfirmed ?? false
                : false;
            bool isPhoneConfirmed = currentUserInfo.result != null
                ? currentUserInfo.result!.isPhoneNumberConfirmed ?? false
                : false;
            developer.log("isEmailConfirmed? $isEmailConfirmed");
            developer.log("isPhoneConfirmed? $isPhoneConfirmed");
            if (currentUserInfo.result != null &&
                ((!isEmailConfirmed) || (!isPhoneConfirmed))) {
              Future.wait([
                CacheHelper.instance.setIsEmailConfirmed(
                    currentUserInfo.result!.isEmailConfirmed ?? false),
                CacheHelper.instance.setIsPhoneConfirmed(
                    currentUserInfo.result!.isPhoneNumberConfirmed ?? false)
              ]).then((value) async {
                await Get.offAllNamed(Routes.VERIFY_ACCOUNT);
              });
            } else {
              await CacheHelper.instance.setIsEmailConfirmed(true);
              await CacheHelper.instance.setIsPhoneConfirmed(true);
              await CacheHelper.instance.setIsWelcomeBack(true);
              await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
            }
          });
        }
      });
    } catch (e) {
      developer.log('login Exception error {{2}} $e');
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }

  Future googleLogin() async {
    try {
      showLoadingDialog();
      googleAccount = await GoogleSignInHelper.googleLogin();
      if (googleAccount != null) {
        GoogleSignInAuthentication authentication =
            await googleAccount!.authentication;
        if (authentication.accessToken != null) {
          developer.log("Google Account ID: ${googleAccount!.id}");
          developer.log("Google Account Email: ${googleAccount!.email}");
          developer.log("Google Account PHOTO URL: ${googleAccount!.photoUrl}");
          developer.log(
              "Google Authentication Acess Token: ${authentication.accessToken ?? ""}");
          developer.log(
              "Google Authentication ID Token: ${authentication.idToken ?? ""}");
          await _loginRepo
              .googleLogin(
            accessToken: authentication.accessToken!,
            providerKey: googleAccount!.id,
          )
              .then((int statusCode) async {
            if (statusCode == 200) {
              await Future.wait([
                _getCurrentUserInfo(),
                _getCurrentUserProfileInfo(),
                _getCurrentUserProfilePicture(
                  isGoogleLogin: true,
                  googlePhotoUrl: googleAccount!.photoUrl ?? "",
                ),
              ]).then((value) async {
                CurrentUserInfo currentUserInfo =
                    CacheHelper.instance.getCachedCurrentUserInfo() ??
                        CurrentUserInfo();
                CurrentUserProfileInfo currentUserProfileInfo =
                    CacheHelper.instance.getCachedCurrentUserProfileInfo() ??
                        CurrentUserProfileInfo();
                bool isEmailConfirmed = currentUserInfo.result != null
                    ? currentUserInfo.result!.isEmailConfirmed ?? false
                    : false;
                bool isPhoneConfirmed = currentUserInfo.result != null
                    ? currentUserInfo.result!.isPhoneNumberConfirmed ?? false
                    : false;
                developer.log("isEmailConfirmed? $isEmailConfirmed");
                developer.log("isPhoneConfirmed? $isPhoneConfirmed");
                if (currentUserInfo.result != null &&
                    ((!isEmailConfirmed &&
                            currentUserInfo.result!.emailAddress != null) ||
                        (!isPhoneConfirmed &&
                            currentUserProfileInfo.result!.phoneNumber !=
                                null))) {
                  await Future.wait([
                    CacheHelper.instance.setIsEmailConfirmed(
                        currentUserInfo.result!.isEmailConfirmed ?? false),
                    CacheHelper.instance.setIsPhoneConfirmed(
                        currentUserInfo.result!.isPhoneNumberConfirmed ?? false)
                  ]).then((value) async {
                    await Get.offAllNamed(Routes.VERIFY_ACCOUNT);
                  });
                } else {
                  await CacheHelper.instance.setIsEmailConfirmed(true);
                  await CacheHelper.instance.setIsPhoneConfirmed(true);
                  await CacheHelper.instance.setIsWelcomeBack(true);
                  await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
                }
              });
            }
          });
        }
      }
    } catch (e) {
      developer.log('googleLogin Exception error {{2}} $e');
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
    update();
  }

  Future _getCurrentUserInfo() async {
    // information like: isProfileCompleted, isExternalUser (google or facecbook), isEmailConfirmed, isPhoneNumberConfirmed
    showLoadingDialog();
    await _loginRepo
        .getCurrentUserInfo()
        .then((CurrentUserInfo currentUserInfo) async {
      await CacheHelper.instance.cacheCurrentUserInfo(currentUserInfo.toJson());
    });
  }

  Future _getCurrentUserProfilePicture(
      {bool isGoogleLogin = false, String? googlePhotoUrl}) async {
    developer.log("isGoogleLogin? $googlePhotoUrl");
    String profilePicture = await _loginRepo.getCurrentUserProfilePicture();
    if (isGoogleLogin && googlePhotoUrl != null && googlePhotoUrl.isNotEmpty) {
      if (profilePicture.isEmpty) {
        await _editProfileRepo.updateProfilePicture(
          image: await _urlToFile(imageURL: googlePhotoUrl),
        );
      }
    }
  }

  Future<File> _urlToFile({required String imageURL}) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(10000)}.png');
    Uri uri = Uri.parse(imageURL);
    http.Response response = await http.get(uri);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  Future _getCurrentUserProfileInfo() async {
    // information like: userName, emailAddress, paymentMethodName, phoneNumber, addresses
    showLoadingDialog();
    await _loginRepo
        .getCurrentUserProfileInfo()
        .then((CurrentUserProfileInfo currentUserProfileInfo) async {
      await CacheHelper.instance
          .cacheCurrentUserProfileInfo(currentUserProfileInfo.toJson());
    });
  }

  String? validatePassword(String? passwordFieldValue) {
    if (passwordFieldValue == null || passwordFieldValue.isEmpty) {
      passwordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.please_enter_password.tr;
    } else if (passwordFieldValue.length < 6) {
      passwordErrorIconColor = Colors.red;
      update();
      return LocaleKeys.password_must_be_at_least_6_characters.tr;
    } else {
      passwordErrorIconColor = null;
    }
    update();
    return null;
  }

  @override
  void onClose() {}
}
