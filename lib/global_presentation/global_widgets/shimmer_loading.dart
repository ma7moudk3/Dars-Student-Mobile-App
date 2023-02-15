import 'package:shimmer/shimmer.dart';

import '../../app/constants/exports.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      loop: 3,
      baseColor: ColorManager.grey.withOpacity(0.4),
      highlightColor: ColorManager.grey.withOpacity(0.6),
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
    );
  }
}