import 'package:hessa_student/app/modules/teacher_details/data/models/teacher_details/dars_teacher_details.dart';

abstract class TeacherDetailsRepo {
  Future<DarsTeacherDetails> getTeacherDetails({required int teacherId});
  Future<int> addTeacherToFavorite({required int teacherId});
  Future<int> removeTeacherFromFavorite({required int teacherId});
}
