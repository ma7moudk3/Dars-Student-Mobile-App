
import '../../../constants/exports.dart';

class MessagesController extends GetxController {
  int length = 10;

  void deleteMessage() {
    length--;
    update();
  }
  
  @override
  void onClose() {}
}
