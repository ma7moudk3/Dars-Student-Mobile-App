import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:hessa_student/app/data/cache_helper.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/profile_controller.dart';

class ProfileInfoWidget extends GetView<ProfileController> {
  const ProfileInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(builder: (ProfileController controller) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: Get.width,
        height: 112.h,
        decoration: BoxDecoration(
          color: ColorManager.yellow.withOpacity(0.13),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: controller.userPicture != null &&
                          controller.userPicture!.isNotEmpty
                      ? CacheHelper.instance.getUserProfilePicture() != null &&
                              CacheHelper.instance
                                  .getUserProfilePicture()!
                                  .isNotEmpty
                          ? MemoryImage(base64Decode(CacheHelper.instance
                              .getUserProfilePicture()!)) as ImageProvider
                          : CachedNetworkImageProvider(
                              controller.userPicture ??
                                  "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png",
                              errorListener: () {
                                controller.changeUserPictureIfErrorHappens();
                              },
                            )
                      : AssetImage(ImagesManager.guest),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  width: 1,
                  color: ColorManager.primary,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(
                  controller.currentUserProfileInfo.value != null &&
                          controller.currentUserProfileInfo.value!.result !=
                              null
                      ? "${controller.currentUserProfileInfo.value!.result!.name ?? ""} ${controller.currentUserProfileInfo.value!.result!.surname ?? ""}"
                      : "",
                  fontSize: 16.sp,
                  fontWeight: FontWeightManager.light,
                  color: ColorManager.primary,
                ),
                SizedBox(height: 5.h),
                PrimaryText(
                  controller.currentUserProfileInfo.value != null &&
                          controller.currentUserProfileInfo.value!.result !=
                              null
                      ? controller.currentUserProfileInfo.value!.result!
                              .emailAddress ??
                          ""
                      : "",
                  fontSize: 14.sp,
                  fontWeight: FontWeightManager.softLight,
                  color: ColorManager.grey5,
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    PrimaryText(
                      "${LocaleKeys.last_seen.tr}:",
                      fontSize: 14.sp,
                      fontWeight: FontWeightManager.softLight,
                      color: ColorManager.fontColor,
                    ),
                    SizedBox(width: 5.w),
                    PrimaryText(
                      "18 مارس 2022",
                      fontSize: 14.sp,
                      fontWeight: FontWeightManager.softLight,
                      color: ColorManager.grey5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
