import 'provider_address.dart';
import 'provider_skill.dart';
import 'provider_teaching_topic.dart';
import 'providers.dart';

class Result {
  bool? isPreferred;
  List<ProviderSkill>? providerSkill;
  List<dynamic>? providersRates;
  List<ProviderTeachingTopic>? providerTeachingTopic;
  ProviderAddress? providerAddress;
  Providers? providers;
  String? userName;
  dynamic paymentMethodName;

  Result({
    this.isPreferred,
    this.providerSkill,
    this.providersRates,
    this.providerTeachingTopic,
    this.providerAddress,
    this.providers,
    this.userName,
    this.paymentMethodName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        isPreferred: json['isPreferred'] as bool?,
        providerSkill: (json['providerSkill'] as List<dynamic>?)
            ?.map((e) => ProviderSkill.fromJson(e as Map<String, dynamic>))
            .toList(),
        providersRates: json['providersRates'] as List<dynamic>?,
        providerTeachingTopic: (json['providerTeachingTopic'] as List<dynamic>?)
            ?.map((e) =>
                ProviderTeachingTopic.fromJson(e as Map<String, dynamic>))
            .toList(),
        providerAddress: json['providerAddress'] == null
            ? null
            : ProviderAddress.fromJson(
                json['providerAddress'] as Map<String, dynamic>),
        providers: json['providers'] == null
            ? null
            : Providers.fromJson(json['providers'] as Map<String, dynamic>),
        userName: json['userName'] as String?,
        paymentMethodName: json['paymentMethodName'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'isPreferred': isPreferred,
        'providerSkill': providerSkill?.map((e) => e.toJson()).toList(),
        'providersRates': providersRates,
        'providerTeachingTopic':
            providerTeachingTopic?.map((e) => e.toJson()).toList(),
        'providerAddress': providerAddress?.toJson(),
        'providers': providers?.toJson(),
        'userName': userName,
        'paymentMethodName': paymentMethodName,
      };
}
