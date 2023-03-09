import 'package:hessa_student/generated/locales.g.dart';

import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/add_payment_way_controller.dart';

class PaymentWaysBottomSheetContent extends GetView<AddPaymentWayController> {
  const PaymentWaysBottomSheetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPaymentWayController>(
        builder: (AddPaymentWayController controller) {
      return Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 26.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorManager.borderColor3,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                PrimaryText(
                  LocaleKeys.choosing_card_type.tr,
                  fontSize: 16,
                  fontWeight: FontWeightManager.light,
                ),
                SizedBox(height: 10.h),
                ListView.builder(
                  itemCount: controller.cardTypes.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        controller.selectCardType(index);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    controller.cardTypes[index]["image"],
                                  ),
                                  SizedBox(width: 12.w),
                                  PrimaryText(
                                    controller.cardTypes[index]["title"],
                                    fontSize: 16,
                                    fontWeight: FontWeightManager.softLight,
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 21.w,
                                    height: 21.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: controller.cardType != null &&
                                                controller.cardType ==
                                                    controller.cardTypes[index]
                                                        ["type"]
                                            ? ColorManager.primary
                                            : ColorManager.fontColor6,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: controller.cardType != null &&
                                            controller.cardType ==
                                                controller.cardTypes[index]
                                                    ["type"]
                                        ? Center(
                                            child: Icon(
                                              Icons.check_rounded,
                                              color: ColorManager.primary,
                                              size: 16,
                                            ),
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                            moreDivider(thickness: 1.5),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: PrimaryButton(
                    onPressed: () async {
                      Get.back();
                    },
                    title: LocaleKeys.save.tr,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
