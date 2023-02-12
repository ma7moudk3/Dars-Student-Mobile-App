import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hessa_student/app/data/models/countries/result.dart';
import 'package:hessa_student/app/modules/hessa_teachers/data/models/hessa_teacher.dart';
import 'package:hessa_student/app/modules/hessa_teachers/data/repos/hessa_teachers_repo.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../data/models/countries/countries.dart';
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
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  final HessaTeachersRepo _hessaTeacherRepo = HessaTeachersRepoImplement();
  Countries countries = Countries();
  Result selectedCountry = Result();
  
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

  void changeFilterFactor(int value) {
    teacherFilterFactor = value;
    update();
  }

  Future<void> resetTeachers() async {
    searchTextController.text = "";
    toggleFilter = false;
    toggleSort = false;
    pagingController.refresh();
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

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10).then(
      (bool internetStatus) async {
        isInternetConnected.value = internetStatus;
        if (isInternetConnected.value) {
          await Future.wait([_getCountries()])
              .then((value) => isLoading.value = false);
        }
      },
    );
    update();
  }

  void changeCountry(String result) {
    if (countries.result != null) {
      for (var country in countries.result ?? <Result>[]) {
        if (country.displayName != null &&
            country.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedCountry = country;
        }
      }
    }
    update();
  }

  Future _getCountries() async {
    countries = await _hessaTeacherRepo.getCountries();
    if (countries.result != null) {
      countries.result!.add(
        Result(
          id: -1,
          displayName: LocaleKeys.choose_country.tr,
        ),
      );
      countries.result!.sort((a, b) => a.id!.compareTo(b.id!));
    }
  }

  void _initPageRequestListener() {
    pagingController.addPageRequestListener((int pageKey) async {
      await getHessaTeachers(page: pageKey);
    });
  }

  Future getHessaTeachers({
    required int page,
  }) async {
    try {
      if (await checkInternetConnection(timeout: 10)) {
        hessaTeachers = await _hessaTeacherRepo.getHessaTeachers(
          page: page,
          perPage: _pageSize,
          searchValue: searchTextController.text.isNotEmpty &&
                  searchTextController.text.length >= 3 && // three letters
                  (searchTextController.text.trim().isNotEmpty)
              ? searchTextController.text
              : "",
        );
        final isLastPage = hessaTeachers.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(hessaTeachers);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(hessaTeachers, nextPageKey);
        }
      } else {
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
