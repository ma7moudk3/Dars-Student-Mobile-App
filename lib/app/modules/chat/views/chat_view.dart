import 'dart:developer';
import 'dart:io';

import 'package:dart_emoji/dart_emoji.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gallery_saver/gallery_saver.dart';

import 'package:get/get.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_features/images_manager.dart';
import 'package:hessa_student/global_presentation/global_widgets/custom_snack_bar.dart';
import 'package:hessa_student/global_presentation/global_widgets/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../global_presentation/global_features/color_manager.dart';
import '../../../../global_presentation/global_features/font_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/flyer_chat/src/chat_l10n.dart';
import '../../../../global_presentation/global_widgets/flyer_chat/src/chat_theme.dart';
import '../../../../global_presentation/global_widgets/flyer_chat/src/models/send_button_visibility_mode.dart';
import '../../../../global_presentation/global_widgets/flyer_chat/src/widgets/chat.dart';
import '../../../../global_presentation/global_widgets/flyer_chat/src/widgets/input/input.dart';
import '../../../../global_presentation/global_widgets/primary_text.dart';
import '../../../../global_presentation/global_widgets/read_more.dart';
import '../../../constants/links.dart';
import '../../../data/cache_helper.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  ChatView({super.key});
  Map<String, dynamic> messageData = {};

  @override
  Widget build(BuildContext context) {
    bool isFileFunctionalityNeeded = false;
    Future handleAtachmentPressed() async {
      if (Platform.isIOS) {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    child: PrimaryText(LocaleKeys.camera.tr),
                    onPressed: () async {
                      Get.back();
                      await controller.handleImageSelection(
                          imageSource: ImageSource.camera);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: PrimaryText("gallery".tr),
                    onPressed: () async {
                      Get.back();
                      await controller.handleImageSelection(
                          imageSource: ImageSource.gallery);
                    },
                  ),
                  Visibility(
                    visible: isFileFunctionalityNeeded,
                    child: CupertinoActionSheetAction(
                      // the file functionality is not required at the moment
                      child: PrimaryText("file".tr),
                      onPressed: () async {
                        Get.back();
                        await controller.handleFileSelection();
                      },
                    ),
                  ),
                  CupertinoActionSheetAction(
                    child: PrimaryText("close".tr),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              );
            });
      } else {
        Get.bottomSheet(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SizedBox(
              height: isFileFunctionalityNeeded == true
                  ? Get.height * 0.18
                  : Get.height * 0.13,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.camera_alt_rounded,
                      size: 25,
                    ),
                    title: PrimaryText("camera".tr),
                    onTap: () async {
                      Get.back();
                      await controller.handleImageSelection(
                          imageSource: ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_rounded,
                      size: 25,
                    ),
                    title: PrimaryText("gallery".tr),
                    onTap: () async {
                      Get.back();
                      await controller.handleImageSelection(
                          imageSource: ImageSource.gallery);
                    },
                  ),
                  Visibility(
                    visible: isFileFunctionalityNeeded,
                    child: ListTile(
                      // the file functionality is not required at the moment
                      leading: const Icon(
                        Icons.file_present_rounded,
                        size: 25,
                      ),
                      title: PrimaryText("file".tr),
                      onTap: () async {
                        Get.back();
                        await controller.handleFileSelection();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          backgroundColor: ColorManager.white,
        );
      }
    }

    Future handleOnLongPressMessage(
        types.Message message, BuildContext context) async {
      if (Platform.isIOS) {
        if ((message.type == MessageType.file) &&
            message.author.id != CacheHelper.instance.getUserId().toString()) {
          return; // do nothing
        }
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              actions: [
                Visibility(
                  visible: message.author.id ==
                      CacheHelper.instance.getUserId().toString(),
                  child: CupertinoActionSheetAction(
                    child: PrimaryText(
                      LocaleKeys.delete_message.tr,
                      fontSize: 16,
                      fontWeight: FontWeightManager.softLight,
                      color: ColorManager.accent,
                    ),
                    onPressed: () async {
                      Get.back();
                      // await FirebaseChatCore.instance.deleteMessage(
                      //     Get.arguments["room"].id, message.id);
                      if (message.type == MessageType.image) {
                        types.ImageMessage imageMessage =
                            message as types.ImageMessage;
                        // await controller.deleteFileFromStorage(
                        //     fileUrl: imageMessage.uri);
                      } else if (message.type == MessageType.file) {
                        types.FileMessage fileMessage =
                            message as types.FileMessage;
                        // await controller.deleteFileFromStorage(
                        //     fileUrl: fileMessage.uri);
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: message.type == MessageType.image,
                  child: CupertinoActionSheetAction(
                    child: PrimaryText(
                      LocaleKeys.download_image.tr,
                      fontSize: 16,
                      fontWeight: FontWeightManager.softLight,
                    ),
                    onPressed: () async {
                      Get.back();
                      try {
                        showLoadingDialog();
                        types.ImageMessage imageMessage =
                            message as types.ImageMessage;
                        if (imageMessage.uri.isNotEmpty) {
                          await GallerySaver.saveImage(imageMessage.uri,
                                  albumName: 'Hessa Student')
                              .then((value) {
                            CustomSnackBar.showCustomSnackBar(
                                title: LocaleKeys.success.tr,
                                message: LocaleKeys.image_saved.tr);
                          });
                        }
                        if (Get.isDialogOpen!) {
                          Get.back();
                        }
                      } on PlatformException catch (error) {
                        log(error.toString());
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: message.type == MessageType.text,
                  child: CupertinoActionSheetAction(
                    child: PrimaryText(
                      LocaleKeys.copy_message.tr,
                      fontSize: 16,
                      fontWeight: FontWeightManager.softLight,
                    ),
                    onPressed: () async {
                      Get.back();
                      await Clipboard.setData(
                        ClipboardData(
                            text: (message as types.TextMessage).text),
                      ).then((value) {
                        CustomSnackBar.showCustomInfoSnackBar(
                            title: LocaleKeys.note.tr,
                            message: LocaleKeys.message_copied_succesfully.tr);
                      });
                    },
                  ),
                ),
                CupertinoActionSheetAction(
                  child: PrimaryText(
                    LocaleKeys.close.tr,
                    fontSize: 16,
                    fontWeight: FontWeightManager.softLight,
                  ),
                  onPressed: () => Get.back(),
                ),
              ],
            );
          },
        );
      } else {
        if ((message.type == MessageType.file) &&
            message.author.id != CacheHelper.instance.getUserId().toString()) {
          return; // do nothing
        }
        Get.bottomSheet(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SizedBox(
              height: ((message.type == MessageType.text ||
                          message.type == MessageType.image) &&
                      message.author.id ==
                          CacheHelper.instance.getUserId().toString())
                  ? (Get.height * 0.13).h
                  : (Get.height * 0.06).h,
              child: ListView(
                children: [
                  Visibility(
                    visible: message.author.id ==
                        CacheHelper.instance.getUserId().toString(),
                    child: ListTile(
                      leading: Icon(
                        Icons.delete_rounded,
                        color: ColorManager.accent,
                        size: 25,
                      ),
                      title: PrimaryText(
                        LocaleKeys.delete_message.tr,
                        color: ColorManager.accent,
                        fontWeight: FontWeightManager.softLight,
                        fontSize: 16,
                      ),
                      onTap: () async {
                        Get.back();
                        // await FirebaseChatCore.instance.deleteMessage(
                        //     Get.arguments["room"].id, message.id);
                        if (message.type == MessageType.image) {
                          types.ImageMessage imageMessage =
                              message as types.ImageMessage;
                          // await controller.deleteFileFromFirebaseStorage(
                          //     fileUrl: imageMessage.uri);
                        } else if (message.type == MessageType.file) {
                          types.FileMessage fileMessage =
                              message as types.FileMessage;
                          // await controller.deleteFileFromFirebaseStorage(
                          //     fileUrl: fileMessage.uri);
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: message.type == MessageType.image,
                    child: ListTile(
                      leading: const Icon(
                        Icons.download_rounded,
                        size: 25,
                      ),
                      title: PrimaryText(
                        LocaleKeys.download_image.tr,
                        fontSize: 16,
                        fontWeight: FontWeightManager.softLight,
                      ),
                      onTap: () async {
                        Get.back();
                        try {
                          showLoadingDialog();
                          types.ImageMessage imageMessage =
                              message as types.ImageMessage;
                          if (imageMessage.uri.isNotEmpty) {
                            await GallerySaver.saveImage(imageMessage.uri,
                                    albumName: 'Hessa Student')
                                .then((value) {
                              CustomSnackBar.showCustomSnackBar(
                                  title: LocaleKeys.success.tr,
                                  message: LocaleKeys.image_saved.tr);
                            });
                          }
                          if (Get.isDialogOpen!) {
                            Get.back();
                          }
                        } on PlatformException catch (error) {
                          log(error.toString());
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: message.type == MessageType.text,
                    child: ListTile(
                      leading: const Icon(
                        Icons.copy_rounded,
                        size: 25,
                      ),
                      title: PrimaryText(
                        LocaleKeys.copy_message.tr,
                        fontSize: 16,
                        fontWeight: FontWeightManager.softLight,
                      ),
                      onTap: () async {
                        Get.back();
                        await Clipboard.setData(
                          ClipboardData(
                              text: (message as types.TextMessage).text),
                        ).then((value) {
                          CustomSnackBar.showCustomInfoSnackBar(
                              title: LocaleKeys.note.tr,
                              message:
                                  LocaleKeys.message_copied_succesfully.tr);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          backgroundColor: ColorManager.white,
        );
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "محمد جميل",
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorManager.fontColor,
              size: 20,
            ),
          ),
        ),
      ),
      body: GetBuilder<ChatController>(builder: (ChatController controller) {
        return Padding(
          padding: EdgeInsets.only(
            top: 24.h,
          ),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(15.0),
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, setState) {
                            String teacherPicture =
                                "${Links.baseLink}${Links.profileImageById}?userId=${-1}";
                            return Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  // image: CachedNetworkImageProvider(
                                  //   teacherPicture, // the user that is being chatted with
                                  //   errorListener: () {
                                  //     setState(() {
                                  //       teacherPicture =
                                  //           "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                                  //     });
                                  //   },
                                  // ),
                                  image: AssetImage(ImagesManager.avatar),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            );
                          }),
                          SizedBox(width: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryText(
                                "محمد جميل",
                                fontSize: 14,
                                color: ColorManager.primary,
                                fontWeight: FontWeightManager.light,
                              ),
                              SizedBox(height: 4.h),
                              PrimaryText(
                                "نابلس ، الضفة",
                                fontSize: 14,
                                color: ColorManager.borderColor2,
                                fontWeight: FontWeightManager.softLight,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: 140.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: ColorManager.yellow.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8.w),
                                  Container(
                                    width: 16.w,
                                    height: 16.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: ColorManager.yellow,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color: ColorManager.yellow,
                                        size: 10.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  PrimaryText(
                                    "اعتماد المدرس",
                                    fontSize: 14,
                                    color: ColorManager.yellow,
                                    fontWeight: FontWeightManager.light,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      moreDivider(),
                    ],
                  ),
                ),
                Expanded(
                  child: Chat(
                    l10n: Get.locale!.languageCode != "ar"
                        ? const ChatL10nEn()
                        : const ChatL10nAr(),
                    onMessageLongPress:
                        (BuildContext context, types.Message message) async {
                      await handleOnLongPressMessage(message, context);
                    },
                    disableImageGallery: true,
                    user: types.User(
                      id: CacheHelper.instance.getUserId().toString(),
                    ),
                    messages: controller.messages,
                    showUserAvatars: true,
                    showUserNames: false,
                    textMessageBuilder: (types.TextMessage message,
                        {required int messageWidth, required bool showName}) {
                      return Container(
                        padding: EmojiUtil.hasOnlyEmojis(message.text)
                            ? null
                            : EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 13.h),
                        child: Column(
                          crossAxisAlignment: message.author.id !=
                                  CacheHelper.instance.getUserId().toString()
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            (extractLink(message.text) != null &&
                                    Uri.parse(extractLink(message.text)!)
                                        .isAbsolute)
                                ? StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                      return LinkPreview(
                                        enableAnimation: true,
                                        padding: const EdgeInsets.all(5),
                                        hideImage: true,
                                        openOnPreviewTitleTap: true,
                                        openOnPreviewImageTap: true,
                                        onPreviewDataFetched:
                                            (types.PreviewData previewData) {
                                          setState(() {
                                            if (extractLink(message.text) !=
                                                null) {
                                              messageData = {
                                                ...messageData,
                                                extractLink(message.text)!:
                                                    previewData
                                              };
                                            }
                                          });
                                        },
                                        textWidget: Linkify(
                                          onOpen: (LinkableElement link) async {
                                            if (extractLink(message.text) !=
                                                null) {
                                              final url = Uri.parse(
                                                  extractLink(message.text)!);
                                              if (await canLaunchUrl(url)) {
                                                await launchUrl(
                                                  url,
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              } else {
                                                throw 'Could not launch $link';
                                              }
                                            }
                                          },
                                          linkStyle: TextStyle(
                                            color: message.author.id !=
                                                    CacheHelper.instance
                                                        .getUserId()
                                                        .toString()
                                                ? ColorManager.primary
                                                : Colors.white,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            fontFamily:
                                                FontConstants.fontFamily,
                                          ),
                                          text: message.text,
                                          textDirection:
                                              detectLang(text: message.text)
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                          textAlign:
                                              detectLang(text: message.text)
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                          style: TextStyle(
                                            color: message.author.id !=
                                                    CacheHelper.instance
                                                        .getUserId()
                                                        .toString()
                                                ? ColorManager.fontColor
                                                : Colors.white,
                                            fontWeight:
                                                FontWeightManager.softLight,
                                            fontFamily:
                                                FontConstants.fontFamily,
                                          ),
                                        ),
                                        textStyle: TextStyle(
                                          color: message.author.id !=
                                                  CacheHelper.instance
                                                      .getUserId()
                                                      .toString()
                                              ? ColorManager.fontColor
                                              : Colors.white,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                          fontFamily: FontConstants.fontFamily,
                                        ),
                                        previewData: messageData[
                                            extractLink(message.text) ?? ""],
                                        text: extractLink(message.text) ?? "",
                                        metadataTitleStyle: TextStyle(
                                          color: message.author.id !=
                                                  CacheHelper.instance
                                                      .getUserId()
                                                      .toString()
                                              ? ColorManager.fontColor
                                              : Colors.white,
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                          fontFamily: FontConstants.fontFamily,
                                        ),
                                        metadataTextStyle: TextStyle(
                                          color: message.author.id !=
                                                  CacheHelper.instance
                                                      .getUserId()
                                                      .toString()
                                              ? ColorManager.darkGrey2
                                              : ColorManager.white
                                                  .withOpacity(0.6),
                                          fontSize: 13,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                          fontFamily: FontConstants.fontFamily,
                                        ),
                                        linkStyle: TextStyle(
                                          color: message.author.id !=
                                                  CacheHelper.instance
                                                      .getUserId()
                                                      .toString()
                                              ? ColorManager.fontColor
                                              : Colors.white,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                          fontFamily: FontConstants.fontFamily,
                                        ),
                                        headerStyle: TextStyle(
                                          color: message.author.id !=
                                                  CacheHelper.instance
                                                      .getUserId()
                                                      .toString()
                                              ? ColorManager.fontColor
                                              : Colors.white,
                                          fontWeight:
                                              FontWeightManager.softLight,
                                          fontFamily: FontConstants.fontFamily,
                                        ),
                                        width: Get.width,
                                      );
                                    },
                                  )
                                : Directionality(
                                    textDirection:
                                        detectLang(text: message.text)
                                            ? TextDirection.ltr
                                            : TextDirection.rtl,
                                    child: ReadMoreText(
                                      message.text,
                                      trimLines: 4,
                                      colorClickableText: ColorManager.accent,
                                      trimMode: TrimMode.line,
                                      trimCollapsedText:
                                          LocaleKeys.read_more.tr,
                                      trimExpandedText: LocaleKeys.read_less.tr,
                                      style: TextStyle(
                                        color: message.author.id !=
                                                CacheHelper.instance
                                                    .getUserId()
                                                    .toString()
                                            ? ColorManager.fontColor
                                            : Colors.white,
                                        fontSize: EmojiUtil.hasOnlyEmojis(
                                                message.text)
                                            ? 28.sp
                                            : 16,
                                        fontWeight: FontWeightManager.softLight,
                                        fontFamily: FontConstants.fontFamily,
                                      ),
                                      moreStyle: TextStyle(
                                        color: message.author.id !=
                                                CacheHelper.instance
                                                    .getUserId()
                                                    .toString()
                                            ? ColorManager.primary
                                            : ColorManager.primaryDark,
                                        fontSize: 14,
                                        fontWeight: FontWeightManager.softLight,
                                        fontFamily: FontConstants.fontFamily,
                                      ),
                                      lessStyle: TextStyle(
                                        color: message.author.id !=
                                                CacheHelper.instance
                                                    .getUserId()
                                                    .toString()
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
                                    ? formatTimeOfDay(
                                        DateTime.fromMicrosecondsSinceEpoch(
                                            message.createdAt! * 1000))
                                    : formatTimeOfDay(DateTime.now()),
                                fontSize: 11.5,
                                color: message.author.id !=
                                        CacheHelper.instance
                                            .getUserId()
                                            .toString()
                                    ? ColorManager.grey5
                                    : EmojiUtil.hasOnlyEmojis(message.text)
                                        ? ColorManager.grey5
                                        : ColorManager.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onSendPressed: (types.PartialText message) {},
                    theme: DefaultChatTheme(
                      primaryColor: ColorManager.primary,
                      userAvatarImageBackgroundColor:
                          ColorManager.grey.withOpacity(0.4),
                      attachmentButtonIcon: const Icon(
                        Icons.add_circle_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                      inputTextStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeightManager.light,
                        height: 1.5,
                        fontFamily: FontConstants.fontFamily,
                      ),
                      inputBackgroundColor: ColorManager.darkGrey,
                    ),
                    onAttachmentPressed: handleAtachmentPressed,
                    isAttachmentUploading: controller.isAttachmentUploading,
                    onMessageTap: controller.handleMessageTap,
                    onPreviewDataFetched: controller.handlePreviewDataFetched,
                    customBottomWidget: Input(
                      isAttachmentUploading: controller.isAttachmentUploading,
                      onAttachmentPressed: handleAtachmentPressed,
                      onSendPressed: controller.handleSendPressed,
                      options: InputOptions(
                        onTextChanged: (String? value) async {},
                        sendButtonVisibilityMode:
                            SendButtonVisibilityMode.editing,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
