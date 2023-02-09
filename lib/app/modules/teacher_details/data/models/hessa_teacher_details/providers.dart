class Providers {
  dynamic gender;
  String? doB;
  dynamic facebookId;
  dynamic landLineNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;
  String? nationalIdNumber;
  String? nationalIdPhoto;
  dynamic nationalIdPhotoFileName;
  dynamic currentStatusId;
  String? aboutMe;
  bool? isActive;
  dynamic targetGenderId;
  bool? isAcceptContract;
  dynamic rate;
  dynamic physicalInterviewScore;
  dynamic examScore;
  bool? isExampassed;
  bool? canRetakeExam;
  dynamic examLink;
  dynamic overallEvaluation;
  dynamic workExperience;
  double? highSchoolAverage;
  String? highSchoolCertificate;
  dynamic highSchoolCertificateFileName;
  String? universityCard;
  dynamic universityCardFileName;
  dynamic preferredSessionTypeId;
  dynamic userId;
  dynamic preferredPaymentMethodId;
  dynamic fcmToken;
  DateTime? lastModificationTime;
  dynamic id;

  Providers({
    this.gender,
    this.doB,
    this.facebookId,
    this.landLineNumber,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.nationalIdNumber,
    this.nationalIdPhoto,
    this.nationalIdPhotoFileName,
    this.currentStatusId,
    this.aboutMe,
    this.isActive,
    this.targetGenderId,
    this.isAcceptContract,
    this.rate,
    this.physicalInterviewScore,
    this.examScore,
    this.isExampassed,
    this.canRetakeExam,
    this.examLink,
    this.overallEvaluation,
    this.workExperience,
    this.highSchoolAverage,
    this.highSchoolCertificate,
    this.highSchoolCertificateFileName,
    this.universityCard,
    this.universityCardFileName,
    this.preferredSessionTypeId,
    this.userId,
    this.preferredPaymentMethodId,
    this.fcmToken,
    this.lastModificationTime,
    this.id,
  });

  factory Providers.fromJson(Map<String, dynamic> json) => Providers(
        gender: json['gender'] as dynamic,
        doB: json['doB'] as String?,
        facebookId: json['facebookID'] as dynamic,
        landLineNumber: json['landLineNumber'] as dynamic,
        emergencyContactName: json['emergencyContactName'] as String?,
        emergencyContactNumber: json['emergencyContactNumber'] as String?,
        nationalIdNumber: json['nationalIDNumber'] as String?,
        nationalIdPhoto: json['nationalIDPhoto'] as String?,
        nationalIdPhotoFileName: json['nationalIDPhotoFileName'] as dynamic,
        currentStatusId: json['currentStatusId'] as dynamic,
        aboutMe: json['aboutMe'] as String?,
        isActive: json['isActive'] as bool?,
        targetGenderId: json['targetGenderId'] as dynamic,
        isAcceptContract: json['isAcceptContract'] as bool?,
        rate: json['rate'] as dynamic,
        physicalInterviewScore: json['physicalInterviewScore'] as dynamic,
        examScore: json['examScore'] as dynamic,
        isExampassed: json['isExampassed'] as bool?,
        canRetakeExam: json['canRetakeExam'] as bool?,
        examLink: json['examLink'] as dynamic,
        overallEvaluation: json['overallEvaluation'] as dynamic,
        workExperience: json['workExperience'] as dynamic,
        highSchoolAverage: (json['highSchoolAverage'] as num?)?.toDouble(),
        highSchoolCertificate: json['highSchoolCertificate'] as String?,
        highSchoolCertificateFileName:
            json['highSchoolCertificateFileName'] as dynamic,
        universityCard: json['universityCard'] as String?,
        universityCardFileName: json['universityCardFileName'] as dynamic,
        preferredSessionTypeId: json['preferredSessionTypeId'] as dynamic,
        userId: json['userId'] as dynamic,
        preferredPaymentMethodId: json['preferredPaymentMethodId'] as dynamic,
        fcmToken: json['fcmToken'] as dynamic,
        lastModificationTime: json['lastModificationTime'] == null
            ? null
            : DateTime.parse(json['lastModificationTime'] as String),
        id: json['id'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'gender': gender,
        'doB': doB,
        'facebookID': facebookId,
        'landLineNumber': landLineNumber,
        'emergencyContactName': emergencyContactName,
        'emergencyContactNumber': emergencyContactNumber,
        'nationalIDNumber': nationalIdNumber,
        'nationalIDPhoto': nationalIdPhoto,
        'nationalIDPhotoFileName': nationalIdPhotoFileName,
        'currentStatusId': currentStatusId,
        'aboutMe': aboutMe,
        'isActive': isActive,
        'targetGenderId': targetGenderId,
        'isAcceptContract': isAcceptContract,
        'rate': rate,
        'physicalInterviewScore': physicalInterviewScore,
        'examScore': examScore,
        'isExampassed': isExampassed,
        'canRetakeExam': canRetakeExam,
        'examLink': examLink,
        'overallEvaluation': overallEvaluation,
        'workExperience': workExperience,
        'highSchoolAverage': highSchoolAverage,
        'highSchoolCertificate': highSchoolCertificate,
        'highSchoolCertificateFileName': highSchoolCertificateFileName,
        'universityCard': universityCard,
        'universityCardFileName': universityCardFileName,
        'preferredSessionTypeId': preferredSessionTypeId,
        'userId': userId,
        'preferredPaymentMethodId': preferredPaymentMethodId,
        'fcmToken': fcmToken,
        'lastModificationTime': lastModificationTime?.toIso8601String(),
        'id': id,
      };
}
