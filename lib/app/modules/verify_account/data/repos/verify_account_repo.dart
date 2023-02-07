import '../../../verify_otp/data/models/verify_otp_response/verify_otp_response.dart';
import '../models/generate_otp_code/generate_otp_code.dart';

abstract class VerifyAccountRepo {
  Future<GenerateOtpCode> sendOTP({
    String? phoneNumber,
    String? emailAddress,
    bool isPhoneChanged = false,
  });

  Future<int> logout();

  Future<VerifyOtpResponse> verifyOTP({
    String? phoneNumber,
    String? emailAddress,
    required String otpCode,
  });
}
