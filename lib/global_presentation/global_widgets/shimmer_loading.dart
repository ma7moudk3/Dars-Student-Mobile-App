import 'package:shimmer/shimmer.dart';

import '../../app/constants/exports.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          loop: 3,
          baseColor: ColorManager.grey.withOpacity(0.1),
          highlightColor: ColorManager.grey.withOpacity(0.2),
          child: Container(
            width: 120.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorManager.borderColor2,
                width: 1.2,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Shimmer.fromColors(
          loop: 3,
          baseColor: ColorManager.grey.withOpacity(0.1),
          highlightColor: ColorManager.grey.withOpacity(0.2),
          child: Container(
            width: Get.width,
            height: 55.h,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorManager.borderColor2,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
