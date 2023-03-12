import 'session.dart';

class OrderSession {
  Session? session;
  String? productName;
  String? orderNotes;
  String? topicName;
  String? levelName;
  dynamic skillName;
  int? studentCount;
  dynamic providerUserId;
  dynamic requesterUserId;
  int? requesterId;
  dynamic providerId;
  int? categoryId;
  dynamic categoryName;
  dynamic providerName;
  dynamic requesterNam;

  OrderSession({
    this.session,
    this.productName,
    this.orderNotes,
    this.topicName,
    this.levelName,
    this.skillName,
    this.studentCount,
    this.providerUserId,
    this.requesterUserId,
    this.requesterId,
    this.providerId,
    this.categoryId,
    this.categoryName,
    this.providerName,
    this.requesterNam,
  });

  factory OrderSession.fromJson(Map<String, dynamic> json) => OrderSession(
        session: json['session'] == null
            ? null
            : Session.fromJson(json['session'] as Map<String, dynamic>),
        productName: json['productName'] as String?,
        orderNotes: json['orderNotes'] as String?,
        topicName: json['topicName'] as String?,
        levelName: json['levelName'] as String?,
        skillName: json['skillName'] as dynamic,
        studentCount: json['studentCount'] as int?,
        providerUserId: json['providerUserId'] as dynamic,
        requesterUserId: json['requesterUserId'] as dynamic,
        requesterId: json['requesterId'] as int?,
        providerId: json['providerId'] as dynamic,
        categoryId: json['categoryId'] as int?,
        categoryName: json['categoryName'] as dynamic,
        providerName: json['providerName'] as dynamic,
        requesterNam: json['requesterNam'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'session': session?.toJson(),
        'productName': productName,
        'orderNotes': orderNotes,
        'topicName': topicName,
        'levelName': levelName,
        'skillName': skillName,
        'studentCount': studentCount,
        'providerUserId': providerUserId,
        'requesterUserId': requesterUserId,
        'requesterId': requesterId,
        'providerId': providerId,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'providerName': providerName,
        'requesterNam': requesterNam,
      };
}
