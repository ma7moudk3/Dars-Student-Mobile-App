import 'package:hessa_student/app/data/models/countries/countries.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';

import '../../../../data/models/classes/classes.dart';
import '../../../../data/models/skills/skills.dart';
import '../models/hessa_teacher.dart';

abstract class HessaTeachersRepo {
  Future<List<HessaTeacher>> getHessaTeachers({
    String? searchValue,
    String? sortingField,
    String sortingOrder = "DESC",
    int? genderId,
    int? levelId,
    int? countryId,
    int? governorateId,
    int? topicId,
    int? skillId,
    required int page,
    required int perPage,
  });

  Future<Countries> getCountries();
  Future<Classes> getClasses();
  Future<Skills> getSkills();
  Future<Topics> getTopics();
}
