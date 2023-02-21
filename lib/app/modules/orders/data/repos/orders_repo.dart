import 'package:hessa_student/app/modules/home/data/models/hessa_order.dart';

abstract class OrdersRepo {
  Future<List<HessaOrder>> getHessaOrders({
    required int page,
    required int perPage,
  });
}
