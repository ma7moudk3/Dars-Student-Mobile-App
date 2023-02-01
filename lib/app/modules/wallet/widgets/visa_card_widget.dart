import '../../../constants/exports.dart';
import '../controllers/wallet_controller.dart';

class VisaCardWidget extends GetView<WalletController> {
  const VisaCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: Get.width,
        height: 158.h,
        padding: const EdgeInsets.fromLTRB(21, 16, 16, 20),
        decoration: BoxDecoration(
          color: ColorManager.primaryLight2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(ImagesManager.visaIcon),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: ColorManager.fontColor6,
                    size: 20,
                  ),
                ),
              ],
            ),
            PrimaryText(
              "3384 4003 4885 2334",
              fontSize: 18.sp,
              fontWeight: FontWeightManager.softLight,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryText(
                      "CARD HOLDER",
                      fontSize: 9.sp,
                      fontWeight: FontWeightManager.light,
                      letterSpacing: 1.5,
                    ),
                    PrimaryText(
                      "EXP DATE",
                      fontSize: 9.sp,
                      fontWeight: FontWeightManager.light,
                      color: ColorManager.primary,
                      letterSpacing: 1.5,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryText(
                      "Waleed .A",
                      fontSize: 16.sp,
                      fontWeight: FontWeightManager.softLight,
                    ),
                    PrimaryText(
                      "${DateTime.now().month}/${DateTime.now().year}",
                      fontSize: 16.sp,
                      fontWeight: FontWeightManager.softLight,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
