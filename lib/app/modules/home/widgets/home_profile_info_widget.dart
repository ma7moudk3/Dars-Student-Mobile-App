import 'package:cached_network_image/cached_network_image.dart';

import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../../bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import '../controllers/home_controller.dart';

class HomeProfileInfoWidget extends GetView<HomeController> {
  const HomeProfileInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userPicture =
        "${Links.baseLink}${Links.profileImageById}?userId=${controller.currentUserProfileInfo.result!.requester!.userId.toString()}";
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () async {
        final BottomNavBarController bottomNavBarController = Get.find();
        bottomNavBarController.bottomNavIndex.value = 3; // profile
      },
      child: Row(
        children: [
          GetBuilder<HomeController>(builder: (HomeController controller) {
            return StatefulBuilder(builder: (BuildContext context, setState) {
              return Container(
                width: 65.w,
                height: 65.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      userPicture,
                      errorListener: () {
                        setState(() {
                          userPicture =
                              "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                        });
                      },
                    ),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 1,
                    color: ColorManager.primary,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(20),
                //   child: CachedNetworkImage(
                //     imageUrl:
                //         "${Links.baseLink}${Links.profileImageById}?userId=${controller.currentUserProfileInfo.result!.requester!.userId.toString()}",
                //     fit: BoxFit.cover,
                //     errorWidget:
                //         (BuildContext context, String url, dynamic error) =>
                //             Image.asset(
                //       ImagesManager.guest,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
              );
            });
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
