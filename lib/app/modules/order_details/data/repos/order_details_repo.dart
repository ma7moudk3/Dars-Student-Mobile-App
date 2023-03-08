import 'package:hessa_student/app/modules/order_details/data/models/order_details/order_details.dart';

import '../models/candidate_providers/candidate_providers.dart';

abstract class OrderDetailsRepo {
  Future<OrderDetails> getDarsOrderDetails({
    required int darsOrder,
  });
  Future<CandidateProviders> getCandidateProviders({
    required int darsOrder,
  });
}
