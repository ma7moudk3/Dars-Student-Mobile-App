class Result {
  bool? isValid;
  int? code;
  dynamic message;
  dynamic details;
  dynamic validationErrors;

  Result({
    this.isValid,
    this.code,
    this.message,
    this.details,
    this.validationErrors,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        isValid: json['isValid'] as bool?,
        code: json['code'] as int?,
        message: json['message'] as dynamic,
        details: json['details'] as dynamic,
        validationErrors: json['validationErrors'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'isValid': isValid,
        'code': code,
        'message': message,
        'details': details,
        'validationErrors': validationErrors,
      };
}
