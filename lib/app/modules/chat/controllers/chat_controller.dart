import 'dart:developer';
import 'dart:io';

import 'package:better_open_file/better_open_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../constants/exports.dart';
import '../../../data/cache_helper.dart';

class ChatController extends GetxController with WidgetsBindingObserver {
  bool isAttachmentUploading = false, isFileFunctionalityNeeded = false;
  List<types.Message> messages = [
    const types.TextMessage(
      author: types.User(
        id: '33053',
        firstName: 'John',
        lastName: 'Doe',
      ),
      id: '1',
      text: '🌚👍🏼👍🏼👍🏼',
    ),
    const types.TextMessage(
      author: types.User(
        id: '33053',
        firstName: 'John',
        lastName: 'Doe',
      ),
      id: '2',
      text:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
    ),
    const types.TextMessage(
      author: types.User(
        id: '1',
        firstName: 'Jane',
        lastName: 'Doe',
      ),
      id: '4',
      text: "وعليكم السلام أريد الاستفسار عن حصص الرياضيات للصف الاول",
    ),
    const types.TextMessage(
      author: types.User(
        id: '33053',
        firstName: 'Jane',
        lastName: 'Doe',
      ),
      id: '6',
      text:
          "Hey, I am Jane. How are you?, I just wanted to tell you about this: https://www.textfixer.com/tools/remove-line-breaks.php",
    ),
    const types.ImageMessage(
        author: types.User(
          id: '33053',
          firstName: 'Jane',
          lastName: 'Doe',
        ),
        id: "7",
        createdAt: 1231,
        name: "",
        size: 512000,
        uri:
            "https://www.adobe.com/fr/express/feature/image/media_16ad2258cac6171d66942b13b8cd4839f0b6be6f3.png"),
    const types.FileMessage(
      author: types.User(
        id: '1',
        firstName: 'Jane',
        lastName: 'Doe',
      ),
      id: '8',
      createdAt: 21231,
      name: 'ahmed',
      size: 512000,
      uri: "https://www.africau.edu/images/default/sample.pdf",
    ),
  ];

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  Future handleAtachmentPressed() async {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: Get.context!,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: PrimaryText(LocaleKeys.camera.tr),
                  onPressed: () async {
                    Get.back();
                    await handleImageSelection(imageSource: ImageSource.camera);
                  },
                ),
                CupertinoActionSheetAction(
                  child: PrimaryText("gallery".tr),
                  onPressed: () async {
                    Get.back();
                    await handleImageSelection(
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
                      await handleFileSelection();
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
                    await handleImageSelection(imageSource: ImageSource.camera);
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
                    await handleImageSelection(
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
                      await handleFileSelection();
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

  Future handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null && result.files.single.path != null) {
      setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);
      try {
        setAttachmentUploading(false);
      } finally {
        setAttachmentUploading(false);
      }
    }
    update();
  }

  Future<void> handleSendPressed(types.PartialText message) async {
    update();
  }

  Future handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;
      if (message.uri.startsWith('http')) {
        if (message.uri.startsWith('http')) {
          try {} finally {
            final updatedMessage = message.copyWith(isLoading: false);
          }
        }
      }
      await OpenFile.open(localPath);
    } else if (message is types.ImageMessage) {
      await Get.dialog(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: message.uri,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Container(
                      margin: EdgeInsets.only(top: 100.h, bottom: 100.h),
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: ColorManager.black,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 5.w,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (Get.isDialogOpen!) {
                        Get.back();
                      }
                    },
                    child: Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    update();
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
                      ClipboardData(text: (message as types.TextMessage).text),
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
                              .then((bool? value) {
                            if (Get.isDialogOpen!) {
                              Get.back();
                            }
                            CustomSnackBar.showCustomSnackBar(
                                title: LocaleKeys.success.tr,
                                message: LocaleKeys.image_saved.tr);
                          });
                        }
                      } on PlatformException catch (error) {
                        if (Get.isDialogOpen!) {
                          Get.back();
                        }
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
                            message: LocaleKeys.message_copied_succesfully.tr);
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

  void handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    // final updatedMessage = message.copyWith(previewData: previewData);
    // FirebaseChatCore.instance.updateMessage(updatedMessage, room.id);
    update();
  }

  Future handleImageSelection({required ImageSource imageSource}) async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: imageSource,
    );
    if (result != null) {
      setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;
      try {
        setAttachmentUploading(false);
      } finally {
        setAttachmentUploading(false);
      }
    }
    update();
  }

  void setAttachmentUploading(bool uploading) {
    isAttachmentUploading = uploading;
    update();
  }

  @override
  void onClose() {}
}
