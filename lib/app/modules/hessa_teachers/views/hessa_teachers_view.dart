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
            SizedBox(height: 20.h),
            const Center(
              child: Text(
                'HessaTeachersView is working',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
