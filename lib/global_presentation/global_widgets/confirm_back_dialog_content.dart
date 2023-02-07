import '../../app/constants/exports.dart';
import '../../generated/locales.g.dart';
import 'global_button.dart';

class ConfirmBackDialogContent extends StatelessWidget {
  const ConfirmBackDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryText(
              LocaleKeys.back_backward.tr,
              color: ColorManager.primary,
              fontSize: 20,
              fontWeight: FontWeightManager.medium,
            ),
            SizedBox(height: 10.h),
            PrimaryText(
              LocaleKeys.wanna_back.tr,
              color: ColorManager.grey2,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlobalButton(
                  title: LocaleKeys.no.tr,
                  height: 50.h,
                  borderColor: ColorManager.primary,
                  width: 142.w,
                  onTap: () => Get.back(),
                ),
                SizedBox(width: 10.w),
                PrimaryButton(
                  width: 142.w,
                  onPressed: () async {
                    if (Get.isDialogOpen!) {
                      Get.back();
                    }
                    Future.delayed(const Duration(milliseconds: 280))
                        .then((value) => Get.back());
                  },
                  title: LocaleKeys.ok.tr,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
