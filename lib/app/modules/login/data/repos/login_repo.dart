import '../models/current_user_info/current_user_info.dart';
import '../models/current_user_profile_info/current_user_profile_info.dart';

abstract class LoginRepo {
  Future<int> login({
    required String login,
    required String password,
  });

  Future<int> googleLogin({
    required String accessToken,
    required String providerKey,
  });

  Future<int> facebookLogin({
    required String accessToken,
    required String providerKey,
  });

  Future<CurrentUserInfo> getCurrentUserInfo();
  Future<String> getCurrentUserProfilePicture();
  Future<CurrentUserProfileInfo> getCurrentUserProfileInfo();
}
