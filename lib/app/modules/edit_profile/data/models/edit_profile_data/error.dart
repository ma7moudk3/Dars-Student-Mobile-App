class Error {
  int? code;
  String? message;
  dynamic details;
  dynamic validationErrors;

  Error({this.code, this.message, this.details, this.validationErrors});

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json['code'] as int?,
        message: json['message'] as String?,
        details: json['details'] as dynamic,
        validationErrors: json['validationErrors'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'details': details,
        'validationErrors': validationErrors,
      };
}
