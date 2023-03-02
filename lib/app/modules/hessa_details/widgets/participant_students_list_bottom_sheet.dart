import 'package:hessa_student/app/modules/hessa_details/controllers/hessa_details_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../data/models/classes/item.dart';

class ParticipantListBottomSheetContent
    extends GetView<HessaDetailsController> {
  const ParticipantListBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 26.w,
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorManager.borderColor3,
              ),
            ),
          ),
          Container(
            height: (Get.height * 0.5).h,
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  LocaleKeys.participant_students,
                  fontSize: 16,
                  fontWeight: FontWeightManager.light,
                ),
                SizedBox(height: 15.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        itemCount: controller
                                .hessaOrderDetails.result?.students?.length ??
                            0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10.w),
                                    Container(
                                      width: 58.w,
                                      height: 65.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage(ImagesManager.avatar),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorManager.primary,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PrimaryText(
                                          controller.hessaOrderDetails.result
                                                  ?.students?[index].name ??
                                              "",
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                ImagesManager.classIcon),
                                            SizedBox(width: 5.w),
                                            PrimaryText(
                                              controller.classes.result !=
                                                          null &&
                                                      controller.classes.result!
                                                              .items !=
                                                          null
                                                  ? controller.classes.result!
                                                              .items!
                                                              .firstWhereOrNull((Item level) =>
                                                                  level.id ==
                                                                  controller
                                                                      .hessaOrderDetails
                                                                      .result
                                                                      ?.students?[
                                                                          index]
                                                                      .levelId) !=
                                                          null
                                                      ? controller.classes
                                                              .result!.items!
                                                              .firstWhereOrNull(
                                                                  (Item level) =>
                                                                      level.id ==
                                                                      controller
                                                                          .hessaOrderDetails
                                                                          .result
                                                                          ?.students?[index]
                                                                          .levelId)!
                                                              .displayName ??
                                                          ""
                                                      : ""
                                                  : "",
                                              fontSize: 14,
                                              color: ColorManager.fontColor7,
                                              fontWeight:
                                                  FontWeightManager.softLight,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: false, // TODO: change to true when the requirement is clear
                                    child: Row(
                                        children: [
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () async {},
                                            child: Container(
                                              height: 22.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: ColorManager.primary,
                                                  width: 2.w,
                                                ),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.check_rounded,
                                                  color: ColorManager.primary,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Visibility(
                                  visible: index != 2,
                                  child: Divider(
                                    color: ColorManager.borderColor3,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(height: 10.h),
                PrimaryButton(
                  width: Get.width,
                  onPressed: () => Get.back(),
                  title: LocaleKeys.save.tr,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
