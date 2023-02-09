import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hessa_student/app/modules/hessa_teachers/data/models/hessa_teacher.dart';
import 'package:hessa_student/app/modules/hessa_teachers/data/repos/hessa_teachers_repo.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../data/repos/hessa_teachers_repo_implement.dart';

class HessaTeachersController extends GetxController {
  bool isSearchIconVisible = false,
      toggleSearch = false,
      toggleFilter = false,
      toggleSort = false;
  Timer? _debounce;
  static const _pageSize = 6; // 6 teachers per page
  final int _debounceTime = 800;
  late TextEditingController searchTextController;
  PagingController<int, HessaTeacher> pagingController =
      PagingController(firstPageKey: 1); // item = hessa teacher
  int teacherGender = 0; // 0 male, 1 female, 2 both
  int teacherFilterFactor = 0; // 0 acacdemic learning, 1 skill
  FocusNode searchFocusNode = FocusNode();
  List<HessaTeacher> hessaTeachers = [];
  RxBool isInternetConnected = true.obs;
  final HessaTeachersRepo _hessaTeacherRepo = HessaTeachersRepoImplement();
  void changeFilterFactor(int value) {
    teacherFilterFactor = value;
    update();
  }

  Future _onSearchChanged() async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceTime), () async {
      if (searchTextController.text.isNotEmpty &&
          searchTextController.text.length >= 3 && // three letters
          (searchTextController.text.trim().isNotEmpty)) {
        if (await checkInternetConnection(timeout: 10)) {
          toggleSearch = true;
          pagingController.refresh();
        } else {
          await Get.toNamed(Routes.CONNECTION_FAILED);
        }
      }
    });
  }

  void changeTeacherGender(int value) {
    teacherGender = value;
    update();
  }

  @override
  void onInit() async {
    searchTextController = TextEditingController();
    searchTextController.addListener(_onSearchChanged);
    if (Get.arguments != null && Get.arguments["searchFocus"] == true) {
      searchFocusNode.requestFocus();
    }
    _initPageRequestListener();
    await checkInternet();
    super.onInit();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10).then(
      (bool internetStatus) async {
        isInternetConnected.value = internetStatus;
      },
    );
    update();
  }

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      await getHessaTeachers(page: pageKey);
    });
  }

  Future getHessaTeachers({required int page}) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        hessaTeachers =
            await _hessaTeacherRepo.getHessaTeachers(page: page, perPage: _pageSize);
        final isLastPage = hessaTeachers.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(hessaTeachers);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(hessaTeachers, nextPageKey);
        }
      }else{
        isInternetConnected.value = false;
      }
    } on DioError catch (e) {
      log("getHessaTeachers DioError ${e.message}");
    }
    update();
  }

  void makeSearchIconVisible(String value) {
    isSearchIconVisible = value.isNotEmpty && value.trim().isNotEmpty;
    update();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    searchTextController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  void onClose() {}
}
