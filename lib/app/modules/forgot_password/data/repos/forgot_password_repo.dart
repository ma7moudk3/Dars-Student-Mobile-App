abstract class ForgotPasswordRepo {
  Future<int> sendPasswordResetCode({required String emailAddress});
}
