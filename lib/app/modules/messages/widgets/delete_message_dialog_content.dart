import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/global_button.dart';
import '../../../constants/exports.dart';

class DeleteMessageDialogContent extends StatelessWidget {
  const DeleteMessageDialogContent({
    Key? key,
    required this.deleteMessageFunction,
  }) : super(key: key);

  final void Function() deleteMessageFunction;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImagesManager.exclamationMarkIcon),
            SizedBox(height: 10.h),
            PrimaryText(
              LocaleKeys.chat_deletion.tr,
              color: ColorManager.primary,
              fontSize: 20,
              fontWeight: FontWeightManager.light,
            ),
            SizedBox(height: 10.h),
            PrimaryText(
              LocaleKeys.wanna_delete_chat.tr,
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
                    deleteMessageFunction();
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
