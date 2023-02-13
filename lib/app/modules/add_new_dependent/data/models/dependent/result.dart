class Result {
  String? name;
  int? genderId;
  String? schoolName;
  String? details;
  int? requesterId;
  int? relationId;
  int? levelId;
  int? schoolTypeId;
  int? id;

  Result({
    this.name,
    this.genderId,
    this.schoolName,
    this.details,
    this.requesterId,
    this.relationId,
    this.levelId,
    this.schoolTypeId,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json['name'] as String?,
        genderId: json['genderId'] as int?,
        schoolName: json['schoolName'] as String?,
        details: json['details'] as String?,
        requesterId: json['requesterId'] as int?,
        relationId: json['relationId'] as int?,
        levelId: json['levelId'] as int?,
        schoolTypeId: json['schoolTypeId'] as int?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'genderId': genderId,
        'schoolName': schoolName,
        'details': details,
        'requesterId': requesterId,
        'relationId': relationId,
        'levelId': levelId,
        'schoolTypeId': schoolTypeId,
        'id': id,
      };
}
