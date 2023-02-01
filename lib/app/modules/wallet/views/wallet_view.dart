import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/visa_card_widget.dart';
import '../widgets/wallet_grid_view_item_widget.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.wallet,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.fontColor,
            size: 20,
          ),
        ),
        action: const SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    WalletGridViewItem(
                      imagePath: ImagesManager.moneyIcon,
                      title: LocaleKeys.paid_amounts.tr,
                      cash: 400,
                      onTap: () async {
                        await Get.toNamed(Routes.ORDER_HESSA);
                      },
                      iconBackgroundColor: ColorManager.yellow,
                    ),
                    WalletGridViewItem(
                      imagePath: ImagesManager.walletIcon,
                      title: LocaleKeys.my_hessa_balance.tr,
                      cash: 950.6,
                      onTap: () async {
                        await Get.toNamed(Routes.HESSA_TEACHERS);
                      },
                      iconBackgroundColor: ColorManager.primary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22.h),
              PrimaryText(
                LocaleKeys.payment_ways.tr,
                fontSize: 16.sp,
                fontWeight: FontWeightManager.light,
                color: ColorManager.fontColor,
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    const VisaCardWidget(),
                    SizedBox(height: 16.h),
                    Container(
                      width: Get.width,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: ColorManager.white,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_rounded,
                                color: ColorManager.white,
                                size: 14,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          PrimaryText(
                            LocaleKeys.add_new_payment_method.tr,
                            fontSize: 14.sp,
                            fontWeight: FontWeightManager.softLight,
                            color: ColorManager.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    LocaleKeys.payments.tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeightManager.light,
                    color: ColorManager.fontColor,
                  ),
                  Container(
                    width: 82.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorManager.borderColor2,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: PrimaryText(
                        LocaleKeys.view_all.tr,
                        fontSize: 12.sp,
                        fontWeight: FontWeightManager.light,
                        color: ColorManager.fontColor7,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(14),
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
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PrimaryText(
                                  '20',
                                  fontSize: 12.sp,
                                  color: ColorManager.primary,
                                  fontWeight: FontWeightManager.light,
                                ),
                                PrimaryText(
                                  'ديسمبر',
                                  fontSize: 11.5.sp,
                                  color: ColorManager.primary,
                                  fontWeight: FontWeightManager.softLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              "رياضيات مستوى مبتدئ",
                              fontSize: 14.sp,
                              fontWeight: FontWeightManager.softLight,
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              height: 24.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                color: ColorManager.red.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: PrimaryText(
                                  "${LocaleKeys.remaining.tr} 150 ${LocaleKeys.shekel.tr}",
                                  fontSize: 12.sp,
                                  color: ColorManager.red,
                                  fontWeight: FontWeightManager.softLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        PrimaryText(
                          "400 ₪",
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
