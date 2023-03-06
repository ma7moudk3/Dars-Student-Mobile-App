import 'dart:developer';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/expansion_tile_card.dart';
import '../../../constants/exports.dart';
import '../controllers/hessa_details_controller.dart';
import 'hessa_property_widget.dart';

class HessasListWidget extends GetView<HessaDetailsController> {
  const HessasListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ExpansionTileCard(
                heightFactorCurve: Curves.easeInOut,
                colorCurve: Curves.bounceIn,
                onExpansionChanged: (bool isExpanded) => log('$isExpanded'),
                title: PrimaryText(
                  "${LocaleKeys.dars.tr} (${index + 1})",
                  fontSize: 14.sp,
                  fontWeight: FontWeightManager.softLight,
                ),
                subtitle: SizedBox(
                  width: 170.w,
                  child: PrimaryText(
                    "رياضيات الصف الاول",
                    fontSize: 13.sp,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.primary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                borderRadius: BorderRadius.circular(14.0),
                shadowColor: const Color(0x1a000000),
                animateTrailing: true,
                trailing: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    log('delete');
                  },
                  child: Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: ColorManager.red.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        ImagesManager.deleteIcon,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ),
                ),
                leading: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: ColorManager.primary,
                      size: 20.sp,
                    ),
                  ),
                ),
                duration: const Duration(milliseconds: 500),
                children: List.generate(controller.hessaProperties.length,
                    (int index) {
                  return HessaPropertyWidget(
                    iconPath: controller.hessaProperties[index]["icon"],
                    title: controller.hessaProperties[index]["title"],
                    content: controller.hessaProperties[index]["content"] ?? "",
                  );
                }),
              ),
              Visibility(
                visible: index != 1, // index != length - 1 (last index)
                child: SizedBox(height: 20.h),
              ),
            ],
          );
        });
  }
}
