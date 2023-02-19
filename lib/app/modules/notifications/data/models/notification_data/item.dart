import 'notification.dart';

class Item {
  int? tenantId;
  int? userId;
  int? state;
  Notification? notification;
  String? id;

  Item({
    this.tenantId,
    this.userId,
    this.state,
    this.notification,
    this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        tenantId: json['tenantId'] as int?,
        userId: json['userId'] as int?,
        state: json['state'] as int?,
        notification: json['notification'] == null
            ? null
            : Notification.fromJson(
                json['notification'] as Map<String, dynamic>),
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'tenantId': tenantId,
        'userId': userId,
        'state': state,
        'notification': notification?.toJson(),
        'id': id,
      };
}
