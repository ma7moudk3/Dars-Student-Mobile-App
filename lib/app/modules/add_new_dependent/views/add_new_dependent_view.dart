import 'package:hessa_student/app/constants/exports.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/global_dropdown.dart';
import '../controllers/add_new_dependent_controller.dart';

class AddNewDependentView extends GetView<AddNewDependentController> {
  const AddNewDependentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddNewDependentController>(
          builder: (AddNewDependentController controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: LocaleKeys.add_dependent,
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
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Container(
                  width: Get.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        offset: Offset(0, 1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: GetBuilder<AddNewDependentController>(
                      builder: (AddNewDependentController controller) {
                    return Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryTextField(
                            fontSize: 14.sp,
                            controller: controller.nameController,
                            title: LocaleKeys.name,
                            focusNode: controller.nameFocusNode,
                            titleFontWeight: FontWeightManager.softLight,
                            onTap: () async {},
                            prefixIcon: Container(
                              margin: EdgeInsets.symmetric(horizontal: 14.w),
                              child: SvgPicture.asset(
                                ImagesManager.dependentIcon,
                                width: 22.w,
                                height: 22.h,
                                color: controller.nameIconErrorColor ??
                                    (controller.nameFocusNode.hasFocus
                                        ? (controller.nameIconErrorColor ??
                                            ColorManager.primary)
                                        : ColorManager.primaryLight),
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 22.h,
                              minWidth: 22.w,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: ColorManager.borderColor2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            borderRadius: BorderRadius.circular(14),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: ColorManager.red),
                            ),
                            borderSide: BorderSide(
                              color: ColorManager.primary,
                            ),
                            hintText: LocaleKeys.write_dependent_name,
                            validator: (String? dependentName) =>
                                controller.validateDependentName(dependentName),
                          ),
                          SizedBox(height: 12.h),
                          PrimaryTextField(
                            fontSize: 14.sp,
                            readOnly: true,
                            ifReadOnlyTextColor: ColorManager.fontColor7,
                            controller: controller.uplpoadPictureFileController,
                            title: LocaleKeys.person_picture,
                            focusNode: controller.uplpoadPictureFileFocusNode,
                            titleFontWeight: FontWeightManager.softLight,
                            onTap: () async {},
                            suffixIcon: Container(
                              margin: EdgeInsets.symmetric(horizontal: 14.w),
                              child: SvgPicture.asset(
                                ImagesManager.uploadFileIcon,
                                width: 22.w,
                                height: 22.h,
                                color: controller
                                        .uplpoadPictureFileIconErrorColor ??
                                    (controller.uplpoadPictureFileFocusNode
                                            .hasFocus
                                        ? (controller
                                                .uplpoadPictureFileIconErrorColor ??
                                            ColorManager.primary)
                                        : ColorManager.primaryLight),
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minHeight: 22.h,
                              minWidth: 22.w,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: ColorManager.borderColor2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: ColorManager.red),
                            ),
                            borderSide: BorderSide(
                              color: ColorManager.primary,
                            ),
                            hintText: LocaleKeys.upload_picture_or_pdf,
                          ),
                          SizedBox(height: 12.h),
                          PrimaryTextField(
                            fontSize: 14.sp,
                            readOnly: true,
                            ifReadOnlyTextColor: ColorManager.fontColor7,
                            controller: controller.dateOfBirthController,
                            title: LocaleKeys.date_of_birth,
                            borderRadius: BorderRadius.circular(14),
                            focusNode: controller.dateOfBirthFocusNode,
                            titleFontWeight: FontWeightManager.softLight,
                            onTap: () async {
                              DateTime maxdate = DateTime(
                                DateTime.now().year - 10,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                          onSelectionChanged:
                                              (DateRangePickerSelectionChangedArgs
                                                  dateRangePickerSelectionChangedArgs) {
                                            controller.changeDate(
                                                dateRangePickerSelectionChangedArgs);
                                          },
                                          monthViewSettings:
                                              const DateRangePickerMonthViewSettings(
                                                  showTrailingAndLeadingDates:
                                                      true),
                                          enableMultiView: false,
                                          selectionMode:
                                              DateRangePickerSelectionMode
                                                  .single,
                                          allowViewNavigation: true,
                                          view: DateRangePickerView.month,
                                          enablePastDates: true,
                                          maxDate: maxdate,
                                          showNavigationArrow: true,
                                          todayHighlightColor: ColorManager
                                              .primary
                                              .withOpacity(0.1),
                                          selectionShape:
                                              DateRangePickerSelectionShape
                                                  .rectangle,
                                          selectionColor: ColorManager.primary
                                              .withOpacity(0.15),
                                          selectionRadius: 20,
                                          selectionTextStyle: TextStyle(
                                            color: ColorManager.primary,
                                            fontSize: (14).sp,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            fontFamily:
                                                FontConstants.fontFamily,
                                          ),
                                          backgroundColor: ColorManager.white,
                                          controller: controller
                                              .dateOfBirthRangeController,
                                          navigationMode:
                                              DateRangePickerNavigationMode
                                                  .snap,
                                          initialDisplayDate:
                                              controller.dateOfBirth,
                                          headerStyle:
                                              DateRangePickerHeaderStyle(
                                            textAlign: TextAlign.center,
                                            textStyle: TextStyle(
                                              color: ColorManager.fontColor,
                                              fontSize: (14).sp,
                                              fontWeight:
                                                  FontWeightManager.light,
                                              fontFamily:
                                                  FontConstants.fontFamily,
                                            ),
                                          ),
                                          rangeTextStyle: TextStyle(
                                            color: ColorManager.fontColor,
                                            fontSize: (14).sp,
                                            fontWeight: FontWeightManager.light,
                                            fontFamily:
                                                FontConstants.fontFamily,
                                          ),
                                          monthCellStyle:
                                              DateRangePickerMonthCellStyle(
                                            textStyle: TextStyle(
                                              color: ColorManager.fontColor,
                                              fontSize: (14).sp,
                                              fontWeight:
                                                  FontWeightManager.softLight,
                                              fontFamily:
                                                  FontConstants.fontFamily,
                                            ),
                                            todayTextStyle: TextStyle(
                                              color: ColorManager.fontColor,
                                              fontSize: (14).sp,
                                              fontWeight:
                                                  FontWeightManager.softLight,
                                              fontFamily:
                                                  FontConstants.fontFamily,
                                            ),
                                            todayCellDecoration: BoxDecoration(
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            disabledDatesTextStyle: TextStyle(
                                              color: ColorManager.grey,
                                              fontSize: (14).sp,
                                              fontWeight:
                                                  FontWeightManager.softLight,
                                              fontFamily:
                                                  FontConstants.fontFamily,
                                            ),
                                            cellDecoration: BoxDecoration(
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            PrimaryText(
                                              "${LocaleKeys.note.tr}: ",
                                              color: ColorManager.red,
                                            ),
                                            PrimaryText(
                                              LocaleKeys.check_dependent_dob,
                                              fontWeight:
                                                  FontWeightManager.softLight,
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
                                ),
                                backgroundColor: ColorManager.white,
                              );
                            },
                            suffixIcon: Container(
                              margin: EdgeInsets.symmetric(horizontal: 14.w),
                              child: SvgPicture.asset(
                                ImagesManager.calendarIcon,
                                width: 22.w,
                                height: 22.h,
                                color: controller.dateOfBirthIconErrorColor ??
                                    (controller.dateOfBirthFocusNode.hasFocus
                                        ? (controller
                                                .dateOfBirthIconErrorColor ??
                                            ColorManager.primary)
                                        : ColorManager.primaryLight),
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minHeight: 22.h,
                              minWidth: 22.w,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: ColorManager.borderColor2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: ColorManager.red),
                            ),
                            borderSide: BorderSide(
                              color: ColorManager.primary,
                            ),
                            hintText: LocaleKeys.choose_date_of_birth,
                            validator: (String? dateOfBirth) =>
                                controller.validateDateOfBirth(dateOfBirth),
                          ),
                          SizedBox(height: 12.h),
                          PrimaryText(
                            LocaleKeys.studying_class,
                            fontSize: 14.sp,
                            fontWeight: FontWeightManager.softLight,
                            color: ColorManager.fontColor,
                          ),
                          SizedBox(height: 12.h),
                          PrimaryDropDown(
                            items: [LocaleKeys.choose_studying_class.tr],
                            hint: LocaleKeys.studying_class,
                            value: LocaleKeys.choose_studying_class.tr,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.borderColor2,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: Get.width,
                            height: 50.h,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.borderColor2,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.borderColor2,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onChanged: (String? value) {},
                          ),
                          SizedBox(height: 12.h),
                          PrimaryText(
                            LocaleKeys.studying_subject,
                            fontSize: 14.sp,
                            fontWeight: FontWeightManager.softLight,
                            color: ColorManager.fontColor,
                          ),
                          SizedBox(height: 12.h),
                          PrimaryDropDown(
                            items: [LocaleKeys.choose_studying_subject.tr],
                            hint: LocaleKeys.studying_subject,
                            value: LocaleKeys.choose_studying_subject.tr,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.borderColor2,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: Get.width,
                            height: 50.h,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.borderColor2,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.borderColor2,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onChanged: (String? value) {},
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              PrimaryText(
                                LocaleKeys.gender,
                                fontSize: 14.sp,
                                fontWeight: FontWeightManager.softLight,
                                color: ColorManager.fontColor,
                              ),
                              SizedBox(width: 5.w),
                              Row(
                                children: List.generate(2, (int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.changeDependentGender(index);
                                    },
                                    child: Container(
                                      width: 80.w,
                                      height: 40.h,
                                      margin: EdgeInsets.only(
                                        left: index == 0 ? 10.w : 0.w,
                                        right: index == 1 ? 0 : 10.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            controller.dependentGender == index
                                                ? ColorManager.primary
                                                : ColorManager.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: controller.dependentGender !=
                                                index
                                            ? Border.all(
                                                color:
                                                    ColorManager.borderColor2,
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
                                          color: controller.dependentGender ==
                                                  index
                                              ? ColorManager.white
                                              : ColorManager.borderColor,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: PrimaryButton(
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      // await controller.orderHessa();
                    }
                  },
                  fontSize: 15.sp,
                  title: LocaleKeys.confirm,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
