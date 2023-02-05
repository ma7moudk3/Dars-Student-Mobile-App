import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class EmailVerificationSentDialogContent extends StatelessWidget {
  const EmailVerificationSentDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email =
        "${Get.arguments["email"].toString().trim().split("@")[0].substring(0, 3)}*******@${Get.arguments["email"].toString().trim().split("@")[1]}";
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImagesManager.emailVerificationSentIcon),
            SizedBox(height: 25.h),
            PrimaryText(
              LocaleKeys.forgot_password_email_link_sent.tr,
              color: ColorManager.primary,
              fontSize: 16.sp,
              fontWeight: FontWeightManager.medium,
            ),
            SizedBox(height: 10.h),
            PrimaryText(
              "${LocaleKeys.revise_your_email_to_restore_password.tr}: $email",
              fontSize: 14.sp,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: PrimaryButton(
                onPressed: () => Get.back(),
                title: LocaleKeys.ok.tr,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
