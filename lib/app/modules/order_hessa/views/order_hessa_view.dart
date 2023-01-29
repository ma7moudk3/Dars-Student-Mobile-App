import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_widgets/global_dropdown.dart';

import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/typeahead/cupertino_flutter_typeahead.dart';
import '../controllers/order_hessa_controller.dart';
import '../data/models/teacher.dart';
import '../widgets/add_student_widget.dart';
import '../widgets/hessa_date_time_picker_widget.dart';
import '../widgets/order_hessa_options.dart';

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
                            const AddStudentOrderHessaWidget(),
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
                            const OrderHessaOptions(),
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
