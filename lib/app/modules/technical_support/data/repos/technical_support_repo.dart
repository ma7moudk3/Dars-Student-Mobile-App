import 'package:hessa_student/app/modules/technical_support/data/models/urgency_type/result.dart';

import '../models/urgency_type/urgency_type.dart';

abstract class TechnicalSupportRepo {
  Future<UrgencyType> getUrgencyTypes();

  Future<int> sendTechnicalSupportMessage({
    required String fullName,
    required String email,
    required String message,
    required Result urgencyType,
  });
}
