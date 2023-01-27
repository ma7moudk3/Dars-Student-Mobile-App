import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dependents_controller.dart';

class DependentsView extends GetView<DependentsController> {
  const DependentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<DependentsController>(
          builder: (DependentsController controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
              title: LocaleKeys.dependents_title,
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImagesManager.dependents,
                      width: Get.width,
                      height: 230.h,
                    ),
                    PrimaryText(
                      LocaleKeys.there_are_no_dependents,
                      fontSize: 18.sp,
                      fontWeight: FontWeightManager.softLight,
                    ),
                    SizedBox(height: 8.h),
                    PrimaryText(
                      LocaleKeys.you_can_add_new_dependent,
                      fontSize: 16.sp,
                      color: ColorManager.fontColor7,
                      fontWeight: FontWeightManager.softLight,
                    ),
                    SizedBox(height: 32.h),
                    GestureDetector(
                      onTap: () async {
                        await Get.toNamed(Routes.ADD_NEW_DEPENDENT);
                      },
                      child: Container(
                        width: 240.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  color: ColorManager.primary,
                                  border: Border.all(
                                    color: ColorManager.white,
                                    width: 2.w,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: ColorManager.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              PrimaryText(
                                LocaleKeys.add_dependent_or_son,
                                color: ColorManager.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeightManager.light,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
