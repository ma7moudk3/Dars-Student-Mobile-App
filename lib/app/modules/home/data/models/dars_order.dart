class DarsOrder {
  int? targetGenderId;
  String? targetGenderStr;
  int? currentStatusId;
  String? currentStatusStr;
  DateTime? lastModifiedDate;
  String? preferredStartDate;
  String? preferredEndDate;
  int? sessionTypeId;
  dynamic providerUserId, providerName;
  String? sessionTypeStr;
  int? sessionCount;
  int? studentCount;
  String? levelTopic;
  int? categoryId;
  String? categoryName;
  int? id;

  DarsOrder({
    this.targetGenderId,
    this.targetGenderStr,
    this.currentStatusId,
    this.currentStatusStr,
    this.lastModifiedDate,
    this.preferredStartDate,
    this.preferredEndDate,
    this.sessionTypeId,
    this.sessionTypeStr,
    this.sessionCount,
    this.studentCount,
    this.levelTopic,
    this.categoryId,
    this.categoryName,
    this.providerUserId,
    this.providerName,
    this.id,
  });

  factory DarsOrder.fromJson(Map<String, dynamic> json) => DarsOrder(
        targetGenderId: json['targetGenderId'] as int?,
        targetGenderStr: json['targetGenderStr'] as String?,
        currentStatusId: json['currentStatusId'] as int?,
        currentStatusStr: json['currentStatusStr'] as String?,
        lastModifiedDate: json['lastModifiedDate'] == null
            ? null
            : DateTime.parse(json['lastModifiedDate'] as String),
        preferredStartDate: json['preferredStartDate'] as String?,
        providerUserId: json['providerUserId'] as dynamic,
        providerName: json['providerName'] as dynamic,
        preferredEndDate: json['preferredEndDate'] as String?,
        sessionTypeId: json['sessionTypeId'] as int?,
        sessionTypeStr: json['sessionTypeStr'] as String?,
        sessionCount: json['sessionCount'] as int?,
        studentCount: json['studentCount'] as int?,
        levelTopic: json['levelTopic'] as String?,
        categoryId: json['categoryId'] as int?,
        categoryName: json['categoryName'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'targetGenderId': targetGenderId,
        'targetGenderStr': targetGenderStr,
        'currentStatusId': currentStatusId,
        'currentStatusStr': currentStatusStr,
        'lastModifiedDate': lastModifiedDate?.toIso8601String(),
        'preferredStartDate': preferredStartDate,
        'preferredEndDate': preferredEndDate,
        'sessionTypeId': sessionTypeId,
        'providerUserId': providerUserId,
        'providerName': providerName,
        'sessionTypeStr': sessionTypeStr,
        'sessionCount': sessionCount,
        'studentCount': studentCount,
        'levelTopic': levelTopic,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'id': id,
      };
}
