import 'package:flutter/cupertino.dart';
import 'package:time_range/time_range.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/order_hessa_controller.dart';

class HessaDateAndTimePickerWidget extends GetView<OrderHessaController> {
  const HessaDateAndTimePickerWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      readOnly: true,
      fontSize: 14.5.sp,
      controller: index == 0
          ? controller.hessaDateController
          : controller.hessaTimeController,
      title: "",
      contentPadding: index == 0
          ? const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0)
          : const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      onTap: () async {
        if (index == 0) {
          DateTime maxdate = DateTime(
            DateTime.now().year + 1, // next year
            DateTime.now().month,
            DateTime.now().day,
          );
          DateTime mindate = DateTime(
            DateTime.now().year, // current year
            DateTime.now().month,
            DateTime.now().day,
          );
          await Get.bottomSheet(
            SizedBox(
              height: 200.h,
              child: CupertinoDatePicker(
                backgroundColor: ColorManager.white,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: controller.hessaDate,
                maximumDate: maxdate,
                minimumDate: mindate,
                onDateTimeChanged: (DateTime date) {
                  controller.changeHessaDate(date);
                },
              ),
            ),
            backgroundColor: ColorManager.white,
          );
        } else {
          await Get.bottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 26.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.borderColor3),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    height: Get.height * 0.3.h,
                    child: TimeRange(
                      fromTitle: PrimaryText(
                        "${LocaleKeys.from.tr}:",
                        fontSize: 16.sp,
                        color: ColorManager.fontColor,
                      ),
                      toTitle: PrimaryText(
                        "${LocaleKeys.to.tr}:",
                        fontSize: 16.sp,
                        color: ColorManager.fontColor,
                      ),
                      titlePadding: 20,
                      textStyle: TextStyle(
                        color: ColorManager.fontColor5,
                        fontSize: (14).sp,
                        fontWeight: FontWeightManager.softLight,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      activeTextStyle: TextStyle(
                        color: ColorManager.white,
                        fontSize: (14).sp,
                        fontWeight: FontWeightManager.bold,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      borderColor: ColorManager.borderColor2,
                      backgroundColor: Colors.transparent,
                      activeBackgroundColor: ColorManager.yellow,
                      firstTime: const TimeOfDay(hour: 8, minute: 30),
                      lastTime: const TimeOfDay(hour: 21, minute: 30),
                      timeStep: 10,
                      initialRange: controller.hessaTimeRange,
                      activeBorderColor: ColorManager.fontColor,
                      timeBlock: 30,
                      onRangeCompleted: (TimeRangeResult? range) {
                        // if (Get.isBottomSheetOpen!) {
                        //   Get.back();
                        // }
                        controller.changeHessaTime(range);
                      },
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: ColorManager.white,
          );
        }
      },
      ifReadOnlyTextColor: ColorManager.fontColor7,
      prefixIcon: index == 0
          ? Container(
              margin: EdgeInsets.only(left: 5.w),
              child: SvgPicture.asset(
                ImagesManager.calendarIcon,
              ),
            )
          // ? Icon(
          //     Icons.calendar_month_rounded,
          //     color: ColorManager.yellow,
          //     size: 22.sp,
          //   )
          : Container(
              margin: EdgeInsets.all(5.w),
              child: Icon(
                Icons.access_time,
                color: ColorManager.yellow,
                size: 22.sp,
              ),
            ),
      prefixIconConstraints: index == 0
          ? BoxConstraints(
              minWidth: 21.w,
              minHeight: 21.h,
            )
          : BoxConstraints(
              minWidth: 25.w,
              minHeight: 25.h,
            ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: ColorManager.borderColor2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: ColorManager.yellow),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: ColorManager.red),
      ),
      borderSide: BorderSide(
        color: ColorManager.primary,
      ),
      hintText: index == 0
          ? LocaleKeys.choose_hessa_date
          : LocaleKeys.choose_hessa_time,
    );
  }
}
