import 'package:hessa_student/app/modules/order_details/data/models/order_details/order_details.dart';
import 'package:hessa_student/app/modules/order_details/data/models/order_session/order_session.dart';

import '../models/candidate_providers/candidate_providers.dart';

abstract class OrderDetailsRepo {
  Future<OrderDetails> getDarsOrderDetails({
    required int darsOrder,
  });
  Future<CandidateProviders> getCandidateProviders({
    required int darsOrder,
  });

  Future<int> cancelDarsOrder({
    required int darsOrderId,
    required String reason,
  });

  Future<List<OrderSession>> getDarsOrderSessions({
    required int darsOrderId,
    required int page,
    required int perPage,
  });

  Future<int> deleteSession({
    required int sessionId,
  });
}
