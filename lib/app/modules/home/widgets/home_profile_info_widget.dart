import 'package:cached_network_image/cached_network_image.dart';

import '../../../constants/exports.dart';
import '../../bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import '../controllers/home_controller.dart';

class HomeProfileInfoWidget extends GetView<HomeController> {
  const HomeProfileInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () async {
        final BottomNavBarController bottomNavBarController = Get.find();
        bottomNavBarController.bottomNavIndex.value = 3; // profile
      },
      child: Row(
        children: [
          GetBuilder<HomeController>(builder: (HomeController controller) {
            return Container(
              width: 65.w,
              height: 65.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: controller.userPicture != null &&
                          controller.userPicture!.isNotEmpty
                      ? CachedNetworkImageProvider(
                          controller.userPicture ??
                              "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png",
                          errorListener: () {
                            controller.changeUserPictureIfErrorHappens();
                          },
                        ) as ImageProvider
                      : AssetImage(ImagesManager.guest),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  width: 1,
                  color: ColorManager.primary,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
          SizedBox(width: 13.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                "${controller.currentUserInfo.result != null ? controller.currentUserInfo.result!.name : ""} ${controller.currentUserInfo.result != null ? controller.currentUserInfo.result!.surname : ""}",
                fontSize: 16.sp,
                fontWeight: FontWeightManager.light,
                color: ColorManager.black,
              ),
              SizedBox(height: 5.h),
              PrimaryText(
                controller.currentUserInfo.result != null
                    ? controller.currentUserInfo.result!.emailAddress ?? ""
                    : "",
                fontSize: 14.sp,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
