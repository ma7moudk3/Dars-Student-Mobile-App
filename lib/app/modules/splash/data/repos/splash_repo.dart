import 'package:hessa_student/app/modules/splash/data/models/user_token/user_token.dart';

abstract class SplashRepo {
  Future<UserToken> refreshToken();
}
