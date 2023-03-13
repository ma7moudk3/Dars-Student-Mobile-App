import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/order_dars_controller.dart';
import '../data/models/product/product.dart';

class OrderDarsOptions extends GetView<OrderDarsController> {
  const OrderDarsOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDarsController>(
        builder: (OrderDarsController controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PrimaryText(
                LocaleKeys.session_way,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.fontColor,
              ),
              SizedBox(width: 2.w),
              PrimaryText(
                "*",
                fontSize: 16,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.accent,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: List.generate(3, (int index) {
              return GestureDetector(
                onTap: () {
                  controller.changeSessionWay(index);
                },
                child: Container(
                  width: 80.w,
                  height: 40.h,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : 10.w,
                    right: index == 2 ? 0 : 10.w,
                  ),
                  decoration: BoxDecoration(
                    color: controller.sessionWay == index
                        ? ColorManager.primary
                        : ColorManager.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: controller.sessionWay != index
                        ? Border.all(
                            color: ColorManager.borderColor2,
                            width: 1,
                          )
                        : null,
                    boxShadow: const [],
                  ),
                  child: Center(
                    child: PrimaryText(
                      index == 0
                          ? LocaleKeys.face_to_face
                          : index == 1
                              ? LocaleKeys.electronic
                              : LocaleKeys.both,
                      color: controller.sessionWay == index
                          ? ColorManager.white
                          : ColorManager.borderColor,
                      fontWeight: FontWeightManager.softLight,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              PrimaryText(
                LocaleKeys.teacher_gender,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.fontColor,
              ),
              SizedBox(width: 2.w),
              PrimaryText(
                "*",
                fontSize: 16,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.accent,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: List.generate(3, (int index) {
              return GestureDetector(
                onTap: () {
                  controller.changeTeacherGender(index);
                },
                child: Container(
                  width: 80.w,
                  height: 40.h,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : 10.w,
                    right: index == 2 ? 0 : 10.w,
                  ),
                  decoration: BoxDecoration(
                    color: controller.teacherGender == index
                        ? ColorManager.primary
                        : ColorManager.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: controller.teacherGender != index
                        ? Border.all(
                            color: ColorManager.borderColor2,
                            width: 1,
                          )
                        : null,
                    boxShadow: const [],
                  ),
                  child: Center(
                    child: PrimaryText(
                      index == 0
                          ? LocaleKeys.male
                          : index == 1
                              ? LocaleKeys.female
                              : LocaleKeys.both,
                      color: controller.teacherGender == index
                          ? ColorManager.white
                          : ColorManager.borderColor,
                      fontWeight: FontWeightManager.softLight,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              PrimaryText(
                LocaleKeys.order_type,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.fontColor,
              ),
              SizedBox(width: 2.w),
              PrimaryText(
                "*",
                fontSize: 16,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.accent,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: List.generate(2, (int index) {
              return GestureDetector(
                onTap: () {
                  controller.changeOrderType(index);
                },
                child: Container(
                  width: 100.w,
                  height: 40.h,
                  margin: EdgeInsets.only(
                    right: index == 0 ? 10.w : 0.w,
                    left: index == 1 ? 0.w : 10.w,
                  ),
                  decoration: BoxDecoration(
                    color: controller.orderType == index
                        ? ColorManager.primary
                        : ColorManager.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: controller.orderType != index
                        ? Border.all(
                            color: ColorManager.borderColor2,
                            width: 1,
                          )
                        : null,
                    boxShadow: const [],
                  ),
                  child: Center(
                    child: PrimaryText(
                      index == 0
                          ? LocaleKeys.one_dars
                          : LocaleKeys.school_package,
                      color: controller.orderType == index
                          ? ColorManager.white
                          : ColorManager.borderColor,
                      fontWeight: FontWeightManager.softLight,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              PrimaryText(
                "${LocaleKeys.school_package.tr}*: ",
                fontSize: 13,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.red,
              ),
              SizedBox(
                width: 210.w,
                child: PrimaryText(
                  LocaleKeys.school_package_description,
                  fontSize: 12,
                  fontWeight: FontWeightManager.softLight,
                  color: ColorManager.fontColor7,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryText(
                "${LocaleKeys.total_price.tr}: ",
                fontSize: 13,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.red,
              ),
              SizedBox(
                width: 250.w,
                child: Tooltip(
                  message: controller.orderType == 0
                      ? "${LocaleKeys.dars_price.tr} (${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == false)?.productDetails?.hourlyPrice ?? 0} ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == false)?.currencyNameL?.replaceAll("ال", "") ?? 0})"
                      : "${LocaleKeys.dars_price.tr} (${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == false)?.productDetails?.hourlyPrice ?? 0} ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.currencyNameL?.replaceAll("ال", "") ?? 0}) * ${LocaleKeys.droos_count.tr} (${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.productDetails?.totalHours ?? 0}) = ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.productDetails?.productPrice ?? 0} ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.currencyNameL?.replaceAll("ال", "") ?? 0}",
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(16),
                  showDuration: const Duration(milliseconds: 5500),
                  preferBelow: true,
                  textAlign: detectLang(
                          text: controller.orderType == 0
                              ? "${LocaleKeys.dars_price.tr} (${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == false)?.productDetails?.hourlyPrice ?? 0} ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == false)?.currencyNameL ?? 0})"
                              : "${LocaleKeys.dars_price.tr} (${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == false)?.productDetails?.hourlyPrice ?? 0} ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.currencyNameL?.replaceAll("ال", "") ?? 0}) * ${LocaleKeys.droos_count.tr} (${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.productDetails?.totalHours ?? 0}) = ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.productDetails?.productPrice ?? 0} ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.currencyNameL?.replaceAll("ال", "") ?? 0}")
                      ? TextAlign.left
                      : TextAlign.right,
                  decoration: BoxDecoration(
                    color: ColorManager.grey5,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  triggerMode: TooltipTriggerMode.tap,
                  child: PrimaryText(
                    controller.orderType == 0
                        ? "${LocaleKeys.dars_price.tr} (${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == false)?.productDetails?.hourlyPrice ?? 0} ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == false)?.currencyNameL ?? 0})"
                        : "${LocaleKeys.dars_price.tr} (${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == false)?.productDetails?.hourlyPrice ?? 0} ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.currencyNameL?.replaceAll("ال", "") ?? 0}) * ${LocaleKeys.droos_count.tr} (${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.productDetails?.totalHours ?? 0}) = ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.productDetails?.productPrice ?? 0} ${controller.products.firstWhereOrNull((Product product) => product.productDetails != null && product.productDetails!.isActive == true && product.productDetails != null && product.productDetails!.isPackage == true)?.currencyNameL?.replaceAll("ال", "") ?? 0}",
                    fontSize: 12,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.fontColor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
