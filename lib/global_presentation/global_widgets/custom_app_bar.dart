import 'package:hessa_student/app/routes/app_pages.dart';

import '../../app/constants/exports.dart';
import '../../generated/locales.g.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.action,
  }) : super(key: key);

  final String? title;
  final Widget? leading;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 95.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 1),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20.w),
              leading ??
                  GestureDetector(
                    onTap: () async => await Get.toNamed(Routes.NOTIFICATIONS),
                    child: SvgPicture.asset(ImagesManager.notificationIcon),
                  ),
              const Spacer(),
              PrimaryText(
                title ?? LocaleKeys.home,
                fontSize: 18,
                fontWeight: FontWeightManager.light,
              ),
              const Spacer(),
              action ?? SvgPicture.asset(ImagesManager.searchIcon),
              SizedBox(width: 20.w),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
