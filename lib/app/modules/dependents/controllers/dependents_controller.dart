import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/models/student/student.dart';
import '../data/repos/dependents_repo.dart';
import '../data/repos/dependents_repo_implement.dart';

class DependentsController extends GetxController {
  RxBool isInternetConnected = true.obs;
  final DependentsRepo _dependentsRepo = DependentsRepoImplement();
  static const _pageSize = 6; // 6 students per page
  PagingController<int, Student> pagingController = PagingController(
      firstPageKey: 1); // Student = RequesterDependent or RequesterStudent :)
  List<Student> myStudents = [];

  @override
  void onInit() async {
    _initPageRequestListener();
    await checkInternet();
    super.onInit();
  }

  void refreshPagingController() {
    pagingController.refresh();
    update();
  }

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      await getMyStudents(page: pageKey);
    });
  }

  Future getMyStudents({required int page}) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        myStudents =
            await _dependentsRepo.getMyStudents(page: page, perPage: _pageSize);
        final isLastPage = myStudents.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(myStudents);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(myStudents, nextPageKey);
        }
      } else {
        isInternetConnected.value = false;
      }
    } on DioError catch (e) {
      log("getMyStudents DioError ${e.message}");
    }
    update();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
    });
  }

  @override
  void onClose() {}
}
