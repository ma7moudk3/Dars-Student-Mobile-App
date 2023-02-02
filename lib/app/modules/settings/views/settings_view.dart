import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
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
                ).whenComplete(() => controller.clearData());
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
              onTap: () async => await Get.toNamed(Routes.TECHNICAL_SUPPORT),
            ),
            moreDivider(),
            MoreItem(
              textSettingsColor: ColorManager.fontColor2,
              settingsColor: ColorManager.white,
              title: LocaleKeys.privacy_policy.tr,
              iconPath: ImagesManager.shieldIcon,
              color: ColorManager.primaryLight.withOpacity(0.15),
              iconColor: ColorManager.primaryLight,
              onTap: () async =>
                  await Get.toNamed(Routes.STATIC_PAGE, arguments: {
                "pageTitle": LocaleKeys.privacy_policy_in_hessa.tr,
                "pageId": 659,
              }),
            ),
            moreDivider(),
            MoreItem(
              textSettingsColor: ColorManager.fontColor2,
              settingsColor: ColorManager.white,
              title: LocaleKeys.terms_and_conditions.tr,
              iconPath: ImagesManager.questionsIcon,
              color: ColorManager.primaryLight.withOpacity(0.15),
              iconColor: ColorManager.primaryLight,
              onTap: () async =>
                  await Get.toNamed(Routes.STATIC_PAGE, arguments: {
                "pageTitle": LocaleKeys.terms_and_conditions_in_hessa.tr,
                "pageId": 659,
              }),
            ),
            moreDivider(),
            MoreItem(
              textSettingsColor: ColorManager.fontColor2,
              settingsColor: ColorManager.white,
              title: LocaleKeys.about_hessa.tr,
              iconPath: ImagesManager.aboutHessaIcon,
              color: ColorManager.primaryLight.withOpacity(0.15),
              iconColor: ColorManager.primaryLight,
              onTap: () async => await Get.toNamed(Routes.ABOUT_HESSA),
            ),
          ],
        ),
      ),
    );
  }
}
