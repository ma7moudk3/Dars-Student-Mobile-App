import 'package:hessa_student/app/data/models/classes/classes.dart';
import 'package:hessa_student/app/data/models/skills/skills.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';

abstract class OrderHessaRepo {
  Future<bool> addNewOrderHessa();

  Future<Classes> getClasses();
  Future<Topics> getTopics();
  Future<Skills> getSkills();
}
