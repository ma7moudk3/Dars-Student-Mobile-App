import 'package:hessa_student/app/data/models/countries/countries.dart';

import '../models/hessa_teacher.dart';

abstract class HessaTeachersRepo {
  Future<List<HessaTeacher>> getHessaTeachers({
    String? searchValue,
    required int page,
    required int perPage,
  });

  Future<Countries> getCountries();
}
