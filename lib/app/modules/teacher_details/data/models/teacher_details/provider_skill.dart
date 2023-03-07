class ProviderSkill {
  int? skillId;
  String? skillName;

  ProviderSkill({this.skillId, this.skillName});

  factory ProviderSkill.fromJson(Map<String, dynamic> json) => ProviderSkill(
        skillId: json['skillId'] as int?,
        skillName: json['skillName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'skillId': skillId,
        'skillName': skillName,
      };
}
