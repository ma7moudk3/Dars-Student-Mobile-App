import 'package:hessa_student/app/modules/teacher_details/data/models/hessa_teacher_details/hessa_teacher_details.dart';

abstract class TeacherDetailsRepo {
  Future<HessaTeacherDetails> getTeacherDetails({required int teacherId});
  Future<int> addTeacherToFavorite({required int teacherId});
  Future<int> removeTeacherFromFavorite({required int teacherId});
}
