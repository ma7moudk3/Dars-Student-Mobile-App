import 'package:hessa_student/app/routes/app_pages.dart';

import '../../../../constants/exports.dart';
import '../../../../core/helper_functions.dart';
import '../../controllers/addresses_controller.dart';
import '../../data/models/address_result/address_result.dart';
import 'delete_address_dialog_content.dart';

class AddressWidget extends GetView<AddressesController> {
  const AddressWidget({
    super.key,
    required this.addressResult,
  });
  final AddressResult addressResult;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async => await Get.toNamed(
        Routes.EDIT_ADDRESS,
        arguments: addressResult,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1a000000),
              offset: Offset(0, 1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  ImagesManager.locationIcon,
                  color: ColorManager.primary,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Tooltip(
                    message: addressResult.countryName != null &&
                            addressResult.governorateName != null &&
                            addressResult.localityName != null
                        ? "${addressResult.countryName ?? ""} - ${addressResult.governorateName ?? ""} - ${addressResult.localityName ?? ""}"
                        : "${addressResult.countryName ?? ""}${addressResult.governorateName ?? ""}",
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(16),
                    showDuration: const Duration(milliseconds: 5500),
                    preferBelow: true,
                    textAlign: detectLang(
                            text: addressResult.countryName != null &&
                                    addressResult.governorateName != null &&
                                    addressResult.localityName != null
                                ? "${addressResult.countryName ?? ""} - ${addressResult.governorateName ?? ""} - ${addressResult.localityName ?? ""}"
                                : "${addressResult.countryName ?? ""}${addressResult.governorateName ?? ""}")
                        ? TextAlign.left
                        : TextAlign.right,
                    decoration: BoxDecoration(
                      color: ColorManager.grey5,
                      borderRadius: BorderRadius.circular(10),
                    ),
                        textStyle: TextStyle(
                color: ColorManager.white,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                fontFamily: FontConstants.fontFamily,
              ),
                    triggerMode: TooltipTriggerMode.tap,
                    child: PrimaryText(
                      addressResult.countryName != null &&
                              addressResult.governorateName != null &&
                              addressResult.localityName != null
                          ? "${addressResult.countryName ?? ""} - ${addressResult.governorateName ?? ""} - ${addressResult.localityName ?? ""}"
                          : "${addressResult.countryName ?? ""}${addressResult.governorateName ?? ""}",
                      fontSize: 14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeightManager.light,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  width: 140.w,
                  child: Tooltip(
                    message: addressResult.address != null &&
                            addressResult.address?.name != null &&
                            addressResult.address?.address1 != null
                        ? "${addressResult.address?.name ?? ""}: ${addressResult.address?.address1 ?? ""}"
                        : "${addressResult.address?.name ?? ""}${addressResult.address?.name ?? ""}",
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(16),
                         textStyle: TextStyle(
                color: ColorManager.white,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                fontFamily: FontConstants.fontFamily,
              ),
                    showDuration: const Duration(milliseconds: 5500),
                    preferBelow: true,
                    textAlign: detectLang(
                            text: addressResult.address != null &&
                                    addressResult.address?.name != null &&
                                    addressResult.address?.address1 != null
                                ? "${addressResult.address?.name ?? ""}: ${addressResult.address?.address1 ?? ""}"
                                : "${addressResult.address?.name ?? ""}${addressResult.address?.name ?? ""}")
                        ? TextAlign.left
                        : TextAlign.right,
                    decoration: BoxDecoration(
                      color: ColorManager.grey5,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    triggerMode: TooltipTriggerMode.tap,
                    child: PrimaryText(
                      addressResult.address != null &&
                              addressResult.address?.name != null &&
                              addressResult.address?.address1 != null
                          ? "${addressResult.address?.name ?? ""}: ${addressResult.address?.address1 ?? ""}"
                          : "${addressResult.address?.name ?? ""}${addressResult.address?.name ?? ""}",
                      fontSize: 13,
                      maxLines: 1,
                      color: ColorManager.fontColor7,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await Get.dialog(
                        Container(
                          color: ColorManager.black.withOpacity(0.1),
                          height: 140.h,
                          width: 140.w,
                          child: Center(
                            child: Container(
                              width: Get.width,
                              margin: EdgeInsets.symmetric(
                                horizontal: 18.w,
                              ),
                              child: const DeleteAddressDialogContent(),
                            ),
                          ),
                        ),
                        arguments: {
                          "addressId": addressResult.address?.id ?? -1,
                        });
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: ColorManager.red.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        ImagesManager.deleteIcon,
                        color: ColorManager.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async => await Get.toNamed(
                    Routes.EDIT_ADDRESS,
                    arguments: addressResult,
                  ),
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.edit_rounded,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
