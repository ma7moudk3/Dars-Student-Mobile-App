import 'dart:developer';

import '../../../constants/exports.dart';
import '../controllers/home_controller.dart';

class HomeProfileInfoWidget extends GetView<HomeController> {
  const HomeProfileInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        log('ProfileInfo clicked');
      },
      child: Row(
        children: [
          Container(
            width: 65.w,
            height: 65.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesManager.avatar),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                width: 1,
                color: ColorManager.primary,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(width: 13.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                "وليد علي",
                fontSize: 16.sp,
                fontWeight: FontWeightManager.light,
                color: ColorManager.black,
              ),
              SizedBox(height: 5.h),
              PrimaryText(
                "Hessa2@Gmail.Com",
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