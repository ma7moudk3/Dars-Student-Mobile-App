import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/modules/dars_teachers/controllers/dars_teachers_controller.dart';

import '../../app/core/helper_functions.dart';
import '../../app/routes/app_pages.dart';
import '../../generated/locales.g.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
    this.onSearch,
    this.searchHint,
    this.onFilterTap,
  }) : super(key: key);

  final Function(String)? onSearch;
  final String? searchHint;
  void Function()? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DarsTeachersController>(
        builder: (DarsTeachersController controller) {
      const TextStyle textStyle = TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontSize: 17,
        color: Color(0x66000000),
        letterSpacing: -0.41000000190734864,
        height: 1.2941176470588236,
      );
      TextStyle hintStyle = TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontSize: 17.sp,
        letterSpacing: -0.41000000190734864,
        color: ColorManager.borderColor2,
        height: 1.2941176470588236,
      );
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0.h),
        decoration: BoxDecoration(
          color: const Color(0xfffafafa),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Visibility(
              visible: !controller.isSearchIconVisible,
              child: SvgPicture.asset(
                ImagesManager.searchIcon,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
                color: ColorManager.borderColor2,
              ),
            ),
            Visibility(
              visible: controller.isSearchIconVisible,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  if (await checkInternetConnection(timeout: 10)) {
                    controller.pagingController.refresh();
                    controller.toggleSearch = true;
                  } else {
                    await Get.toNamed(Routes.CONNECTION_FAILED);
                  }
                },
                child: SvgPicture.asset(
                  ImagesManager.searchIcon,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextField(
                controller: controller.searchTextController,
                focusNode: controller.searchFocusNode,
                onSubmitted: (txt) {
                  onSearch?.call(txt);
                },
                onEditingComplete: () {},
                onChanged: (String value) async {
                  if (value.isEmpty &&
                      (controller.toggleSearch || controller.toggleFilter)) {
                    if (await checkInternetConnection(timeout: 10)) {
                      await controller.resetTeachers();
                      controller.toggleSearch = false;
                    } else {
                      await Get.toNamed(Routes.CONNECTION_FAILED);
                    }
                  }
                  controller.makeSearchIconVisible(value);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelStyle: textStyle,
                  hintText: searchHint ?? LocaleKeys.search.tr,
                  hintStyle: hintStyle,
                  filled: false,
                ),
              ),
            ),
            Visibility(
              visible: !controller.isSearchIconVisible,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onFilterTap,
                child: SvgPicture.asset(
                  ImagesManager.filterIcon,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
