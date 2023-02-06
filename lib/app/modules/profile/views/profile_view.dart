import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hessa_student/app/routes/app_pages.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/profile_controller.dart';
import '../widgets/change_address_bottom_sheet_content.dart';
import '../widgets/logout_dialog_content.dart';
import '../widgets/more_item.dart';
import '../widgets/profile_info_widget.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(() => ProfileController());
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.personal_profile,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async => await Get.toNamed(Routes.SETTINGS),
          child: SvgPicture.asset(
            ImagesManager.settingsIcon,
            color: ColorManager.primaryDark,
          ),
        ),
        action: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            await Get.toNamed(Routes.EDIT_PROFILE);
          },
          child: SvgPicture.asset(
            ImagesManager.editProfileIcon,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ProfileController>(
            builder: (ProfileController controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              const ProfileInfoWidget(),
              SizedBox(height: 24.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MoreItem(
                    textSettingsColor: ColorManager.fontColor2,
                    settingsColor: ColorManager.white,
                    title: LocaleKeys.toggle_notifications.tr,
                    iconPath: ImagesManager.notificationIcon,
                    color: ColorManager.primaryLight.withOpacity(0.15),
                    iconColor: ColorManager.primaryLight,
                    action: CupertinoSwitch(
                        activeColor: ColorManager.primaryLight,
                        value: controller.isNotified,
                        onChanged: (bool value) async {
                          if (await checkInternetConnection(timeout: 10)) {
                            await controller.toggleNotifications(value);
                          } else {
                            Get.toNamed(Routes.CONNECTION_FAILED);
                          }
                        }),
                    onTap: () => log("notifications"),
                  ),
                  moreDivider(),
                  MoreItem(
                    textSettingsColor: ColorManager.fontColor2,
                    settingsColor: ColorManager.white,
                    title: LocaleKeys.personal_information.tr,
                    iconPath: ImagesManager.profileDataIcon,
                    color: ColorManager.primaryLight.withOpacity(0.15),
                    iconColor: ColorManager.primaryLight,
                    onTap: () async =>
                        await Get.toNamed(Routes.PROFILE_INFORMATION),
                  ),
                  moreDivider(),
                  MoreItem(
                    textSettingsColor: ColorManager.fontColor2,
                    settingsColor: ColorManager.white,
                    title: LocaleKeys.address.tr,
                    subTitle: "رام الله ، الضفة الغربية",
                    iconPath: ImagesManager.locationIcon,
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
                        const ChangeAddressBottomSheetContent(),
                      ).whenComplete(() => controller.clearData());
                    },
                  ),
                  moreDivider(),
                  MoreItem(
                    textSettingsColor: ColorManager.fontColor2,
                    settingsColor: ColorManager.white,
                    title: LocaleKeys.wallet.tr,
                    iconPath: ImagesManager.walletIcon,
                    color: ColorManager.primaryLight.withOpacity(0.15),
                    iconColor: ColorManager.primaryLight,
                    onTap: () async => await Get.toNamed(Routes.WALLET),
                  ),
                  moreDivider(),
                  MoreItem(
                    textSettingsColor: ColorManager.fontColor2,
                    settingsColor: ColorManager.white,
                    title: LocaleKeys.dependents.tr,
                    iconPath: ImagesManager.peopleIcon,
                    color: ColorManager.primaryLight.withOpacity(0.15),
                    iconColor: ColorManager.primaryLight,
                    onTap: () async => await Get.toNamed(Routes.DEPENDENTS),
                  ),
                  moreDivider(),
                  MoreItem(
                    textSettingsColor: ColorManager.fontColor2,
                    settingsColor: ColorManager.white,
                    title: LocaleKeys.settings_and_help.tr,
                    iconPath: ImagesManager.settingsIcon,
                    color: ColorManager.primaryLight.withOpacity(0.15),
                    iconColor: ColorManager.primaryLight,
                    onTap: () async => await Get.toNamed(Routes.SETTINGS),
                  ),
                  moreDivider(),
                  MoreItem(
                    textSettingsColor: ColorManager.fontColor2,
                    settingsColor: ColorManager.white,
                    title: LocaleKeys.logout.tr,
                    iconPath: ImagesManager.logoutIcon,
                    color: ColorManager.red.withOpacity(0.15),
                    iconColor: ColorManager.red,
                    action: const SizedBox.shrink(),
                    onTap: () async {
                      Get.dialog(
                        Container(
                          color: ColorManager.black.withOpacity(0.1),
                          height: 140.h,
                          width: 140.w,
                          child: Center(
                            child: Container(
                              width: Get.width,
                              margin: EdgeInsets.symmetric(
                                horizontal: 18.w,
                              ),
                              child: const LogoutDialogContent(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
