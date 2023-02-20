import 'package:cached_network_image/cached_network_image.dart';
import 'package:hessa_student/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';

class ImageMessageWidget extends GetView<ChatController> {
  const ImageMessageWidget({
    Key? key,
    required this.message,
    required this.messageWidth,
  }) : super(key: key);
  final types.ImageMessage message;
  final int messageWidth;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: message.uri,
          progressIndicatorBuilder: (BuildContext context, String url,
                  DownloadProgress downloadProgress) =>
              Container(
            padding: const EdgeInsets.all(120),
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 5.h,
          right: 10.w,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: ColorManager.fontColor.withOpacity(0.6),
                offset: const Offset(0, 0),
                spreadRadius: 15,
                blurRadius: 40,
              )
            ]),
            child: Align(
              alignment: Get.locale!.languageCode != "ar"
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart,
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
                  hasSpecificColor: true,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
