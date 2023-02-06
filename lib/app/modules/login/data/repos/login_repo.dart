import '../models/current_user_info/current_user_info.dart';

abstract class LoginRepo {
  Future<int> login({
    required String login,
    required String password,
  });

  Future<CurrentUserInfo> getCurrentUserInfo();
}
