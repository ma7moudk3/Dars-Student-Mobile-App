import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/global_presentation/global_widgets/custom_snack_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import 'package:hessa_student/app/data/models/countries/result.dart' as country;
import '../../../data/models/governorates/result.dart' as governorate;
import '../../../data/models/localities/result.dart' as locality;

import '../../../../global_presentation/global_widgets/global_dropdown.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/add_new_address_controller.dart';

class AddNewAddressView extends GetView<AddNewAddressController> {
  const AddNewAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.add_new_address,
        leading: GestureDetector(
          onTap: () => Get.back(),
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.fontColor,
            size: 20,
          ),
        ),
        action: const SizedBox.shrink(),
      ),
      body: GetX<AddNewAddressController>(
          builder: (AddNewAddressController controller) {
        if (controller.isInternetConnected.value) {
          if (controller.isLoading.value == false) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 32.h),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Container(
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
                      child: GetBuilder<AddNewAddressController>(
                          builder: (AddNewAddressController controller) {
                        bool isGovernorateDropDownDisabled =
                            controller.governorates.result == null ||
                                controller.governorates.result!.isEmpty;
                        bool isLocalityDropDownDisabled =
                            controller.localities.result == null ||
                                controller.localities.result!.isEmpty;
                        return Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PrimaryText(
                                LocaleKeys.country,
                                fontSize: 14.sp,
                                fontWeight: FontWeightManager.softLight,
                                color: ColorManager.fontColor,
                              ),
                              SizedBox(height: 12.h),
                              PrimaryDropDown(
                                fontColor: ColorManager.fontColor5,
                                items: controller.countries.result != null &&
                                        controller.countries.result!.isNotEmpty
                                    ? (controller.countries.result!.map(
                                        (country.Result result) =>
                                            result.displayName ?? "")).toList()
                                    : [LocaleKeys.choose_country.tr],
                                hint: LocaleKeys.country,
                                value: controller.selectedCountry.displayName ??
                                    LocaleKeys.choose_country.tr,
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
                                onChanged: (String? country) async =>
                                    await controller.changeCountry(country),
                              ),
                              SizedBox(height: 12.h),
                              GetBuilder<AddNewAddressController>(builder:
                                  (AddNewAddressController controller) {
                                if (controller.isGovernorateDropDownLoading ==
                                    true) {
                                  return Shimmer.fromColors(
                                    baseColor:
                                        ColorManager.grey5.withOpacity(0.2),
                                    highlightColor:
                                        ColorManager.grey5.withOpacity(0.4),
                                    child: Container(
                                      width: Get.width,
                                      height: 55.h,
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: ColorManager.borderColor2,
                                          width: 1.2,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(
                                        LocaleKeys.city,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.fontColor,
                                      ),
                                      SizedBox(height: 12.h),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () async {
                                          if (isGovernorateDropDownDisabled &&
                                              (controller.selectedCountry.id ==
                                                      null ||
                                                  controller
                                                          .selectedCountry.id ==
                                                      -1)) {
                                            CustomSnackBar
                                                .showCustomInfoSnackBar(
                                              title: LocaleKeys.note.tr,
                                              message: LocaleKeys
                                                  .please_choose_country_first
                                                  .tr,
                                            );
                                          }
                                        },
                                        child: PrimaryDropDown(
                                          fontColor:
                                              isGovernorateDropDownDisabled
                                                  ? null
                                                  : ColorManager.fontColor5,
                                          items: controller
                                                      .governorates.result !=
                                                  null
                                              ? (controller.governorates.result!
                                                  .map((governorate.Result
                                                          result) =>
                                                      result.displayName ??
                                                      "")).toList()
                                              : [LocaleKeys.choose_city.tr],
                                          hint: LocaleKeys.city,
                                          value:
                                              controller.governorates.result !=
                                                          null &&
                                                      controller.governorates
                                                          .result!.isNotEmpty
                                                  ? controller
                                                          .governorates
                                                          .result![0]
                                                          .displayName ??
                                                      LocaleKeys.choose_city.tr
                                                  : LocaleKeys.choose_city.tr,
                                          isDisabled:
                                              isGovernorateDropDownDisabled,
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorManager.borderColor2,
                                              width: 1.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          width: Get.width,
                                          height: 50.h,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorManager.borderColor2,
                                              width: 1.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorManager.borderColor2,
                                              width: 1.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          onChanged: (String? governorate) =>
                                              controller.changeGovernorate(
                                                  governorate),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),
                              SizedBox(height: 12.h),
                              GetBuilder<AddNewAddressController>(builder:
                                  (AddNewAddressController controller) {
                                if (controller.isLocalityDropDownLoading ==
                                    true) {
                                  return Shimmer.fromColors(
                                    baseColor:
                                        ColorManager.grey5.withOpacity(0.2),
                                    highlightColor:
                                        ColorManager.grey5.withOpacity(0.4),
                                    child: Container(
                                      width: Get.width,
                                      height: 55.h,
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: ColorManager.borderColor2,
                                          width: 1.2,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(
                                        LocaleKeys.locality,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeightManager.softLight,
                                        color: ColorManager.fontColor,
                                      ),
                                      SizedBox(height: 12.h),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () async {
                                          if (isLocalityDropDownDisabled &&
                                              (controller.selectedGovernorate
                                                          .id ==
                                                      null ||
                                                  controller.selectedGovernorate
                                                          .id ==
                                                      -1)) {
                                            CustomSnackBar
                                                .showCustomInfoSnackBar(
                                              title: LocaleKeys.note.tr,
                                              message: LocaleKeys
                                                  .please_choose_governorate_first
                                                  .tr,
                                            );
                                          }
                                        },
                                        child: PrimaryDropDown(
                                          fontColor: isLocalityDropDownDisabled
                                              ? null
                                              : ColorManager.fontColor5,
                                          items: controller.localities.result !=
                                                      null &&
                                                  controller.localities.result!
                                                      .isNotEmpty
                                              ? (controller.localities.result!
                                                  .map((locality.Result
                                                          result) =>
                                                      result.displayName ??
                                                      "")).toList()
                                              : [LocaleKeys.choose_locality.tr],
                                          isDisabled:
                                              isLocalityDropDownDisabled,
                                          hint: LocaleKeys.locality,
                                          value: controller.selectedLocality
                                                  .displayName ??
                                              LocaleKeys.choose_locality.tr,
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorManager.borderColor2,
                                              width: 1.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          width: Get.width,
                                          height: 50.h,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorManager.borderColor2,
                                              width: 1.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorManager.borderColor2,
                                              width: 1.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          onChanged: (String? locality) =>
                                              controller
                                                  .changeLocality(locality),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),
                              SizedBox(height: 12.h),
                              PrimaryTextField(
                                cursorColor: ColorManager.primary,
                                focusNode:
                                    controller.addressDescriptionFocusNode,
                                titleFontSize: 14.sp,
                                titleFontWeight: FontWeightManager.softLight,
                                borderRadius: BorderRadius.circular(14),
                                controller:
                                    controller.addressDescriptionController,
                                title: LocaleKeys.address_description.tr,
                                hintText:
                                    LocaleKeys.enter_address_description.tr,
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
                                  borderSide:
                                      BorderSide(color: ColorManager.red),
                                ),
                                borderSide: BorderSide(
                                  color: controller
                                          .addressDescriptionFocusNode.hasFocus
                                      ? ColorManager.primary
                                      : ColorManager.borderColor2,
                                ),
                                validator: (String? addressDescription) =>
                                    controller.validateAddressDescription(
                                        addressDescription),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: PrimaryButton(
                      onPressed: () async {
                        if (controller.selectedCountry.id == null ||
                            controller.selectedCountry.id == -1) {
                          CustomSnackBar.showCustomInfoSnackBar(
                            title: LocaleKeys.note.tr,
                            message: LocaleKeys.please_choose_country_first.tr,
                          );
                        } else if (controller.selectedGovernorate.id == null ||
                            controller.selectedGovernorate.id == -1) {
                          CustomSnackBar.showCustomInfoSnackBar(
                            title: LocaleKeys.note.tr,
                            message:
                                LocaleKeys.please_choose_governorate_first.tr,
                          );
                        } else if (controller.selectedLocality.id == null ||
                            controller.selectedLocality.id == -1) {
                          CustomSnackBar.showCustomInfoSnackBar(
                            title: LocaleKeys.note.tr,
                            message: LocaleKeys.please_choose_locality.tr,
                          );
                        } else if (controller.formKey.currentState!
                            .validate()) {
                          if (await checkInternetConnection(timeout: 5)) {
                            // await controller.addNewAddress();
                          } else {
                            await Get.toNamed(Routes.CONNECTION_FAILED);
                          }
                        }
                      },
                      fontSize: 15.sp,
                      title: LocaleKeys.add_address.tr,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: SpinKitCircle(
                duration: const Duration(milliseconds: 1300),
                size: 50,
                color: ColorManager.primary,
              ),
            );
          }
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryText(
                LocaleKeys.check_your_internet_connection.tr,
                fontSize: 18.sp,
                fontWeight: FontWeightManager.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: (Get.height * 0.5).h,
                child: Lottie.asset(
                  LottiesManager.noInernetConnection,
                  animate: true,
                ),
              ),
              PrimaryButton(
                onPressed: () async {
                  await controller.checkInternet();
                },
                title: LocaleKeys.retry.tr,
                width: (Get.width * 0.5).w,
              ),
            ],
          );
        }
      }),
    );
  }
}
