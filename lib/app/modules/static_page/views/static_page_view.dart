import 'package:hessa_student/app/core/helper_functions.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/static_page_controller.dart';

class StaticPageView extends GetView<StaticPageController> {
  const StaticPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.pageTitle,
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
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        ImagesManager.shieldIcon,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        controller.pageSubTitle,
                        fontSize: 16.sp,
                        fontWeight: FontWeightManager.light,
                      ),
                      SizedBox(height: 5.h),
                      PrimaryText(
                        "${LocaleKeys.last_updated.tr} 12/01/2023",
                        fontSize: 12.sp,
                        fontWeight: FontWeightManager.light,
                        color: ColorManager.grey,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              moreDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
