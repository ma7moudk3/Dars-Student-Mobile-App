import 'package:hessa_student/app/constants/exports.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/models/student/student.dart';

class DependentsController extends GetxController {
  List<Map<String, dynamic>> dummyDependents = [
    {
      "dependent_name": "وليد علي",
      "dependent_image": ImagesManager.avatar,
      "class": "الصف الثاني"
    },
    {
      "dependent_name": "شام محمد",
      "dependent_image": ImagesManager.avatar,
      "class": "الصف الأول"
    },
    {
      "dependent_name": "وائل محمد",
      "dependent_image": ImagesManager.avatar,
      "class": "الصف الرابع"
    },
    {
      "dependent_name": "وائل محمد",
      "dependent_image": ImagesManager.avatar,
      "class": "الصف الرابع"
    },
    {
      "dependent_name": "وائل محمد",
      "dependent_image": ImagesManager.avatar,
      "class": "الصف الرابع"
    },
    {
      "dependent_name": "وائل محمد",
      "dependent_image": ImagesManager.avatar,
      "class": "الصف الرابع"
    },
    {
      "dependent_name": "وائل محمد",
      "dependent_image": ImagesManager.avatar,
      "class": "الصف الرابع"
    },
  ]; // dummyDependents

  PagingController<int, Student> pagingController = PagingController(
      firstPageKey: 1); // Student = RequesterDependent or RequesterStudent :)

  void refreshPagingController() {
    pagingController.refresh();
    update();
  }

  @override
  void onClose() {}
}
