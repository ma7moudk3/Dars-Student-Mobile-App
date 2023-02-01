import 'package:hessa_student/app/constants/exports.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/search_bar.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/hessa_teachers_controller.dart';
import '../widgets/hessa_teacher_filter_bottom_sheet_content.dart';

class HessaTeachersView extends GetView<HessaTeachersController> {
  const HessaTeachersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.hessa_teachers,
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
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Container(
              width: (Get.width).w,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0.h),
              child: SearchBar(
                searchHint: LocaleKeys.search_for_teacher.tr,
                onFilterTap: () async {
                  await Get.bottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    backgroundColor: ColorManager.white,
                    const HessaTeacherFilterBottomSheetContent(),
                  );
                },
                onSearch: (String? text) async {
                  if (controller.searchTextController.text.isNotEmpty &&
                      (controller.searchTextController.text
                          .trim()
                          .isNotEmpty)) {
                    if (await checkInternetConnection(timeout: 10)) {
                      controller.toggleSearch = true;
                    } else {
                      Get.toNamed(Routes.CONNECTION_FAILED);
                    }
                  }
                },
              ),
            ),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        LocaleKeys.search_results,
                        fontSize: 16.sp,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            PrimaryText(
                              LocaleKeys.most_requested,
                              fontSize: 16.sp,
                              color: ColorManager.fontColor7,
                            ),
                            SizedBox(width: 5.w),
                            SvgPicture.asset(
                              ImagesManager.descendingIcon,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await Get.toNamed(Routes.TEACHER_DETAILS);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      margin: EdgeInsets.only(bottom: 16.h),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: const Color(0xfeffffff),
                        borderRadius: BorderRadius.circular(14.0),
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(ImagesManager.avatar),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        PrimaryText(
                                          "وليد علي",
                                          color: ColorManager.fontColor,
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: ColorManager.orange,
                                              size: 14.sp,
                                            ),
                                            SizedBox(
                                              width: 40.w,
                                              child: PrimaryText(
                                                "4.5",
                                                color: ColorManager.fontColor,
                                                fontSize: 12.sp,
                                                maxLines: 1,
                                                fontWeight:
                                                    FontWeightManager.softLight,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        PrimaryText(
                                          ["رياضيات", "علوم", "فيزياء"]
                                              .map((String subject) =>
                                                  subject.toString())
                                              .join(", "),
                                          color: ColorManager.primary,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                          fontSize: 11.sp,
                                        ),
                                        const Spacer(),
                                        PrimaryText(
                                          "نابلس - الخليل",
                                          color: ColorManager.fontColor7,
                                          fontSize: 12.sp,
                                          maxLines: 1,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
