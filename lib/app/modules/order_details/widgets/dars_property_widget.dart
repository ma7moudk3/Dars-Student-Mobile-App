import 'package:hessa_student/app/core/helper_functions.dart';

import '../../../constants/exports.dart';
import '../controllers/order_details_controller.dart';

class DarsPropertyWidget extends GetView<OrderDetailsController> {
  const DarsPropertyWidget({
    required this.iconPath,
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);
  final String iconPath, title, content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            color: ColorManager.yellow,
          ),
          SizedBox(width: 10.w),
          PrimaryText(
            title,
            fontSize: 13,
            fontWeight: FontWeightManager.softLight,
          ),
          const Spacer(),
          SizedBox(
            width: 160.w,
            child: Tooltip(
              message: content,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(16),
              showDuration: const Duration(milliseconds: 5500),
              preferBelow: true,
               textStyle: TextStyle(
                color: ColorManager.white,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                fontFamily: FontConstants.fontFamily,
              ),
              textAlign:
                  detectLang(text: content) ? TextAlign.left : TextAlign.right,
              decoration: BoxDecoration(
                color: ColorManager.grey5,
                borderRadius: BorderRadius.circular(10),
              ),
              triggerMode: TooltipTriggerMode.tap,
              child: PrimaryText(
                content,
                maxLines: 1,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.grey5,
              ),
            ),
          ),
          SizedBox(width: (Get.width * 0.04).w),
        ],
      ),
    );
  }
}
