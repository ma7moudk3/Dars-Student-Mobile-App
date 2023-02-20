import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:get/get.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../global_presentation/global_features/color_manager.dart';
import '../../../../global_presentation/global_features/font_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../../global_presentation/global_widgets/flyer_chat/src/chat_theme.dart';
import '../../../../global_presentation/global_widgets/flyer_chat/src/models/send_button_visibility_mode.dart';
import '../../../../global_presentation/global_widgets/flyer_chat/src/widgets/chat.dart';
import '../../../../global_presentation/global_widgets/flyer_chat/src/widgets/input/input.dart';
import '../../../../global_presentation/global_widgets/primary_text.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

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
            child: Chat(
              messages: controller.messages,
              onSendPressed: (types.PartialText message) {},
              user: const types.User(
                id: '1',
                firstName: 'John',
                lastName: 'Doe',
              ),
              theme: DefaultChatTheme(
                primaryColor: ColorManager.accent,
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
                  sendButtonVisibilityMode: SendButtonVisibilityMode.editing,
                  
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
