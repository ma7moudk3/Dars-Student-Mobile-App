import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:lottie/lottie.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../core/helper_functions.dart';
import '../controllers/teacher_details_controller.dart';
import '../widgets/about_teacher_widget.dart';
import '../widgets/teacher_brief_widget.dart';
import '../widgets/teacher_dars_rating_widget.dart';
import '../widgets/teacher_info_widget.dart';
import '../widgets/teacher_rating_previous_droos.dart';

class TeacherDetailsView extends GetView<TeacherDetailsController> {
  const TeacherDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<TeacherDetailsController>(
        builder: (TeacherDetailsController controller) {
      if (controller.isInternetConnected.value) {
        if (controller.isLoading.value == false) {
          return Scaffold(
            appBar: CustomAppBar(
              title: controller.darsTeacherDetails.result != null
                  ? controller.darsTeacherDetails.result!.userName ?? ""
                  : "",
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.fontColor,
                    size: 20,
                  ),
                ),
              ),
              action: const SizedBox.shrink(),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TeacherInfo(),
                    SizedBox(height: 27.h),
                    const DarsTeacherBrief(),
                    SizedBox(height: 28.h),
                    const AboutTeacher(),
                    SizedBox(height: 25.h),
                    const TeacherRatingPreviousDroos(),
                    SizedBox(height: 34.h),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(13.0, 14.0, 14.0, 12.0),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1a000000),
                            offset: Offset(0, 1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(ImagesManager.ratingIcon),
                              SizedBox(width: 8.w),
                              PrimaryText(
                                LocaleKeys.rating_previous_droos,
                                fontSize: 14,
                                fontWeight: FontWeightManager.softLight,
                                color: ColorManager.fontColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          moreDivider(),
                          SizedBox(height: 10.h),
                          ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  const TeacherDarsRating(),
                                  Visibility(
                                    visible: index != 2,
                                    child: moreDivider(),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 34.h),
                    Visibility(
                      visible: controller.orderIdForAccept != null &&
                          controller.orderIdForAccept != -1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryButton(
                            width: 280.w,
                            onPressed: () async {
                              await controller.acceptCandidateProvider();
                            },
                            title: LocaleKeys.approve_teacher.tr,
                          ),
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              width: 48.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: ColorManager.yellow,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  ImagesManager.messagingIcon,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: CustomAppBar(
              title: LocaleKeys.teacher_details.tr,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.fontColor,
                    size: 20,
                  ),
                ),
              ),
              action: const SizedBox.shrink(),
            ),
            body: Center(
              child: SpinKitCircle(
                duration: const Duration(milliseconds: 1300),
                size: 50,
                color: ColorManager.primary,
              ),
            ),
          );
        }
      } else {
        return Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.teacher_details.tr,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ColorManager.fontColor,
                  size: 20,
                ),
              ),
            ),
            action: const SizedBox.shrink(),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(
                  LocaleKeys.check_your_internet_connection.tr,
                  fontSize: 18,
                  fontWeight: FontWeightManager.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: Get.height * 0.5,
                  child: Lottie.asset(
                    LottiesManager.noInernetConnection,
                    animate: true,
                  ),
                ),
                SizedBox(height: 10.h),
                PrimaryButton(
                  onPressed: () async {
                    await controller.checkInternet();
                  },
                  title: LocaleKeys.retry.tr,
                  width: Get.width * 0.5,
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
