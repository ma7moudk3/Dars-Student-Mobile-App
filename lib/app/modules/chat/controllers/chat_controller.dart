import 'dart:io';

import 'package:better_open_file/better_open_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';

import '../../../constants/exports.dart';

class ChatController extends GetxController with WidgetsBindingObserver {
  bool isAttachmentUploading = false;
  List<types.Message> messages = [
    const types.TextMessage(
      author: types.User(
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
      ),
      id: '1',
      text: 'السلام عليكم ورحمة الله وبركاته',
    ),
    const types.TextMessage(
      author: types.User(
        id: '2',
        firstName: 'Jane',
        lastName: 'Doe',
      ),
      id: '2',
      text: 'وعليكم السلام ورحمة الله وبركاته',
    ),
  ];

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
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
      Get.dialog(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InteractiveViewer(
            child: CachedNetworkImage(imageUrl: message.uri),
          ),
        ),
      );
    }
    update();
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
