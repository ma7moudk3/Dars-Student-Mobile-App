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
      id: '3',
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
        id: '1',
        firstName: 'Jane',
        lastName: 'Doe',
      ),
      id: '5',
      text:
          "Hey, I am Jane. How are you?, I just wanted to tell you about this: https://www.textfixer.com/tools/remove-line-breaks.php",
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
        name: "",
        size: 512000,
        uri:
            "https://www.adobe.com/fr/express/feature/image/media_16ad2258cac6171d66942b13b8cd4839f0b6be6f3.png?width=750&format=png&optimize=medium"),
    const types.ImageMessage(
        author: types.User(
          id: '1',
          firstName: 'Jane',
          lastName: 'Doe',
        ),
        id: "7",
        name: "",
        size: 512000,
        uri:
            "https://www.adobe.com/fr/express/feature/image/media_16ad2258cac6171d66942b13b8cd4839f0b6be6f3.png?width=750&format=png&optimize=medium"),
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
