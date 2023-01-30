import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
      focusNode: index == 0
          ? controller.hessaDateFocusNode
          : controller.hessaTimeFocusNode,
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
            isScrollControlled: true,
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
                    height: Get.height * 0.5.h,
                    child: SfDateRangePicker(
                      onSelectionChanged: (DateRangePickerSelectionChangedArgs
                          dateRangePickerSelectionChangedArgs) {
                        controller.changeHessaDate(
                            dateRangePickerSelectionChangedArgs);
                      },
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                          showTrailingAndLeadingDates: true),
                      minDate: mindate,
                      enableMultiView: false,
                      selectionMode: DateRangePickerSelectionMode.single,
                      allowViewNavigation: true,
                      view: DateRangePickerView.month,
                      enablePastDates: false,
                      maxDate: maxdate,
                      showNavigationArrow: true,
                      todayHighlightColor:
                          ColorManager.primary.withOpacity(0.1),
                      selectionShape: DateRangePickerSelectionShape.rectangle,
                      selectionColor: ColorManager.primary.withOpacity(0.15),
                      selectionRadius: 20,
                      selectionTextStyle: TextStyle(
                        color: ColorManager.primary,
                        fontSize: (14).sp,
                        fontWeight: FontWeightManager.softLight,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      backgroundColor: ColorManager.white,
                      controller: controller.hessaDateRangeController,
                      navigationMode: DateRangePickerNavigationMode.snap,
                      initialDisplayDate: controller.hessaDate,
                      headerStyle: DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          color: ColorManager.fontColor,
                          fontSize: (14).sp,
                          fontWeight: FontWeightManager.light,
                          fontFamily: FontConstants.fontFamily,
                        ),
                      ),
                      rangeTextStyle: TextStyle(
                        color: ColorManager.fontColor,
                        fontSize: (14).sp,
                        fontWeight: FontWeightManager.light,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(
                          color: ColorManager.fontColor,
                          fontSize: (14).sp,
                          fontWeight: FontWeightManager.softLight,
                          fontFamily: FontConstants.fontFamily,
                        ),
                        todayTextStyle: TextStyle(
                          color: ColorManager.fontColor,
                          fontSize: (14).sp,
                          fontWeight: FontWeightManager.softLight,
                          fontFamily: FontConstants.fontFamily,
                        ),
                        todayCellDecoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledDatesTextStyle: TextStyle(
                          color: ColorManager.grey,
                          fontSize: (14).sp,
                          fontWeight: FontWeightManager.softLight,
                          fontFamily: FontConstants.fontFamily,
                        ),
                        cellDecoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: PrimaryButton(
                      onPressed: () => Get.back(),
                      title: LocaleKeys.save.tr,
                    ),
                  )
                ],
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                    ),
                    height: Get.height * 0.28.h,
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
                  GetBuilder<OrderHessaController>(
                      builder: (OrderHessaController controller) {
                    return Visibility(
                      visible: controller.hessaDateController.text.isNotEmpty,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  controller.hessaTimeController.text.isEmpty
                                      ? LocaleKeys.chosen_hessa_date.tr
                                      : LocaleKeys
                                          .chosen_hessa_time_and_date.tr,
                                  color: ColorManager.fontColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeightManager.softLight,
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 5.w),
                                          child: SvgPicture.asset(
                                            ImagesManager.calendarIcon,
                                            color: controller
                                                .hessaDateErrorIconColor,
                                          ),
                                        ),
                                        PrimaryText(
                                          controller.hessaDateController.text,
                                          color: ColorManager.grey,
                                          fontSize: 14.sp,
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: controller
                                          .hessaTimeController.text.isNotEmpty,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 5.w),
                                          Container(
                                            margin: EdgeInsets.all(5.w),
                                            child: Icon(
                                              Icons.access_time,
                                              color: controller
                                                      .hessaTimeErrorIconColor ??
                                                  ColorManager.yellow,
                                              size: 22.sp,
                                            ),
                                          ),
                                          PrimaryText(
                                            controller.hessaTimeController.text,
                                            color: ColorManager.grey,
                                            fontSize: 14.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    );
                  }),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                    child: PrimaryButton(
                      onPressed: () => Get.back(),
                      title: LocaleKeys.save.tr,
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
                color: controller.hessaDateErrorIconColor,
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
                color:
                    controller.hessaTimeErrorIconColor ?? ColorManager.yellow,
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
      validator: index == 0
          ? ((String? hessaDate) => controller.validateHessaDate(hessaDate))
          : ((String? hessaTime) => controller.validateHessaTime(hessaTime)),
    );
  }
}
