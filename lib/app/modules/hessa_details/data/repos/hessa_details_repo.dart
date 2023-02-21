import 'package:hessa_student/app/modules/hessa_details/data/models/hessa_order_details/hessa_order_details.dart';

abstract class HessaDetailsRepo {
  Future<HessaOrderDetails> getHessaOrderDetails({
    required int hessaOrderId,
  });
}
