import '../models/preferred_teacher/preferred_teacher.dart';

abstract class PreferredTeachersRepo {
  Future<List<PreferredTeacher>> getPreferredTeachers({
    required int page,
    required int perPage,
    String? searchValue,
  });
}
