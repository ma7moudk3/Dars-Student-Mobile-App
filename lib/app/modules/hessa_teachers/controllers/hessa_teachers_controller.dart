import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../global_presentation/global_widgets/typeahead/cupertino_flutter_typeahead.dart';
import 'package:hessa_student/app/data/models/countries/result.dart' as country;
import 'package:hessa_student/app/data/models/topics/result.dart' as topic;
import '../../../data/models/governorates/result.dart' as governorate;
import '../../../data/models/classes/item.dart' as level;
import '../../../data/models/governorates/governorates.dart';
import '../../../data/models/skills/item.dart' as skill;
import 'package:hessa_student/app/modules/hessa_teachers/data/models/hessa_teacher.dart';
import 'package:hessa_student/app/modules/hessa_teachers/data/repos/hessa_teachers_repo.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../data/models/classes/classes.dart';
import '../../../data/models/countries/countries.dart';
import '../../../data/models/skills/skills.dart';
import '../../../data/models/topics/topics.dart';
import '../../../routes/app_pages.dart';
import '../../add_new_address/data/repos/add_new_address_repo.dart';
import '../../add_new_address/data/repos/add_new_address_repo_implement.dart';
import '../data/repos/hessa_teachers_repo_implement.dart';

class HessaTeachersController extends GetxController {
  bool isSearchIconVisible = false,
      toggleSearch = false,
      toggleFilter = false,
      toggleSort = false,
      isGovernorateDropDownLoading = false;
  Timer? _debounce;
  static const _pageSize = 6; // 6 teachers per page
  final int _debounceTime = 800;
  late TextEditingController searchTextController,
      topicController; // subject = topic
  final CupertinoSuggestionsBoxController suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  PagingController<int, HessaTeacher> pagingController =
      PagingController(firstPageKey: 1); // item = hessa teacher
  int teacherGender = 0; // 1 male, 2 female, starts from zero just for indexing
  int teacherFilterFactor = 0; // 0 acacdemic learning, 1 skill
  FocusNode searchFocusNode = FocusNode();
  List<HessaTeacher> hessaTeachers = [];
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  final HessaTeachersRepo _hessaTeacherRepo = HessaTeachersRepoImplement();
  Countries countries = Countries();
  Governorates governorates = Governorates();
  Skills skills = Skills();
  Classes classes = Classes();
  Topics topics = Topics();
  level.Item selectedClass = level.Item();
  topic.Result selectedTopic = topic.Result();
  country.Result selectedCountry = country.Result();
  governorate.Result selectedGovernorate = governorate.Result();
  skill.Item selectedSkill = skill.Item();
  // String? sortType;
  int? levelId, topicId, skillId, genderId, countryId, governorateId;
  final AddNewAddressRepo _addNewAddressRepo = AddNewAddressRepoImplement();
  List<Map<String, dynamic>> filterList = [];
  @override
  void onInit() async {
    searchTextController = TextEditingController();
    topicController = TextEditingController();
    if (Get.arguments != null && Get.arguments["searchFocus"] == true) {
      searchFocusNode.requestFocus();
    }
    searchTextController.addListener(_onSearchChanged);
    _initPageRequestListener();
    await checkInternet();
    super.onInit();
  }

  void changeFilterFactor(int value) {
    teacherFilterFactor = value;
    update();
  }
  
  Future resetTeachers() async {
    searchTextController.clear();
    levelId = null;
    topicId = null;
    skillId = null;
    selectedSkill = skills.result!.items![0];
    selectedClass = classes.result!.items![0];
    selectedTopic = topics.result![0];
    selectedCountry = countries.result![0];
    genderId = -1;
    countryId = null;
    governorateId = null;
    isGovernorateDropDownLoading = true;
    update();
    Future.delayed(const Duration(milliseconds: 500), () {
      governorates = Governorates();
      selectedGovernorate = governorate.Result();
      isGovernorateDropDownLoading = false;
      update();
    });
    teacherGender = 0;
    teacherFilterFactor = 0;
    // sortType = null;
    toggleSort = false;
    toggleFilter = false;
    toggleSearch = false;
    filterList.clear();
    pagingController.refresh();
    update();
  }

  // Future sortTeacher({required String sortType}) async {
  //   this.sortType = sortType;
  //   toggleSort = true;
  //   pagingController.refresh();
  //   update();
  // }

