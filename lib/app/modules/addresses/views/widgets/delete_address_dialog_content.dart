import 'package:hessa_student/app/modules/addresses/controllers/addresses_controller.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/global_button.dart';
import '../../../../constants/exports.dart';

class DeleteAddressDialogContent extends GetView<AddressesController> {
  const DeleteAddressDialogContent({
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
            SvgPicture.asset(ImagesManager.exclamationMarkIcon),
            SizedBox(height: 10.h),
            PrimaryText(
              LocaleKeys.address_deletion.tr,
              color: ColorManager.primary,
              fontSize: 20,
              fontWeight: FontWeightManager.medium,
            ),
            SizedBox(height: 10.h),
            PrimaryText(
              LocaleKeys.wanna_delete_address.tr,
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
                    int addressId =
                        Get.arguments != null ? Get.arguments["addressId"] : -1;
                    if (Get.isDialogOpen!) {
                      Get.back();
                    }
                    await controller.deleteAddress(
                      addressId: addressId,
                    );
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
