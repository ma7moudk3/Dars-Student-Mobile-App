import 'dart:developer';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../profile/widgets/more_item.dart';
import '../controllers/settings_controller.dart';
import '../widgets/change_password_bottom_sheet_content.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.settings_and_help,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.fontColor,
            size: 20,
          ),
        ),
        action: const SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            MoreItem(
              textSettingsColor: ColorManager.fontColor2,
              settingsColor: ColorManager.white,
              title: LocaleKeys.change_password.tr,
              iconPath: ImagesManager.lockIcon,
              color: ColorManager.primaryLight.withOpacity(0.15),
              iconColor: ColorManager.primaryLight,
              onTap: () async {
                await Get.bottomSheet(
                  backgroundColor: ColorManager.white,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  const ChangePasswordBottomSheetContent(),
                );
              },
            ),
            moreDivider(),
            MoreItem(
              textSettingsColor: ColorManager.fontColor2,
              settingsColor: ColorManager.white,
              title: LocaleKeys.technical_support.tr,
              iconPath: ImagesManager.headphoneIcon,
              color: ColorManager.primaryLight.withOpacity(0.15),
              iconColor: ColorManager.primaryLight,
              onTap: () async => log('Technical Support'),
            ),
            moreDivider(),
            MoreItem(
              textSettingsColor: ColorManager.fontColor2,
              settingsColor: ColorManager.white,
              title: LocaleKeys.privacy_policy.tr,
              iconPath: ImagesManager.shieldIcon,
              color: ColorManager.primaryLight.withOpacity(0.15),
              iconColor: ColorManager.primaryLight,
              onTap: () async => log('Privacy Policy'),
            ),
            moreDivider(),
            MoreItem(
              textSettingsColor: ColorManager.fontColor2,
              settingsColor: ColorManager.white,
              title: LocaleKeys.terms_and_conditions.tr,
              iconPath: ImagesManager.questionsIcon,
              color: ColorManager.primaryLight.withOpacity(0.15),
              iconColor: ColorManager.primaryLight,
              onTap: () async => log('Terms and Conditions'),
            ),
            moreDivider(),
            MoreItem(
              textSettingsColor: ColorManager.fontColor2,
              settingsColor: ColorManager.white,
              title: LocaleKeys.abous_hessa.tr,
              iconPath: ImagesManager.aboutHessaIcon,
              color: ColorManager.primaryLight.withOpacity(0.15),
              iconColor: ColorManager.primaryLight,
              onTap: () async => log('About Hessa'),
            ),
          ],
        ),
      ),
    );
  }
}
