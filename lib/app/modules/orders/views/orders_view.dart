import 'package:hessa_student/app/constants/constants.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../../home/widgets/order_widget.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(() => OrdersController());
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.order_hessa,
        action: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            await Get.toNamed(Routes.HESSA_DETAILS, arguments: {
              "hessa_type": HessaType.studyingPackage, // temporary
            });
          },
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: ColorManager.primary,
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.add_rounded,
                color: ColorManager.primary,
                size: 15.sp,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              ListView.builder(
                itemCount: 9 + 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 9) {
                    return SizedBox(height: 20.h);
                  }
                  return OrderWidget(isFirst: index == 0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
