import 'package:hessa_student/app/data/models/classes/classes.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';

abstract class OrderHessaRepo {
  Future<Classes> getClasses();
  Future<Topics> getTopics();
}
