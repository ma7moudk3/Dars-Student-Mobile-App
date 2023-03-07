import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/dotted_border.dart';
import '../../../constants/exports.dart';
import '../controllers/order_dars_controller.dart';
import 'dependents_list_bottom_sheet_content.dart';

class AddStudentOrderDarsWidget extends GetView<OrderDarsController> {
  const AddStudentOrderDarsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDarsController>(
        builder: (OrderDarsController controller) {
      return GestureDetector(
        onTap: () async {
          if (controller.selectedStudents.isEmpty) {
            await Get.bottomSheet(
              backgroundColor: ColorManager.white,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              const DependentsListBottomSheetContent(),
            );
          }
        },
        child: DottedBorder(
          color: ColorManager.borderColor2,
          strokeWidth: 1.2,
          customPath: (size) {
            double cardRadius = 14;
            return Path()
              ..moveTo(cardRadius, 0)
              ..lineTo(size.width - cardRadius, 0)
              ..arcToPoint(Offset(size.width, cardRadius),
                  radius: Radius.circular(cardRadius))
              ..lineTo(size.width, size.height - cardRadius)
              ..arcToPoint(Offset(size.width - cardRadius, size.height),
                  radius: Radius.circular(cardRadius))
              ..lineTo(cardRadius, size.height)
              ..arcToPoint(Offset(0, size.height - cardRadius),
                  radius: Radius.circular(cardRadius))
              ..lineTo(0, cardRadius)
              ..arcToPoint(
                Offset(cardRadius, 0),
                radius: Radius.circular(cardRadius),
              );
          },
          dashPattern: const [8, 4],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: controller.selectedStudents.isEmpty ? 50.h : null,
              width: Get.width,
              padding: controller.selectedStudents.isEmpty
                  ? null
                  : EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              child: controller.selectedStudents.isEmpty
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: ColorManager.fontColor6,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_rounded,
                                color: ColorManager.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          PrimaryText(
                            LocaleKeys.add_student,
                            fontSize: 14.sp,
                            fontWeight: FontWeightManager.softLight,
                            color: ColorManager.fontColor,
                          ),
                        ],
                      ),
                    )
                  : Wrap(
                      spacing: 5.w,
                      children: List.generate(
                          controller.selectedStudents.length, (int index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Chip(
                              backgroundColor:
                                  ColorManager.primary.withOpacity(0.10),
                              onDeleted: () {
                                controller.removeStudent(
                                    studentItem:
                                        controller.selectedStudents[index]);
                              },
                              deleteIconColor: ColorManager.primary,
                              deleteButtonTooltipMessage: LocaleKeys.delete.tr,
                              labelPadding: EdgeInsets.only(right: 5.w),
                              deleteIcon: Icon(
                                Icons.close,
                                color: ColorManager.primary,
                                size: 14.sp,
                              ),
                              label: PrimaryText(
                                controller.selectedStudents[index]
                                        .requesterStudent?.name ??
                                    "",
                                color: ColorManager.primary,
                                fontSize: 12.sp,
                              ),
                            ),
                            Visibility(
                              visible: index == 0, // only the first time
                              child: Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Spacer(),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        await Get.bottomSheet(
                                          backgroundColor: ColorManager.white,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          const DependentsListBottomSheetContent(),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        margin: EdgeInsets.only(left: 10.w),
                                        child: SvgPicture.asset(
                                          ImagesManager.addPersonIcon,
                                          color: controller
                                              .teacherNameErrorIconColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                    ),
            ),
          ),
        ),
      );
    });
  }
}
