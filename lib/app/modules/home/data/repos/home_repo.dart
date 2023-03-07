import '../models/dars_order.dart';

abstract class HomeRepo {
  Future<List<DarsOrder>> getRecentDarsOrders();
}
