import 'error.dart';

class SignUpHttpError {
  dynamic result;
  dynamic targetUrl;
  bool? success;
  Error? error;
  bool? unAuthorizedRequest;
  bool? abp;

  SignUpHttpError({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  factory SignUpHttpError.fromJson(Map<String, dynamic> json) {
    return SignUpHttpError(
      result: json['result'] as dynamic,
      targetUrl: json['targetUrl'] as dynamic,
      success: json['success'] as bool?,
      error: json['error'] == null
          ? null
          : Error.fromJson(json['error'] as Map<String, dynamic>),
      unAuthorizedRequest: json['unAuthorizedRequest'] as bool?,
      abp: json['__abp'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'result': result,
        'targetUrl': targetUrl,
        'success': success,
        'error': error?.toJson(),
        'unAuthorizedRequest': unAuthorizedRequest,
        '__abp': abp,
      };
}
