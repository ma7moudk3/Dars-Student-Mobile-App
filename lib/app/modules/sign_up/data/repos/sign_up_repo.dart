import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';

abstract class SignUpRepo {
  Future<int?> register({
    required String gender,
    required String fullName,
    required String phoneNumber,
    required String emailAddress,
    required String password,
    required String captchaResponse,
  });
}
