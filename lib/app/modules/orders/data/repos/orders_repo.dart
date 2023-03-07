import 'package:hessa_student/app/modules/home/data/models/dars_order.dart';

abstract class OrdersRepo {
  Future<List<DarsOrder>> getDarsOrders({
    required int page,
    required int perPage,
  });
}
