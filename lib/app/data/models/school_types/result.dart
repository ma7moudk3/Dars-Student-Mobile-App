class Result {
  int? id;
  String? displayName;

  Result({this.id, this.displayName});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json['id'] as int?,
        displayName: json['displayName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
      };
}