  Future filterTeachers({
    int? levelId,
    int? topicId,
    int? skillId,
    int? genderId,
    int? countryId,
    int? governorateId,
  }) async {
    this.genderId = genderId != -1 ? genderId : null;
    this.countryId = countryId != -1 ? countryId : null;
    this.governorateId = governorateId != -1 ? governorateId : null;
    if (teacherFilterFactor == 0) {
      this.levelId = levelId != -1 ? levelId : null;
      this.topicId = topicId != -1 ? topicId : null;
      this.skillId = null;
      // delete the selectedSkill and add the selectedClass and selectedTopic
      filterList.removeWhere((element) => element["selectedSkill"] != null);
      if (this.levelId != null &&
          this.levelId != -1 &&
          selectedClass.id != null &&
          selectedClass.id != -1) {
        filterList.removeWhere((element) => element["selectedClass"] != null);
        filterList.add({
          "selectedClass": selectedClass,
          "displayName": selectedClass.displayName ?? "",
        });
      } else {
        filterList.removeWhere((element) => element["selectedClass"] != null);
      }
      if (this.topicId != null &&
          this.topicId != -1 &&
          selectedTopic.id != null &&
          selectedTopic.id != -1) {
        // here's the opposite of the above
        filterList.removeWhere((element) => element["selectedTopic"] != null);
        filterList.add({
          "selectedTopic": selectedTopic,
          "displayName": selectedTopic.displayName ?? "",
        });
      } else {
        filterList.removeWhere((element) => element["selectedTopic"] != null);
      }
      update();
    }
    if (teacherFilterFactor == 1) {
      this.skillId = skillId != -1 ? skillId : null;
      this.levelId = null;
      this.topicId = null;
      if (this.skillId != null &&
          this.skillId != -1 &&
          selectedSkill.id != null &&
          selectedSkill.id != -1) {
        filterList.removeWhere((element) => element["selectedSkill"] != null);
        filterList.add({
          "selectedSkill": selectedSkill,
          "displayName": selectedSkill.displayName ?? "",
        });
      } else {
        filterList.removeWhere((element) => element["selectedSkill"] != null);
      }
      filterList.removeWhere((element) => element["selectedClass"] != null);
      filterList.removeWhere((element) => element["selectedTopic"] != null);
      update();
    }
    log("levelId: ${this.levelId}");
    log("topicId: ${this.topicId}");
    log("skillId: ${this.skillId}");
    log("genderId: ${this.genderId}");
    log("countryId: ${this.countryId}");
    log("governorateId: ${this.governorateId}");
    log("teacherFilterFactor: $teacherFilterFactor");
    if (this.countryId != null &&
        this.countryId != -1 &&
        selectedCountry.id != null &&
        selectedCountry.id != -1) {
      filterList.removeWhere((element) => element["selectedCountry"] != null);
      filterList.add({
        "selectedCountry": selectedCountry,
        "displayName": selectedCountry.displayName ?? "",
      });
    } else {
      filterList.removeWhere((element) => element["selectedCountry"] != null);
    }
    if (this.governorateId != null &&
        this.governorateId != -1 &&
        selectedGovernorate.id != null &&
        selectedGovernorate.id != -1) {
      filterList
          .removeWhere((element) => element["selectedGovernorate"] != null);
      filterList.add({
        "selectedGovernorate": selectedGovernorate,
        "displayName": selectedGovernorate.displayName ?? "",
      });
    } else {
      filterList
          .removeWhere((element) => element["selectedGovernorate"] != null);
    }
    if (this.genderId != null && this.genderId != -1 && teacherGender != -1) {
      filterList.removeWhere((element) => element["teacherGender"] != null);
      filterList.add({
        "teacherGender": teacherGender,
        "displayName":
            this.genderId == 1 ? LocaleKeys.male.tr : LocaleKeys.female.tr,
      });
    } else {
      filterList.removeWhere((element) => element["teacherGender"] != null);
    }
    toggleFilter = true;
    pagingController.refresh();
    update();
  }

