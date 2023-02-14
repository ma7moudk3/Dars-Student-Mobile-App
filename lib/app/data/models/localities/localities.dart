import 'result.dart';

class Localities {
  List<Result>? result;
  dynamic targetUrl;
  bool? success;
  dynamic error;
  bool? unAuthorizedRequest;
  bool? abp;

  Localities({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  factory Localities.fromJson(Map<String, dynamic> json) => Localities(
        result: (json['result'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
        targetUrl: json['targetUrl'] as dynamic,
        success: json['success'] as bool?,
        error: json['error'] as dynamic,
        unAuthorizedRequest: json['unAuthorizedRequest'] as bool?,
        abp: json['__abp'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'result': result?.map((e) => e.toJson()).toList(),
        'targetUrl': targetUrl,
        'success': success,
        'error': error,
        'unAuthorizedRequest': unAuthorizedRequest,
        '__abp': abp,
      };
}
