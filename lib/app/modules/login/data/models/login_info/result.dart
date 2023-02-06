class Result {
  String? accessToken;
  String? encryptedAccessToken;
  int? expireInSeconds;
  bool? shouldResetPassword;
  dynamic passwordResetCode;
  int? userId;
  bool? requiresTwoFactorVerification;
  dynamic twoFactorAuthProviders;
  dynamic twoFactorRememberClientToken;
  dynamic returnUrl;
  String? refreshToken;
  int? refreshTokenExpireInSeconds;

  Result({
    this.accessToken,
    this.encryptedAccessToken,
    this.expireInSeconds,
    this.shouldResetPassword,
    this.passwordResetCode,
    this.userId,
    this.requiresTwoFactorVerification,
    this.twoFactorAuthProviders,
    this.twoFactorRememberClientToken,
    this.returnUrl,
    this.refreshToken,
    this.refreshTokenExpireInSeconds,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        accessToken: json['accessToken'] as String?,
        encryptedAccessToken: json['encryptedAccessToken'] as String?,
        expireInSeconds: json['expireInSeconds'] as int?,
        shouldResetPassword: json['shouldResetPassword'] as bool?,
        passwordResetCode: json['passwordResetCode'] as dynamic,
        userId: json['userId'] as int?,
        requiresTwoFactorVerification:
            json['requiresTwoFactorVerification'] as bool?,
        twoFactorAuthProviders: json['twoFactorAuthProviders'] as dynamic,
        twoFactorRememberClientToken:
            json['twoFactorRememberClientToken'] as dynamic,
        returnUrl: json['returnUrl'] as dynamic,
        refreshToken: json['refreshToken'] as String?,
        refreshTokenExpireInSeconds:
            json['refreshTokenExpireInSeconds'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'encryptedAccessToken': encryptedAccessToken,
        'expireInSeconds': expireInSeconds,
        'shouldResetPassword': shouldResetPassword,
        'passwordResetCode': passwordResetCode,
        'userId': userId,
        'requiresTwoFactorVerification': requiresTwoFactorVerification,
        'twoFactorAuthProviders': twoFactorAuthProviders,
        'twoFactorRememberClientToken': twoFactorRememberClientToken,
        'returnUrl': returnUrl,
        'refreshToken': refreshToken,
        'refreshTokenExpireInSeconds': refreshTokenExpireInSeconds,
      };
}
