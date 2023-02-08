class Links {
  static const String baseLink = 'https://api.hessaedu.com/';
  static const String register = 'api/services/app/Account/Register';
  static const String login = 'api/TokenAuth/Authenticate';
  static const String logout = 'api/TokenAuth/LogOut';
  static const String getCurrentUserInfo =
      'api/services/app/Session/GetCurrentUserInfo';
  static const String getCurrentUserProfileInfo =
      'api/services/app/Requesters/GetRequesterForEdit';
  static const String generateOTPCode =
      'api/services/app/VerificationCodes/GenerateCode';
  static const String verifyOTPCodeEmail =
      'api/services/app/Profile/ActivateEmail';
  static const String verifyOTPCodeMobile =
      'api/services/app/Profile/ActivateMobile';
  static const String sendResetPasswordCode =
      "api/services/app/Account/SendPasswordResetCode";
  static const String profileImageById =
      "File/GetUserProfileImageById";
}
