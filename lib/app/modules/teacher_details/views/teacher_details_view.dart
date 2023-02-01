import 'package:hessa_student/app/constants/exports.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../core/helper_functions.dart';
import '../controllers/teacher_details_controller.dart';
import '../widgets/about_teacher_widget.dart';
import '../widgets/teacher_brief_widget.dart';
import '../widgets/teacher_hessa_rating_widget.dart';
import '../widgets/teacher_info_widget.dart';

class TeacherDetailsView extends GetView<TeacherDetailsController> {
  const TeacherDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "محمد جميل",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TeacherInfo(),
              SizedBox(height: 27.h),
              const HessaTeacherBrief(),
              SizedBox(height: 28.h),
              const AboutTeacher(),
              SizedBox(height: 25.h),
              Container(
                padding: const EdgeInsets.fromLTRB(13.0, 14.0, 14.0, 12.0),
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
                          LocaleKeys.rating_previous_hessas,
                          fontSize: 14.sp,
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
                            const TeacherHessaRating(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(
                    width: 280.w,
                    onPressed: () => Get.back(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
