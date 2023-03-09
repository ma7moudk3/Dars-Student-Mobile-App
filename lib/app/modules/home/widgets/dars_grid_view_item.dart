import 'package:hessa_student/app/modules/home/controllers/home_controller.dart';

import '../../../constants/exports.dart';

class DarsGridViewItem extends GetView<HomeController> {
  final String imagePath;
  final String title;
  final Function()? onTap;
  final Color iconBackgroundColor;
  const DarsGridViewItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
    required this.iconBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(15),
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
            const Spacer(),
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: iconBackgroundColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: SvgPicture.asset(
                  imagePath,
                  width: 40.w,
                  height: 40.h,
                  color: iconBackgroundColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            PrimaryText(
              title,
              fontSize: 15,
              fontWeight: FontWeightManager.softLight,
              color: ColorManager.fontColor,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
