import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/preferred_teachers/data/models/preferred_teacher/preferred_teacher.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/repos/preferred_teachers_repo.dart';
import '../data/repos/preferred_teachers_repo_implement.dart';

class PreferredTeachersController extends GetxController {
  List<PreferredTeacher> preferredTeachers = [];
  static const _pageSize = 6; // 6 teachers per page
  RxBool isLoading = false.obs, isInternetConnected = true.obs;
  PagingController<int, PreferredTeacher> pagingController =
      PagingController(firstPageKey: 1); // item = preferred teacher
  final PreferredTeachersRepo _preferredTeacherRepo =
      PreferredTeachersRepoImplement();
  @override
  onInit() async {
    _initPageRequestListener();
    await checkInternet();
    super.onInit();
  }

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      await getPreferredTeachers(page: pageKey);
    });
  }

  Future getPreferredTeachers({required int page}) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        preferredTeachers = await _preferredTeacherRepo.getPreferredTeachers(
            page: page, perPage: _pageSize);
        final isLastPage = preferredTeachers.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(preferredTeachers);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(preferredTeachers, nextPageKey);
        }
      } else {
        isInternetConnected.value = false;
      }
    } on DioError catch (e) {
      log("getHessaTeachers DioError ${e.message}");
    }
    update();
  }

  Future<void> checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
    });
    update();
  }
}
