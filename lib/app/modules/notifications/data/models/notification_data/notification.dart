import 'data.dart';

class Notification {
  int? tenantId;
  String? notificationName;
  Data? data;
  dynamic entityType;
  dynamic entityTypeName;
  dynamic entityId;
  int? severity;
  DateTime? creationTime;
  String? id;

  Notification({
    this.tenantId,
    this.notificationName,
    this.data,
    this.entityType,
    this.entityTypeName,
    this.entityId,
    this.severity,
    this.creationTime,
    this.id,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        tenantId: json['tenantId'] as int?,
        notificationName: json['notificationName'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        entityType: json['entityType'] as dynamic,
        entityTypeName: json['entityTypeName'] as dynamic,
        entityId: json['entityId'] as dynamic,
        severity: json['severity'] as int?,
        creationTime: json['creationTime'] == null
            ? null
            : DateTime.parse(json['creationTime'] as String),
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'tenantId': tenantId,
        'notificationName': notificationName,
        'data': data?.toJson(),
        'entityType': entityType,
        'entityTypeName': entityTypeName,
        'entityId': entityId,
        'severity': severity,
        'creationTime': creationTime?.toIso8601String(),
        'id': id,
      };
}
