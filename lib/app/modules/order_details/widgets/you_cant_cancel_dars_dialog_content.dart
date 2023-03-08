import 'package:hessa_student/app/modules/order_details/controllers/order_details_controller.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class CannotCancelDarsDialogContent extends GetView<OrderDetailsController> {
  const CannotCancelDarsDialogContent({
    Key? key,
  }) : super(key: key);

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
            SvgPicture.asset(
              ImagesManager.exclamationMarkIcon,
              width: 110.w,
              height: 110.h,
            ),
            SizedBox(height: 20.h),
            PrimaryText(
              LocaleKeys.you_cannot_cancel_this_dars.tr,
              fontSize: 18.sp,
              fontWeight: FontWeightManager.light,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 240.w,
              child: PrimaryText(
                LocaleKeys.due_to_the_starting_time_of_the_dars.tr,
                fontSize: 15.sp,
                textAlign: TextAlign.center,
                maxLines: 2,
                fontWeight: FontWeightManager.softLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
