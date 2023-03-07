class LevelTopic {
  int? id;
  String? levelName;
  String? topicName;

  LevelTopic({this.id, this.levelName, this.topicName});

  factory LevelTopic.fromJson(Map<String, dynamic> json) => LevelTopic(
        id: json['id'] as int?,
        levelName: json['levelName'] as String?,
        topicName: json['topicName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'levelName': levelName,
        'topicName': topicName,
      };
}
