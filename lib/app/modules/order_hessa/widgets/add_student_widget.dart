import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/dotted_border.dart';
import '../../../constants/exports.dart';
import '../../../routes/app_pages.dart';
import '../controllers/order_hessa_controller.dart';
import 'dependents_list_bottom_sheet_content.dart';

class AddStudentOrderHessaWidget extends GetView<OrderHessaController> {
  const AddStudentOrderHessaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (controller.dependentsController
            .dummyDependents.isNotEmpty) {
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
        } else {
          await Get.toNamed(Routes.DEPENDENTS);
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
            ..lineTo(
                size.width, size.height - cardRadius)
            ..arcToPoint(
                Offset(size.width - cardRadius,
                    size.height),
                radius: Radius.circular(cardRadius))
            ..lineTo(cardRadius, size.height)
            ..arcToPoint(
                Offset(0, size.height - cardRadius),
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
          child: SizedBox(
            height: 50.h,
            width: Get.width,
            child: Center(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: ColorManager.fontColor6,
                      borderRadius:
                          BorderRadius.circular(10),
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
                    fontWeight:
                        FontWeightManager.softLight,
                    color: ColorManager.fontColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}