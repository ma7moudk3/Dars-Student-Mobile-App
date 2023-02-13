import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/add_new_dependent_controller.dart';

class DateOfBirthBottomSheetContent extends GetView<AddNewDependentController> {
  const DateOfBirthBottomSheetContent({
    Key? key,
    required this.maxdate,
  }) : super(key: key);

  final DateTime maxdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                // controller.changeDate(dateRangePickerSelectionChangedArgs);
              },
              monthViewSettings: const DateRangePickerMonthViewSettings(
                  showTrailingAndLeadingDates: true),
              enableMultiView: false,
              selectionMode: DateRangePickerSelectionMode.single,
              allowViewNavigation: true,
              view: DateRangePickerView.month,
              enablePastDates: true,
              maxDate: maxdate,
              showNavigationArrow: true,
              todayHighlightColor: ColorManager.primary.withOpacity(0.1),
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
              controller: controller.dateOfBirthRangeController,
              navigationMode: DateRangePickerNavigationMode.snap,
              initialDisplayDate: controller.dateOfBirth,
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
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PrimaryText(
                  "${LocaleKeys.note.tr}: ",
                  color: ColorManager.red,
                ),
                PrimaryText(
                  LocaleKeys.check_dependent_dob,
                  fontWeight: FontWeightManager.softLight,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
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
    );
  }
}
