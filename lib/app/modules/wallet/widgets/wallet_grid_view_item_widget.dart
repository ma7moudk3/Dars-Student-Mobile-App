import 'package:hessa_student/app/modules/wallet/controllers/wallet_controller.dart';

import '../../../constants/exports.dart';

class WalletGridViewItem extends GetView<WalletController> {
  final String imagePath;
  final String title;
  final double cash;
  final Function()? onTap;
  final Color iconBackgroundColor;
  const WalletGridViewItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.cash,
    required this.onTap,
    required this.iconBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1a000000),
              offset: Offset(0, 1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: iconBackgroundColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  imagePath,
                  color: iconBackgroundColor,
                ),
              ),
            ),
            PrimaryText(
              "₪$cash",
              fontSize: 20.sp,
              fontWeight: FontWeightManager.light,
              color: ColorManager.fontColor,
            ),
            PrimaryText(
              title,
              fontSize: 15.sp,
              fontWeight: FontWeightManager.softLight,
              color: ColorManager.fontColor,
            ),
          ],
        ),
      ),
    );
  }
}
