import 'package:hessa_student/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../global_presentation/global_widgets/flyer_chat/src/util.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../data/cache_helper.dart';

class FileMessageWidget extends GetView<ChatController> {
  const FileMessageWidget({
    Key? key,
    required this.message,
    required this.messageWidth,
  }) : super(key: key);
  final types.FileMessage message;
  final int messageWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 15.w,
        left: 15.w,
        top: 15.h,
        bottom: 5.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45.w,
                height: 45.h,
                decoration: BoxDecoration(
                    color: message.author.id ==
                            CacheHelper.instance.getUserId().toString()
                        ? Colors.white.withOpacity(0.5)
                        : ColorManager.primary,
                    shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.file_present_rounded,
                    color: message.author.id ==
                            CacheHelper.instance.getUserId().toString()
                        ? ColorManager.primary
                        : ColorManager.white,
                    size: 23,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryText(
                    message.name,
                    fontSize: 14,
                    color: message.author.id !=
                            CacheHelper.instance.getUserId().toString()
                        ? ColorManager.fontColor
                        : Colors.white,
                  ),
                  PrimaryText(
                    formatBytes(message.size.toInt()),
                    fontSize: 12,
                    color: message.author.id !=
                            CacheHelper.instance.getUserId().toString()
                        ? ColorManager.greyFontColor2
                        : ColorManager.grey6.withOpacity(0.8),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Visibility(
            visible: message.createdAt != null,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: PrimaryText(
                message.createdAt != null
                    ? formatTimeOfDay(
                        DateTime.fromMicrosecondsSinceEpoch(
                          message.createdAt! * 1000,
                        ),
                      )
                    : "",
                fontSize: 10,
                color: message.author.id !=
                        CacheHelper.instance.getUserId().toString()
                    ? ColorManager.fontColor
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
