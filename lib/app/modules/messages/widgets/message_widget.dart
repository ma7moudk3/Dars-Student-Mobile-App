import 'package:animator/animator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../global_presentation/global_widgets/inner_shadow_widget.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/messages_controller.dart';
import 'delete_message_dialog_content.dart';

class MessageWidget extends GetView<MessagesController> {
  const MessageWidget({
    super.key,
    required this.index,
    this.isLastIndex = false,
  });

  final int index;
  final bool isLastIndex;

  @override
  Widget build(BuildContext context) {
    Widget deleteMessageBackgroundWidget = GetBuilder<MessagesController>(
        builder: (MessagesController controller) {
      return GestureDetector(
        onTap: () async {
          await Get.dialog(
            Container(
              color: ColorManager.black.withOpacity(0.1),
              height: 140.h,
              width: 140.w,
              child: Center(
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 18.w,
                  ),
                  child: DeleteMessageDialogContent(
                    deleteMessageFunction: () async {
                      controller
                          .deleteMessage(); // TODO: implement deleteMessage function
                    },
                  ),
                ),
              ),
            ),
          );
        },
        child: Animator<double>(
            duration: const Duration(milliseconds: 1000),
            cycles: 0,
            curve: Curves.elasticIn,
            tween: Tween<double>(begin: 20.0, end: 25.0),
            builder: (context, animatorState, child) {
              return Container(
                width: 85.w,
                decoration: BoxDecoration(
                  color: ColorManager.red.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    ImagesManager.deleteIcon,
                    width: animatorState.value * 2.2,
                    height: animatorState.value * 1.5,
                  ),
                ),
              );
            }),
      );
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            // dismissible: DismissiblePane(
            //   dismissThreshold: 0.2,
            //   onDismissed: () {},
            // ),
            dragDismissible: false,
            children: [deleteMessageBackgroundWidget],
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              await Get.toNamed(Routes.CHAT);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 8.w),
                        InnerShadow(
                          shadows: const [
                            BoxShadow(
                              color: Color(0x1a000000),
                              offset: Offset(0, 1),
                              blurRadius: 8,
                            ),
                            BoxShadow(
                              color: Color(0x1a000000),
                              offset: Offset(0, 1),
                              blurRadius: 8,
                            ),
                          ],
                          child: Container(
                            width: 70.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(ImagesManager.avatar),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 130.w,
                              child: PrimaryText(
                                "رامي النابلسي",
                                fontSize: 16,
                                fontWeight: FontWeightManager.softLight,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: 130.w,
                              child: PrimaryText(
                                "أهلاً, مرحباً بك في تطبيقنا الجديد للتواصل معنا ومع العملاء والمستخدمين",
                                fontSize: 13.5,
                                fontWeight: FontWeightManager.light,
                                color: ColorManager.fontColor7,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            PrimaryText(
                              "منذ 2 ساعة",
                              fontSize: 13,
                              fontWeight: FontWeightManager.light,
                              color: ColorManager.fontColor7,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 13,
                              color: ColorManager.fontColor7,
                            ),
                          ],
                        ),
                        SizedBox(width: 5.w),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: !isLastIndex, // last index
          child: moreDivider(
            thickness: 1.5.h,
            indent: 16.w,
          ),
        ),
      ],
    );
  }
}
