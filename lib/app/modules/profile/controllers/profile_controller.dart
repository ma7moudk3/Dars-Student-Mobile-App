import 'package:hessa_student/app/data/cache_helper.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class ProfileController extends GetxController {
  bool isNotified =
      CacheHelper.instance.getFcmToken().isNotEmpty ? true : false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController areaController, currentAddressController;
  FocusNode areaFocusNode = FocusNode(), currentAddressFocusNode = FocusNode();

  Future<void> toggleNotifications(bool value) async {
    isNotified = value;
    if (isNotified) {
      // await sendFcmToken().then((value) {
      //   if (Get.isDialogOpen!) {
      //     Get.back();
      //   }
      // });
    } else {
      // await FirebaseMessaging.instance.deleteToken().then((value) async {
      //   await CacheController.instance.setFcmToken("").then((value) {
      //     if (Get.isDialogOpen!) {
      //       Get.back();
      //     }
      //   });
      // });
    }
    update();
  }

  void clearData() {
    areaController.clear();
    currentAddressController.clear();
    areaFocusNode.unfocus();
    currentAddressFocusNode.unfocus();
    update();
  }

  String? validateArea(String? area) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (area == null || area.isEmpty) {
      return LocaleKeys.please_enter_area.tr;
    } else if (regExp.hasMatch(area)) {
      return LocaleKeys.check_area.tr;
    }
    update();
    return null;
  }

  String? validateCurrentAddress(String? currentAddress) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (currentAddress == null || currentAddress.isEmpty) {
      return LocaleKeys.please_enter_current_address.tr;
    } else if (regExp.hasMatch(currentAddress)) {
      return LocaleKeys.check_current_address.tr;
    }
    update();
    return null;
  }

  @override
  void onInit() {
    areaController = TextEditingController();
    currentAddressController = TextEditingController();
    areaFocusNode.addListener(() => update());
    currentAddressFocusNode.addListener(() => update());
    super.onInit();
  }

  @override
  void dispose() {
    areaController.dispose();
    currentAddressController.dispose();
    areaFocusNode.dispose();
    currentAddressFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
}
