import 'dart:developer';
import 'dart:io';

import 'package:hessa_student/app/data/models/school_types/school_types.dart';
import 'package:hessa_student/app/data/models/student_relation/student_relation.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';

import 'package:hessa_student/app/data/models/classes/classes.dart';
import 'package:hessa_student/app/modules/add_new_dependent/data/models/dependent/dependent.dart';
import 'package:hessa_student/app/modules/edit_profile/data/repos/edit_profile_repo.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../../../constants/exports.dart';
import '../../../../constants/links.dart';
import '../../../../data/cache_helper.dart';
import '../../../../data/network_helper/dio_helper.dart';
import '../../../edit_profile/data/repos/edit_profile_repo_implement.dart';
import 'add_new_dependent_repo.dart';

class AddNewDependentRepoImplement extends AddNewDependentRepo {
  final EditProfileRepo _editProfileRepo = EditProfileRepoImplement();
  @override
  Future<Topics> getTopics() async {
    Topics topics = Topics();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        Links.topicsForDropDown,
        headers: headers,
        onSuccess: (response) {
          var result = response.data;
          topics = Topics.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getTopics: $e");
    }
    return topics;
  }

  @override
  Future<Classes> getClasses() async {
    Classes classes = Classes();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        Links.classesForDropDown,
        headers: headers,
        onSuccess: (response) {
          var result = response.data;
          classes = Classes.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getClasses: $e");
    }
    return classes;
  }

  @override
  Future<StudentRelation> getStudentRelations() async {
    StudentRelation studentRelations = StudentRelation();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        Links.studentRelationsForDropDown,
        headers: headers,
        onSuccess: (response) {
          var result = response.data;
          studentRelations = StudentRelation.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getStudentRelations: $e");
    }
    return studentRelations;
  }

  @override
  Future<SchoolTypes> getSchoolTypes() async {
    SchoolTypes schoolTypes = SchoolTypes();
    try {
      Map<String, dynamic> headers = {
        "Accpet": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.get(
        Links.schoolTypesForDropDown,
        headers: headers,
        onSuccess: (response) {
          var result = response.data;
          schoolTypes = SchoolTypes.fromJson(result);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (e) {
      log("Error in getSchoolTypes: $e");
    }
    return schoolTypes;
  }

  @override
  Future<Dependent> addNewDependent({
    required String name,
    required int genderId,
    required String schoolName,
    String? details,
    required int relationId,
    required int levelId,
    required int schoolTypeId,
    int? id,
    File? image,
  }) async {
    Dependent dependent = Dependent();
    try {
      dynamic data = {
        "name": name,
        "genderId": genderId,
        "schoolName": schoolName,
        "details": details ?? "",
        "requesterId": CacheHelper.instance.getCachedCurrentUserInfo() != null
            ? CacheHelper.instance.getCachedCurrentUserInfo()!.result != null &&
                    CacheHelper.instance
                            .getCachedCurrentUserInfo()!
                            .result!
                            .id !=
                        null
                ? CacheHelper.instance.getCachedCurrentUserInfo()!.result!.id
                : 0
            : 0,
        "relationId": relationId,
        "levelId": levelId,
        "schoolTypeId": schoolTypeId,
        "id": id ?? 0,
      };
      if (image != null) {
        String? fileToken = await _editProfileRepo.updateProfilePicture(
            image: image, isForStudent: true);
        String fileName = image.path.split("/").last;
        if (fileToken != null) {
          data["requesterStudentPhotoToken"] = fileToken;
          data["requesterStudentPhotoFileName"] = fileName;
        }
      }
      Map<String, dynamic> headers = {
        'Accept-Language': Get.locale != null ? Get.locale!.languageCode : 'ar',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${CacheHelper.instance.getAccessToken()}"
      };
      await DioHelper.post(
        Links.addNewStudent,
        data: data,
        headers: headers,
        onSuccess: (response) {
          dependent = Dependent.fromJson(response.data);
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: LocaleKeys.error.tr,
            message: error.message,
          );
        },
      );
    } catch (error) {
      log("Error in addNewDependent: $error");
    }
    return dependent;
  }
}
