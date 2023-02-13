import 'requester_student.dart';

class Student {
  RequesterStudent? requesterStudent;
  String? requesterUserName;
  String? requesterStudentRelationName;
  String? levelName;
  String? schoolTypeName;

  Student({
    this.requesterStudent,
    this.requesterUserName,
    this.requesterStudentRelationName,
    this.levelName,
    this.schoolTypeName,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        requesterStudent: json['requesterStudent'] == null
            ? null
            : RequesterStudent.fromJson(
                json['requesterStudent'] as Map<String, dynamic>),
        requesterUserName: json['requesterUser_Name'] as String?,
        requesterStudentRelationName:
            json['requesterStudentRelationName'] as String?,
        levelName: json['levelName'] as String?,
        schoolTypeName: json['schoolTypeName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'requesterStudent': requesterStudent?.toJson(),
        'requesterUser_Name': requesterUserName,
        'requesterStudentRelationName': requesterStudentRelationName,
        'levelName': levelName,
        'schoolTypeName': schoolTypeName,
      };
}
