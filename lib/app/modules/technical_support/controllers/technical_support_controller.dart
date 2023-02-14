import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/technical_support/data/models/urgency_type/result.dart';
import 'package:hessa_student/app/modules/technical_support/data/models/urgency_type/urgency_type.dart';
import 'package:hessa_student/app/modules/technical_support/data/repos/technical_support_repo.dart';
import 'package:hessa_student/global_presentation/global_widgets/custom_snack_bar.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../data/repos/technical_support_repo_implement.dart';

class TechnicalSupportController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController,
      messageController,
      emailController;
  FocusNode fullNameFocusNode = FocusNode(), emailFocusNode = FocusNode();
  Color? fullNameIconErrorColor, emailIconErrorColor;
  RxBool isLoading = true.obs, isInternetConnected = true.obs;
  final TechnicalSupportRepo _technicalSupportRepo =
      TechnicalSupportRepoImplement();
  UrgencyType urgencyType = UrgencyType();
  Result selectedUrgency = Result();
  @override
  void onInit() async {
    fullNameController = TextEditingController(
        text:
            "${CacheHelper.instance.getCachedCurrentUserInfo()?.result?.name ?? ''} ${CacheHelper.instance.getCachedCurrentUserInfo()?.result?.surname ?? ''}");
    messageController = TextEditingController();
    emailController = TextEditingController(
        text: CacheHelper.instance
                .getCachedCurrentUserInfo()
                ?.result
                ?.emailAddress ??
            '');
    fullNameFocusNode.addListener(() => update());
    emailFocusNode.addListener(() => update());
    await checkInternet();
    super.onInit();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    messageController.dispose();
    emailController.dispose();
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        await Future.wait([_getUrgencyTypes()])
            .then((value) => isLoading.value = false);
      }
    });
  }

  void changeMessageType(String result) {
    if (urgencyType.result != null) {
      for (var urgency in urgencyType.result ?? <Result>[]) {
        if (urgency.displayName != null &&
            urgency.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedUrgency = urgency;
        }
      }
    }
    update();
  }

  Future sendMessage() async {
    showLoadingDialog();
    await _technicalSupportRepo
        .sendTechnicalSupportMessage(
      fullName: fullNameController.text,
      email: emailController.text,
      message: messageController.text,
      urgencyType: selectedUrgency,
    )
        .then((int statusCode) async {
      if (statusCode == 200) {
        await Future.delayed(const Duration(milliseconds: 550))
            .then((value) async {
          CustomSnackBar.showCustomSnackBar(
            title: LocaleKeys.success.tr,
            message: LocaleKeys.message_sent_successfully.tr,
          );
          await Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
        });
      } else {
        CustomSnackBar.showCustomSnackBar(
          title: LocaleKeys.error.tr,
          message: LocaleKeys.something_went_wrong.tr,
        );
      }
    });
  }

  Future _getUrgencyTypes() async {
    urgencyType = await _technicalSupportRepo.getUrgencyTypes();
    if (urgencyType.result != null) {
      urgencyType.result!.insert(
        0,
        Result(
          id: -1,
          displayName: LocaleKeys.choose_message_type.tr,
        ),
      );
    }
  }

  String? validateFullName(String? fullName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (fullName == null || fullName.isEmpty) {
      fullNameIconErrorColor = Colors.red;
      update();
      return LocaleKeys.please_enter_fullname.tr;
    } else if (regExp.hasMatch(fullName)) {
      fullNameIconErrorColor = Colors.red;
      update();
      return LocaleKeys.check_your_full_name.tr;
    } else {
      fullNameIconErrorColor = null;
    }
    update();
    return null;
  }

  String? validateMessage(String? message) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (message == null || message.isEmpty) {
      return LocaleKeys.please_enter_message_content.tr;
    } else if (regExp.hasMatch(message)) {
      return LocaleKeys.check_message_content.tr;
    }
    update();
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      emailIconErrorColor = Colors.red;
      update();
      return LocaleKeys.please_enter_email.tr;
    } else if (email.isEmail == false) {
      emailIconErrorColor = Colors.red;
      update();
      return LocaleKeys.please_enter_valid_email.tr;
    } else {
      emailIconErrorColor = null;
    }
    update();
    return null;
  }
}
