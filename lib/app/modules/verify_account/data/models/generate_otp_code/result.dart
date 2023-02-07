class Result {
  int? numberOfSeconds;
  int? code;
  dynamic message;
  dynamic details;
  dynamic validationErrors;

  Result({
    this.numberOfSeconds,
    this.code,
    this.message,
    this.details,
    this.validationErrors,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        numberOfSeconds: json['numberOfSeconds'] as int?,
        code: json['code'] as int?,
        message: json['message'] as dynamic,
        details: json['details'] as dynamic,
        validationErrors: json['validationErrors'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'numberOfSeconds': numberOfSeconds,
        'code': code,
        'message': message,
        'details': details,
        'validationErrors': validationErrors,
      };
}
