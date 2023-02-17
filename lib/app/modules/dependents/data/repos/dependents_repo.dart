import '../models/student/student.dart';

abstract class DependentsRepo {
  Future<List<Student>> getMyStudents({
    required int perPage,
    required int page,
  });

  Future<int> deleteStudent({required int studentId});
}
