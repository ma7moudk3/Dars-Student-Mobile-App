abstract class SignUpRepo {
  Future<int?> register({
    required int gender,
    required String fullName,
    required String phoneNumber,
    required String emailAddress,
    required String password,
    required String captchaResponse,
  });
}
