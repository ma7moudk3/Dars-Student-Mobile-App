import '../models/hessa_order.dart';

abstract class HomeRepo {
  Future<List<HessaOrder>> getRecentHessaOrders();
}
