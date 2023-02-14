import '../../../../../generated/locales.g.dart';
import '../../../../constants/exports.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/dependents_controller.dart';

class NoDependentsWidget extends GetView<DependentsController> {
  const NoDependentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}
