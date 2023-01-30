import 'package:hessa_student/app/modules/order_hessa/controllers/order_hessa_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';

class DependentsListBottomSheetContent extends GetView<OrderHessaController> {
  const DependentsListBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Container(
            height: (Get.height * 0.5).h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  LocaleKeys.dependents_list,
                  fontSize: 14.sp,
                  fontWeight: FontWeightManager.book,
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        itemCount: controller
                            .dependentsController.dummyDependents.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                        height: 22.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: ColorManager.primary,
                                            width: 2.w,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.check_rounded,
                                            color: ColorManager.primary,
                                            size: 13.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Container(
                                      width: 58.w,
                                      height: 65.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(controller
                                                  .dependentsController
                                                  .dummyDependents[index]
                                              ["dependent_image"]),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorManager.primary,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PrimaryText(
                                          controller.dependentsController
                                                  .dummyDependents[index]
                                              ["dependent_name"],
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                ImagesManager.classIcon),
                                            SizedBox(width: 5.w),
                                            PrimaryText(
                                              controller.dependentsController
                                                      .dummyDependents[index]
                                                  ["class"],
                                              fontSize: 14.sp,
                                              color: ColorManager.fontColor7,
                                              fontWeight:
                                                  FontWeightManager.softLight,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        ImagesManager.deleteIcon,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Visibility(
                                  visible: index !=
                                      (controller.dependentsController
                                              .dummyDependents.length -
                                          1),
                                  child: Divider(
                                    color: ColorManager.borderColor3,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      width: 265.w,
                      onPressed: () => Get.back(),
                      title: LocaleKeys.save.tr,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Get.toNamed(
                          Routes.ADD_NEW_DEPENDENT,
                        );
                      },
                      child: Container(
                        width: 48.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: ColorManager.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add_rounded,
                            color: ColorManager.white,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
