class ProviderTeachingTopic {
  String? levelName;
  String? topicName;

  ProviderTeachingTopic({this.levelName, this.topicName});

  factory ProviderTeachingTopic.fromJson(Map<String, dynamic> json) {
    return ProviderTeachingTopic(
      levelName: json['levelName'] as String?,
      topicName: json['topicName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'levelName': levelName,
        'topicName': topicName,
      };
}
