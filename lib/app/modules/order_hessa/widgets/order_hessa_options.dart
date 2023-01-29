import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/order_hessa_controller.dart';

class OrderHessaOptions extends GetView<OrderHessaController> {
  const OrderHessaOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHessaController>(
      builder: (OrderHessaController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              LocaleKeys.session_way,
              fontSize: 14.sp,
              fontWeight: FontWeightManager.softLight,
              color: ColorManager.fontColor,
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
            PrimaryText(
              LocaleKeys.teacher_gender,
              fontSize: 14.sp,
              fontWeight: FontWeightManager.softLight,
              color: ColorManager.fontColor,
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
            PrimaryText(
              LocaleKeys.order_type,
              fontSize: 14.sp,
              fontWeight: FontWeightManager.softLight,
              color: ColorManager.fontColor,
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
                            ? LocaleKeys.one_hessa
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
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryText(
                  "${LocaleKeys.school_package.tr}*: ",
                  fontSize: 12.sp,
                  fontWeight: FontWeightManager.softLight,
                  color: ColorManager.red,
                ),
                SizedBox(
                  width: Get.width * 0.6,
                  child: PrimaryText(
                    LocaleKeys.school_package_description,
                    fontSize: 11.sp,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.fontColor7,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}