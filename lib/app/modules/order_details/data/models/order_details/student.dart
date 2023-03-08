class Student {
  String? name;
  int? genderId;
  String? schoolName;
  String? details;
  int? requesterId;
  int? relationId;
  int? levelId;
  int? schoolTypeId;
  dynamic genderStr;
  dynamic requesterStudentPhotoFileName;
  String? requesterStudentPhoto;
  int? id;

  Student({
    this.name,
    this.genderId,
    this.schoolName,
    this.details,
    this.requesterId,
    this.relationId,
    this.levelId,
    this.schoolTypeId,
    this.genderStr,
    this.requesterStudentPhotoFileName,
    this.requesterStudentPhoto,
    this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        name: json['name'] as String?,
        genderId: json['genderId'] as int?,
        schoolName: json['schoolName'] as String?,
        details: json['details'] as String?,
        requesterId: json['requesterId'] as int?,
        relationId: json['relationId'] as int?,
        levelId: json['levelId'] as int?,
        schoolTypeId: json['schoolTypeId'] as int?,
        genderStr: json['genderStr'] as dynamic,
        requesterStudentPhotoFileName:
            json['requesterStudentPhotoFileName'] as dynamic,
        requesterStudentPhoto: json['requesterStudentPhoto'] as String?,
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
        'genderStr': genderStr,
        'requesterStudentPhotoFileName': requesterStudentPhotoFileName,
        'requesterStudentPhoto': requesterStudentPhoto,
        'id': id,
      };
}
