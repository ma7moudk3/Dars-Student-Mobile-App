import 'package:flutter/material.dart';
import 'package:hessa_student/app/modules/chat/widgets/image_message_widget.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_widgets/flyer_chat/flutter_chat_ui.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:get/get.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/global_presentation/global_features/images_manager.dart';

import '../../../../global_presentation/global_features/color_manager.dart';
import '../../../../global_presentation/global_features/font_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/primary_text.dart';
import '../../../constants/links.dart';
import '../../../data/cache_helper.dart';
import '../controllers/chat_controller.dart';
import '../widgets/file_message_widget.dart';
import '../widgets/text_message_widget.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
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
        return SafeArea(
          child: Padding(
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
                                  "${Links.baseLink}${Links.profileImageById}?userid=${-1}";
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
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {},
                              child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: ColorManager.yellow,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.add_rounded,
                                            color: ColorManager.yellow,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      PrimaryText(
                                        LocaleKeys.approve_teacher.tr,
                                        fontSize: 14,
                                        color: ColorManager.yellow,
                                        fontWeight: FontWeightManager.light,
                                      ),
                                    ],
                                  ),
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
                        await controller.handleOnLongPressMessage(
                            message, context);
                      },
                      disableImageGallery: true,
                      user: types.User(
                        id: CacheHelper.instance.getUserId().toString(),
                      ),
                      messages: controller.messages,
                      // messages: const [],
                      showUserAvatars: true,
                      showUserNames: false,
                      textMessageBuilder: (types.TextMessage message,
                          {required int messageWidth, required bool showName}) {
                        return TextMessageWidget(
                          message: message,
                          messageWidth: messageWidth,
                          showName: showName,
                        );
                      },
                      imageMessageBuilder: (types.ImageMessage message,
                          {required int messageWidth}) {
                        return ImageMessageWidget(
                          message: message,
                          messageWidth: messageWidth,
                        );
                      },
                      fileMessageBuilder: (types.FileMessage message,
                          {required int messageWidth}) {
                        return FileMessageWidget(
                          message: message,
                          messageWidth: messageWidth,
                        );
                      },
                      onSendPressed: (types.PartialText message) {},
                      theme: DefaultChatTheme(
                        inputMargin: EdgeInsets.only(
                            bottom: 10.h, right: 16.w, left: 16.w, top: 10.h),
                        primaryColor: ColorManager.primary,
                        inputTextColor: ColorManager.fontColor,
                        inputTextCursorColor: ColorManager.primary,
                        inputBorderRadius: BorderRadius.circular(15),
                        attachmentButtonIcon: Image.asset(
                          'assets/images/flyer_chat/attachment_icon.png',
                          color: ColorManager.borderColor2,
                          height: 35.h,
                          width: 35.w,
                        ),
                        sendButtonIcon: Image.asset(
                          'assets/images/flyer_chat/send_icon.png',
                          height: 35.h,
                          width: 35.w,
                        ),
                        userAvatarImageBackgroundColor:
                            ColorManager.grey.withOpacity(0.4),
                        inputTextStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeightManager.light,
                          height: 1.5,
                          fontFamily: FontConstants.fontFamily,
                        ),
                        emptyChatPlaceholderTextStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeightManager.light,
                          height: 1.5,
                          color: ColorManager.fontColor7,
                          fontFamily: FontConstants.fontFamily,
                        ),
                        inputBackgroundColor: ColorManager.darkAccent2,
                      ),
                      onAttachmentPressed: controller.handleAtachmentPressed,
                      dateHeaderBuilder: (dateHeader) {
                        return Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15.h, top: 5.h),
                            child: PrimaryText(
                              intl.DateFormat.yMEd()
                                  .format(dateHeader.dateTime),
                              fontSize: 13,
                              color: ColorManager.fontColor7,
                            ),
                          ),
                        );
                      },
                      isAttachmentUploading: controller.isAttachmentUploading,
                      onMessageTap: controller.handleMessageTap,
                      onPreviewDataFetched: controller.handlePreviewDataFetched,
                      customBottomWidget: Input(
                        isAttachmentUploading: controller.isAttachmentUploading,
                        onAttachmentPressed: controller.handleAtachmentPressed,
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
          ),
        );
      }),
    );
  }
}
