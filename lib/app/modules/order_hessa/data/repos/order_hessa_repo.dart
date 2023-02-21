import 'package:hessa_student/app/data/models/classes/classes.dart';
import 'package:hessa_student/app/data/models/skills/skills.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';

abstract class OrderHessaRepo {
  Future<int> addOrEditOrderHessa({
    required int targetGenderId,
    String? notes,
    required String preferredStartDate,
    required String preferredEndDate,
    required int sessionTypeId,
    required int productId,
    int? providerId,
    int? preferredProviderId,
    required int addressId,
    required List<int> orderStudentsIDs,
    required List<int> orderTopicsOrSkillsIDs,
    int? id, // hessa Id,
    int? paymentMethodId,
    double? rate,
    String? rateNotes,
    int? currencyId,
  });

  Future<Classes> getClasses();
  Future<Topics> getTopics();
  Future<Skills> getSkills();
}
