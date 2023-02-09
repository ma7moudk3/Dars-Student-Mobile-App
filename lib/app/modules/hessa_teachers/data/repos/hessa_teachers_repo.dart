import '../models/hessa_teacher.dart';

abstract class HessaTeachersRepo {
  Future<List<HessaTeacher>> getHessaTeachers({
    required int page,
    required int perPage,
  });
}
