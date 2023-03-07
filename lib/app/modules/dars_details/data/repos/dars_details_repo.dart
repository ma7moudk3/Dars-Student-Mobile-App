import 'package:hessa_student/app/modules/dars_details/data/models/dars_order_details/dars_order_details.dart';

abstract class DarsDetailsRepo {
  Future<DarsOrderDetails> getDarsOrderDetails({
    required int darsOrder,
  });
}
