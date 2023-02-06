import 'result.dart';

class LoginInfo {
  Result? result;
  dynamic targetUrl;
  bool? success;
  dynamic error;
  bool? unAuthorizedRequest;
  bool? abp;

  LoginInfo({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) => LoginInfo(
        result: json['result'] == null
            ? null
            : Result.fromJson(json['result'] as Map<String, dynamic>),
        targetUrl: json['targetUrl'] as dynamic,
        success: json['success'] as bool?,
        error: json['error'] as dynamic,
        unAuthorizedRequest: json['unAuthorizedRequest'] as bool?,
        abp: json['__abp'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'result': result?.toJson(),
        'targetUrl': targetUrl,
        'success': success,
        'error': error,
        'unAuthorizedRequest': unAuthorizedRequest,
        '__abp': abp,
      };
}