  Future removeFilterTag({required Map<String, dynamic> filterTag}) async {
    filterList
        .removeWhere((element) => element.keys.first == filterTag.keys.first);
    switch (filterTag.keys.first) {
      case "selectedClass":
        selectedClass = classes.result!.items![0];
        levelId = null;
        break;
      case "selectedTopic":
        selectedTopic = topics.result![0];
        topicId = null;
        break;
      case "selectedSkill":
        selectedSkill = skills.result!.items![0];
        skillId = null;
        break;
      case "teacherGender":
        teacherGender = 0;
        genderId = -1;
        break;
      case "selectedCountry":
        filterList.removeWhere((element) =>
            element["selectedGovernorate"] !=
            null); // delete also the selectedGovernorate
        selectedCountry = countries.result![0];
        countryId = null;
        governorateId = null;
        isGovernorateDropDownLoading = true;
        update();
        await Future.delayed(const Duration(milliseconds: 500), () {
          governorates = Governorates();
          selectedGovernorate = governorate.Result();
          isGovernorateDropDownLoading = false;
          update();
        });
        break;
      case "selectedGovernorate":
        governorateId = null;
        isGovernorateDropDownLoading = true;
        update();
        Future.delayed(const Duration(milliseconds: 500), () {
          governorates = Governorates();
          selectedGovernorate = governorate.Result();
          isGovernorateDropDownLoading = false;
          update();
        });
        break;
    }
    if (filterList.isEmpty) {
      toggleFilter = false;
    }
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
          await Future.wait([
            _getCountries(),
            _getClasses(),
            _getSkills(),
            _getTopics(),
          ]).then((value) {
            isLoading.value = false;
            _initDataWhichSentThroughApi();
          });
        }
      },
    );
    update();
  }

  void _initDataWhichSentThroughApi() {
    selectedSkill = skills.result?.items?[0] ?? skill.Item();
    selectedClass = classes.result?.items?[0] ?? level.Item();
    selectedTopic = topics.result?[0] ?? topic.Result();
    selectedCountry = countries.result?[0] ?? country.Result();
    genderId = -1;
    update();
  }

  Future changeCountry(String? result) async {
    isGovernorateDropDownLoading = true;
    update();
    if (countries.result != null && result != null) {
      for (var country in countries.result ?? <country.Result>[]) {
        if (country.displayName != null &&
            country.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedCountry = country;
        }
      }
    }
    if (selectedCountry.id != null && selectedCountry.id != -1) {
      await _getGovernorate(countryId: selectedCountry.id!).then((value) {
        selectedGovernorate = governorate.Result();
        update();
      });
    } else {
      isGovernorateDropDownLoading = true;
      update();
      Future.delayed(const Duration(milliseconds: 500), () {
        governorates = Governorates();
        selectedGovernorate = governorate.Result();
        isGovernorateDropDownLoading = false;
        update();
      });
    }
  }

  Future changeGovernorate(String? result) async {
    if (governorates.result != null && result != null) {
      for (var governorate in governorates.result ?? <governorate.Result>[]) {
        if (governorate.displayName != null &&
            governorate.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedGovernorate = governorate;
        }
      }
    }
    update();
  }

  Future _getGovernorate({required int countryId}) async {
    await _addNewAddressRepo
        .getGovernorates(
          countryId: countryId,
        )
        .then((Governorates governorates) => {
              this.governorates = governorates,
              isGovernorateDropDownLoading = false,
            });
    if (governorates.result != null) {
      governorates.result!.insert(
        0,
        governorate.Result(
          id: -1,
          displayName: LocaleKeys.choose_city.tr,
        ),
      );
    }
    selectedGovernorate = governorates.result![0];
    update();
  }

  void changeSkill(String? result) {
    if (skills.result != null &&
        skills.result!.items != null &&
        result != null) {
      for (var skill in skills.result!.items ?? <skill.Item>[]) {
        if (skill.displayName != null &&
            skill.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedSkill = skill;
        }
      }
    }
    update();
  }

  // if using dropdown
  void changeTopic(String? result) {
    if (topics.result != null && result != null) {
      for (var topic in topics.result ?? <topic.Result>[]) {
        if (topic.displayName != null &&
            topic.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedTopic = topic;
        }
      }
    }
    update();
  }
  // if using typeahead
  // void changeTopic(topic.Result topic) {
  //   topicController.text = topic.displayName ?? "";
  //   selectedTopic = topic;
  //   update();
  // }

  void changeLevel(String? result) {
    if (classes.result != null &&
        classes.result!.items != null &&
        result != null) {
      for (var level in classes.result!.items ?? <level.Item>[]) {
        if (level.displayName != null &&
            level.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedClass = level;
        }
      }
    }
    update();
  }

  Future _getCountries() async {
    countries = await _hessaTeacherRepo.getCountries();
    if (countries.result != null) {
      countries.result!.insert(
        0,
        country.Result(
          id: -1,
          displayName: LocaleKeys.choose_country.tr,
        ),
      );
    }
  }

  Future _getClasses() async {
    classes = await _hessaTeacherRepo.getClasses();
    if (classes.result != null && classes.result!.items != null) {
      classes.result!.items!.insert(
        0,
        level.Item(
          id: -1,
          displayName: LocaleKeys.choose_studying_class.tr,
        ),
      );
    }
  }

  Future _getTopics() async {
    topics = await _hessaTeacherRepo.getTopics();
    if (topics.result != null) {
      topics.result!.insert(
        0,
        topic.Result(
          id: -1,
          displayName: LocaleKeys.choose_studying_subject.tr,
        ),
      );
    }
  }

  Future _getSkills() async {
    skills = await _hessaTeacherRepo.getSkills();
    if (skills.result != null && skills.result!.items != null) {
      skills.result!.items!.insert(
        0,
        skill.Item(
          id: -1,
          displayName: LocaleKeys.choose_skill.tr,
        ),
      );
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
              : null,
          countryId: countryId,
          governorateId: governorateId,
          genderId: genderId != -1 ? genderId : null,
          skillId: skillId,
          topicId: topicId,
          levelId: levelId,
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
    topicController.dispose();
    searchTextController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  void onClose() {}
}
