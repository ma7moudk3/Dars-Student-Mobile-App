import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../routes/app_pages.dart';
import '../../order_hessa/data/repos/order_hessa_repo.dart';
import '../../order_hessa/data/repos/order_hessa_repo_implement.dart';
import '../data/models/student/student.dart';
import '../data/repos/dependents_repo.dart';
import '../data/repos/dependents_repo_implement.dart';

class DependentsController extends GetxController {
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  final OrderHessaRepo _orderHessaRepo = OrderHessaRepoImplement();
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
    update();
  }

  Future deleteStudent({required int studentId}) async {
    if (studentId != -1) {
      if (await checkInternetConnection(timeout: 10)) {
        showLoadingDialog();
        await _dependentsRepo
            .deleteStudent(studentId: studentId)
            .then((int statusCode) {
          if (statusCode == 200) {
            CustomSnackBar.showCustomSnackBar(
              title: LocaleKeys.success.tr,
              message: LocaleKeys.student_deleted_successfully.tr,
            );
            refreshPagingController();
          }
        });
      } else {
        await Get.toNamed(Routes.CONNECTION_FAILED);
      }
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
        title: LocaleKeys.error.tr,
        message: LocaleKeys.please_choose_a_valid_student_to_delete.tr,
      );
    }
  }

  @override
  void onClose() {}
}
