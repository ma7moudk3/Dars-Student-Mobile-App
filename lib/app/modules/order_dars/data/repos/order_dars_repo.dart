import 'package:hessa_student/app/data/models/classes/classes.dart';
import 'package:hessa_student/app/data/models/skills/skills.dart';
import 'package:hessa_student/app/data/models/topics/topics.dart';

import '../models/order_dars_to_edit/order_dars_to_edit.dart';
import '../models/product/product.dart';

abstract class OrderDarsRepo {
  Future<int> addOrEditOrderDars({
    required int targetGenderId,
    String? notes,
    required String preferredStartDate,
    required String preferredEndDate,
    required int sessionTypeId,
    required int productId,
    int? providerId = 0,
    int? preferredProviderId,
    required int addressId,
    required List<int> orderStudentsIDs,
    required List<int> orderTopicsOrSkillsIDs,
    int? id, // dars Id,
    int? paymentMethodId,
    int? rate,
    String? rateNotes,
    int? currencyId,
  });

  Future<Classes> getClasses();
  Future<Topics> getTopics();
  Future<Skills> getSkills();

  Future<OrderDarsToEdit> getOrderDarsToEdit({required int orderDarsToEditId});

  Future<List<Product>> getProducts({int? categoryIdFilter});
}
