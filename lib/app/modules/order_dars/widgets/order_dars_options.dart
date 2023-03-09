import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/order_dars_controller.dart';

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
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryText(
                "${LocaleKeys.school_package.tr}*: ",
                fontSize: 11.2,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.red,
              ),
              SizedBox(
                width: Get.width * 0.60,
                child: PrimaryText(
                  LocaleKeys.school_package_description,
                  fontSize: 11,
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
    });
  }
}
