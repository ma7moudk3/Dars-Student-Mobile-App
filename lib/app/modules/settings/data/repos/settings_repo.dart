abstract class SettingsRepo {
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
