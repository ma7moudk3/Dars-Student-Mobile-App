import 'preferred_provider.dart';

class PreferredTeacher {
  PreferredProvider? preferredProvider;
  String? providerName;
  String? providersNationalIdNumber;
  dynamic providerRate;
  String? requesterUserName;
  String? levelTopic;
  String? skills;
  String? country;
  String? governorate;

  PreferredTeacher({
    this.preferredProvider,
    this.providerName,
    this.providersNationalIdNumber,
    this.providerRate,
    this.requesterUserName,
    this.levelTopic,
    this.skills,
    this.country,
    this.governorate,
  });

  factory PreferredTeacher.fromJson(Map<String, dynamic> json) {
    return PreferredTeacher(
      preferredProvider: json['preferredProvider'] == null
          ? null
          : PreferredProvider.fromJson(
              json['preferredProvider'] as Map<String, dynamic>),
      providerName: json['providerName'] as String?,
      providersNationalIdNumber: json['providersNationalIDNumber'] as String?,
      providerRate: json['providerRate'] as dynamic,
      requesterUserName: json['requesterUser_Name'] as String?,
      levelTopic: json['levelTopic'] as String?,
      skills: json['skills'] as String?,
      country: json['country'] as String?,
      governorate: json['governorate'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'preferredProvider': preferredProvider?.toJson(),
        'providerName': providerName,
        'providersNationalIDNumber': providersNationalIdNumber,
        'providerRate': providerRate,
        'requesterUser_Name': requesterUserName,
        'levelTopic': levelTopic,
        'skills': skills,
        'country': country,
        'governorate': governorate,
      };
}
