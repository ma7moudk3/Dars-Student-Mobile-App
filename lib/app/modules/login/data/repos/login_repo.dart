abstract class LoginRepo {
  Future<int> login({
    required String login,
    required String password,
  });
}
