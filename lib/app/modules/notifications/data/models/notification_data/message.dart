class Message {
  String? sourceName;
  String? name;

  Message({this.sourceName, this.name});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sourceName: json['sourceName'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'sourceName': sourceName,
        'name': name,
      };
}
