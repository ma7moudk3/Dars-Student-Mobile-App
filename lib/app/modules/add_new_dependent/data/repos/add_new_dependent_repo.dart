import 'package:hessa_student/app/data/models/classes/classes.dart';
import 'package:hessa_student/app/data/models/student_relation/student_relation.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';

import '../../../../data/models/school_types/school_types.dart';
import '../models/dependent/dependent.dart';

abstract class AddNewDependentRepo {
  Future<Dependent> addNewDependent({
    required String name,
    required int genderId,
    required String schoolName,
    required String dateOfBirth,
    String? details,
    required int relationId,
    required int levelId,
    required int schoolTypeId,
    int? id,
  });

  Future<Classes> getClasses();
  Future<Topics> getTopics();
  Future<StudentRelation> getStudentRelations();
  Future<SchoolTypes> getSchoolTypes();
}
