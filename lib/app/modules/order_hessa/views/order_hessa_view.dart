import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/routes/app_pages.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_widgets/dotted_border.dart';
import 'package:hessa_student/global_presentation/global_widgets/global_dropdown.dart';

import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/typeahead/cupertino_flutter_typeahead.dart';
import '../controllers/order_hessa_controller.dart';
import '../data/models/teacher.dart';
import '../widgets/dependents_list_bottom_sheet_content.dart';
import '../widgets/hessa_date_time_picker_widget.dart';

class OrderHessaView extends GetView<OrderHessaController> {
  const OrderHessaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.order_hessa,
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
      ),
      body: GetBuilder<OrderHessaController>(
          builder: (OrderHessaController controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 26.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImagesManager.categoryIcon,
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 10.w),
                        PrimaryText(
                          LocaleKeys.order_new_hessa,
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.softLight,
                          color: ColorManager.fontColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    PrimaryText(
                      LocaleKeys.fill_the_student_form,
                      fontSize: 14.sp,
                      fontWeight: FontWeightManager.softLight,
                      color: ColorManager.fontColor7,
                    ),
                    SizedBox(height: 25.h),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
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
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              LocaleKeys.student_name,
                              fontSize: 14.sp,
                              fontWeight: FontWeightManager.softLight,
                              color: ColorManager.fontColor,
                            ),
                            SizedBox(height: 12.h),
                            GestureDetector(
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
                            SizedBox(height: 12.h),
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
                            SizedBox(height: 12.h),
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
                            SizedBox(height: 12.h),
                            PrimaryText(
                              LocaleKeys.hessa_duration,
                              fontSize: 14.sp,
                              fontWeight: FontWeightManager.softLight,
                              color: ColorManager.fontColor,
                            ),
                            SizedBox(height: 12.h),
                            PrimaryDropDown(
                              items: [LocaleKeys.choose_hessa_duration.tr],
                              hint: LocaleKeys.hessa_duration,
                              value: LocaleKeys.choose_hessa_duration.tr,
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
                              LocaleKeys.hessa_time_and_date,
                              fontSize: 14.sp,
                              fontWeight: FontWeightManager.softLight,
                              color: ColorManager.fontColor,
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: List.generate(2, (int index) {
                                return Container(
                                  width: Get.width * 0.40,
                                  margin: EdgeInsets.only(
                                    right: index == 1 ? 10.w : 0.w,
                                  ),
                                  child: HessaDateAndTimePickerWidget(
                                      index: index),
                                );
                              }),
                            ),
                            SizedBox(height: 12.h),
                            PrimaryTextField(
                              readOnly: true,
                              fontSize: 14.sp,
                              controller: controller.locationController,
                              title: LocaleKeys.location,
                              titleFontWeight: FontWeightManager.softLight,
                              onTap: () async {},
                              ifReadOnlyTextColor: ColorManager.fontColor7,
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                                color: ColorManager.yellow,
                                size: 22.sp,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                    color: ColorManager.borderColor2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:
                                    BorderSide(color: ColorManager.yellow),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(color: ColorManager.red),
                              ),
                              borderSide: BorderSide(
                                color: ColorManager.primary,
                              ),
                              hintText: LocaleKeys.choose_location,
                            ),
                            SizedBox(height: 12.h),
                            // PrimaryTextField(
                            //   onChanged: (String? searchValue) async {
                            //     controller.searchTeacher(
                            //         searchValue: searchValue ?? "");
                            //   },
                            //   fontSize: 14.sp,
                            //   controller: controller.teacherNameController,
                            //   title: LocaleKeys.teacher_name,
                            //   titleFontWeight: FontWeightManager.softLight,
                            //   onTap: () async {},
                            //   suffixIcon: Container(
                            //     margin: EdgeInsets.only(left: 10.w),
                            //     child: SvgPicture.asset(
                            //       ImagesManager.addTeacherIcon,
                            //       color: controller.teacherNameErrorIconColor,
                            //     ),
                            //   ),
                            //   borderRadius: BorderRadius.circular(14),
                            //   suffixIconConstraints: BoxConstraints(
                            //     minHeight: 20.h,
                            //     minWidth: 20.w,
                            //   ),
                            //   enabledBorder: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(14),
                            //     borderSide: BorderSide(
                            //         color: ColorManager.borderColor2),
                            //   ),
                            //   focusedBorder: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(14),
                            //     borderSide:
                            //         BorderSide(color: ColorManager.primary),
                            //   ),
                            //   errorBorder: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(14),
                            //     borderSide: BorderSide(color: ColorManager.red),
                            //   ),
                            //   borderSide: BorderSide(
                            //     color: ColorManager.primary,
                            //   ),
                            //   hintText: LocaleKeys.write_teacher_name,
                            //   validator: (String? teacherName) =>
                            //       controller.validateTeacherName(teacherName),
                            // ),
                            PrimaryText(
                              LocaleKeys.teacher_name,
                              fontSize: 14.sp,
                              fontWeight: FontWeightManager.softLight,
                              color: ColorManager.fontColor,
                            ),
                            SizedBox(height: 12.h),
                            CupertinoTypeAheadFormField(
                              hideOnError: true,
                              getImmediateSuggestions: true,
                              suggestionsBoxController:
                                  controller.suggestionsBoxController,
                              textFieldConfiguration:
                                  CupertinoTextFieldConfiguration(
                                controller: controller.teacherNameController,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: ColorManager.borderColor2,
                                  ),
                                ),
                                cursorColor: ColorManager.primary,
                                enableSuggestions: true,
                                maxLines: 1,
                                enableInteractiveSelection: true,
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 15.0, 20.0, 15.0),
                                style: TextStyle(
                                  color: ColorManager.fontColor,
                                  fontSize: 14.sp,
                                  fontFamily: FontConstants.fontFamily,
                                ),
                                suffix: Container(
                                  margin: EdgeInsets.only(left: 10.w),
                                  child: SvgPicture.asset(
                                    ImagesManager.addTeacherIcon,
                                    color: controller.teacherNameErrorIconColor,
                                  ),
                                ),
                                placeholder: LocaleKeys.write_teacher_name.tr,
                              ),
                              suggestionsCallback: (String searchValue) {
                                return controller
                                    .searchTeacher(searchValue: searchValue)
                                    .toList();
                              },
                              hideOnEmpty: true,
                              transitionBuilder:
                                  (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              itemBuilder:
                                  (BuildContext context, Teacher teacher) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(teacher.picture),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                width: 1,
                                                color: ColorManager.primary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    PrimaryText(
                                                      teacher.name,
                                                      color: ColorManager
                                                          .fontColor,
                                                    ),
                                                    const Spacer(),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: ColorManager
                                                              .orange,
                                                          size: 14.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 40.w,
                                                          child: PrimaryText(
                                                            "4.5",
                                                            color: ColorManager
                                                                .fontColor,
                                                            fontSize: 12.sp,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    PrimaryText(
                                                      teacher.subjects
                                                          .map((String
                                                                  subject) =>
                                                              subject
                                                                  .toString())
                                                          .join(", "),
                                                      color:
                                                          ColorManager.primary,
                                                      fontWeight:
                                                          FontWeightManager
                                                              .softLight,
                                                      fontSize: 11.sp,
                                                    ),
                                                    const Spacer(),
                                                    PrimaryText(
                                                      teacher.address,
                                                      color: ColorManager
                                                          .fontColor7,
                                                      fontSize: 12.sp,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Divider(
                                        color: ColorManager.borderColor3,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              noItemsFoundBuilder: (BuildContext context) {
                                return PrimaryText(
                                  LocaleKeys.no_teacher_found,
                                );
                              },
                              onSuggestionSelected: (Teacher teacher) {
                                controller.selectTeacher(teacher);
                              },
                              errorBuilder: (context, error) {
                                return PrimaryText(
                                  error.toString(),
                                  color: ColorManager.red,
                                );
                              },
                              validator: (String? teacherName) =>
                                  controller.validateTeacherName(teacherName),
                            ),
                            SizedBox(height: 12.h),
                            PrimaryTextField(
                              fontSize: 14.sp,
                              multiLines: true,
                              maxLines: 8,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 20.0, 20.0, 10.0),
                              controller: controller.notesController,
                              title: LocaleKeys.notes,
                              borderRadius: BorderRadius.circular(14),
                              titleFontWeight: FontWeightManager.softLight,
                              onTap: () async {},
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                    color: ColorManager.borderColor2),
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
                              hintText: LocaleKeys.write_down_you_notes,
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    PrimaryButton(
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          // await controller.orderHessa();
                        }
                      },
                      title: LocaleKeys.submit_form,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
