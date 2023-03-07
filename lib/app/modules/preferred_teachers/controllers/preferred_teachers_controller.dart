import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/modules/preferred_teachers/data/models/preferred_teacher/preferred_teacher.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/cache_helper.dart';
import '../../teacher_details/data/repos/teacher_details_repo.dart';
import '../../teacher_details/data/repos/teacher_details_repo_implement.dart';
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
  final TeacherDetailsRepo _teacherDetailsRepo = TeacherDetailsRepoImplement();
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

  Future unPreferTeacher({required int teacherId}) async {
    if (CacheHelper.instance.authenticated()) {
      if (teacherId != -1) {
        await _teacherDetailsRepo.removeTeacherFromFavorite(
          teacherId: teacherId,
        );
        pagingController.refresh();
      }
    }
    update();
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
      log("getPreferredTeachers DioError ${e.message}");
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
