import '../../../../constants/exports.dart';
import '../../controllers/addresses_controller.dart';
import '../../data/models/address_result/address_result.dart';

class AddressWidget extends GetView<AddressesController> {
  const AddressWidget({
    super.key,
    required this.addressResult,
  });
  final AddressResult addressResult;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: ColorManager.primary
                  .withOpacity(0.10),
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: PrimaryText(
                  addressResult.countryName != null &&
                          addressResult
                                  .governorateName !=
                              null
                      ? "${addressResult.countryName ?? ""} - ${addressResult.governorateName ?? ""}"
                      : "${addressResult.countryName ?? ""}${addressResult.governorateName ?? ""}",
                  fontSize: 16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeightManager.light,
                ),
              ),
              SizedBox(height: 4.h),
              SizedBox(
                width: 200.w,
                child: PrimaryText(
                  addressResult.address != null &&
                          addressResult.address?.name !=
                              null &&
                          addressResult
                                  .address?.address1 !=
                              null
                      ? "${addressResult.address?.name ?? ""}: ${addressResult.address?.address1 ?? ""}"
                      : "${addressResult.address?.name ?? ""}${addressResult.address?.name ?? ""}",
                  fontSize: 13.sp,
                  maxLines: 1,
                  color: ColorManager.fontColor7,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              await controller.deleteAddress(
                addressId:
                    addressResult.address?.id ?? -1,
              );
            },
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color:
                    ColorManager.red.withOpacity(0.10),
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
        ],
      ),
    );
  }
}