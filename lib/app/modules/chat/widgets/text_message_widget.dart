import 'package:dart_emoji/dart_emoji.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hessa_student/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/read_more.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../data/cache_helper.dart';

class TextMessageWidget extends GetView<ChatController> {
  const TextMessageWidget({
    Key? key,
    required this.message,
    required this.messageWidth,
    required this.showName,
  }) : super(key: key);
  final types.TextMessage message;
  final int messageWidth;
  final bool showName;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> messageData = {};
    return Container(
      padding: EmojiUtil.hasOnlyEmojis(message.text)
          ? null
          : EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
      child: Column(
        crossAxisAlignment:
            message.author.id != CacheHelper.instance.getUserId().toString()
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          (extractLink(message.text) != null &&
                  Uri.parse(extractLink(message.text)!).isAbsolute)
              ? StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return LinkPreview(
                      enableAnimation: true,
                      padding: const EdgeInsets.all(5),
                      hideImage: true,
                      openOnPreviewTitleTap: true,
                      openOnPreviewImageTap: true,
                      onPreviewDataFetched: (types.PreviewData previewData) {
                        setState(() {
                          if (extractLink(message.text) != null) {
                            messageData = {
                              ...messageData,
                              extractLink(message.text)!: previewData
                            };
                          }
                        });
                      },
                      textWidget: Linkify(
                        onOpen: (LinkableElement link) async {
                          if (extractLink(message.text) != null) {
                            final url = Uri.parse(extractLink(message.text)!);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              throw 'Could not launch $link';
                            }
                          }
                        },
                        linkStyle: TextStyle(
                          color: message.author.id !=
                                  CacheHelper.instance.getUserId().toString()
                              ? ColorManager.primary
                              : Colors.white,
                          fontWeight: FontWeightManager.softLight,
                          fontFamily: FontConstants.fontFamily,
                        ),
                        text: message.text,
                        textDirection: detectLang(text: message.text)
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        textAlign: detectLang(text: message.text)
                            ? TextAlign.start
                            : TextAlign.end,
                        style: TextStyle(
                          color: message.author.id !=
                                  CacheHelper.instance.getUserId().toString()
                              ? ColorManager.fontColor
                              : Colors.white,
                          fontWeight: FontWeightManager.softLight,
                          fontFamily: FontConstants.fontFamily,
                        ),
                      ),
                      textStyle: TextStyle(
                        color: message.author.id !=
                                CacheHelper.instance.getUserId().toString()
                            ? ColorManager.fontColor
                            : Colors.white,
                        fontWeight: FontWeightManager.softLight,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      previewData: messageData[extractLink(message.text) ?? ""],
                      text: extractLink(message.text) ?? "",
                      metadataTitleStyle: TextStyle(
                        color: message.author.id !=
                                CacheHelper.instance.getUserId().toString()
                            ? ColorManager.fontColor
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeightManager.softLight,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      metadataTextStyle: TextStyle(
                        color: message.author.id !=
                                CacheHelper.instance.getUserId().toString()
                            ? ColorManager.darkGrey2
                            : ColorManager.white.withOpacity(0.6),
                        fontSize: 13,
                        fontWeight: FontWeightManager.softLight,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      linkStyle: TextStyle(
                        color: message.author.id !=
                                CacheHelper.instance.getUserId().toString()
                            ? ColorManager.fontColor
                            : Colors.white,
                        fontWeight: FontWeightManager.softLight,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      headerStyle: TextStyle(
                        color: message.author.id !=
                                CacheHelper.instance.getUserId().toString()
                            ? ColorManager.fontColor
                            : Colors.white,
                        fontWeight: FontWeightManager.softLight,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      width: Get.width,
                    );
                  },
                )
              : Directionality(
                  textDirection: detectLang(text: message.text)
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: ReadMoreText(
                    message.text,
                    trimLines: 4,
                    colorClickableText: ColorManager.accent,
                    trimMode: TrimMode.line,
                    trimCollapsedText: LocaleKeys.read_more.tr,
                    trimExpandedText: LocaleKeys.read_less.tr,
                    style: TextStyle(
                      color: message.author.id !=
                              CacheHelper.instance.getUserId().toString()
                          ? ColorManager.fontColor
                          : Colors.white,
                      fontSize: EmojiUtil.hasOnlyEmojis(message.text) ? 28 : 16,
                      fontWeight: FontWeightManager.softLight,
                      fontFamily: FontConstants.fontFamily,
                    ),
                    moreStyle: TextStyle(
                      color: message.author.id !=
                              CacheHelper.instance.getUserId().toString()
                          ? ColorManager.primary
                          : ColorManager.primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeightManager.softLight,
                      fontFamily: FontConstants.fontFamily,
                    ),
                    lessStyle: TextStyle(
                      color: message.author.id !=
                              CacheHelper.instance.getUserId().toString()
                          ? ColorManager.primary
                          : ColorManager.primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeightManager.softLight,
                      fontFamily: FontConstants.fontFamily,
                    ),
                  )),
          Directionality(
            textDirection: TextDirection.ltr,
            child: PrimaryText(
              message.createdAt != null
                  ? formatTimeOfDay(DateTime.fromMicrosecondsSinceEpoch(
                      message.createdAt! * 1000))
                  : formatTimeOfDay(DateTime.now()),
              fontSize: 11.5,
              color: message.author.id !=
                      CacheHelper.instance.getUserId().toString()
                  ? ColorManager.grey5
                  : EmojiUtil.hasOnlyEmojis(message.text)
                      ? ColorManager.grey5
                      : ColorManager.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
