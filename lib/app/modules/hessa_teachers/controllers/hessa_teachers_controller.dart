import 'dart:async';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';

class HessaTeachersController extends GetxController {
  bool isSearchIconVisible = false,
      toggleSearch = false,
      toggleFilter = false,
      toggleSort = false;
  Timer? _debounce;
  final int _debounceTime = 800;
  late TextEditingController searchTextController;
  int teacherGender = 0; // 0 male, 1 female, 2 both
  int teacherFilterFactor = 0; // 0 acacdemic learning, 1 skill
  FocusNode searchFocusNode = FocusNode();

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
        } else {
          Get.toNamed(Routes.CONNECTION_FAILED);
        }
      }
    });
  }

  void changeTeacherGender(int value) {
    teacherGender = value;
    update();
  }

  @override
  void onInit() {
    searchTextController = TextEditingController();
    searchTextController.addListener(_onSearchChanged);
    if (Get.arguments != null && Get.arguments["searchFocus"] == true) {
      searchFocusNode.requestFocus();
    }
    super.onInit();
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
