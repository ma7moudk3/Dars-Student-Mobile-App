class Session {
  String? startDate;
  String? endDate;
  dynamic duration;
  dynamic realDuration;
  dynamic sessionTypeId;
  dynamic cost;
  dynamic currentStatusId;
  dynamic productId;
  dynamic orderId;
  dynamic topicId;
  dynamic levelId;
  dynamic skillId;
  dynamic currentStatusName;
  dynamic id;

  Session({
    this.startDate,
    this.endDate,
    this.duration,
    this.realDuration,
    this.sessionTypeId,
    this.cost,
    this.currentStatusId,
    this.productId,
    this.orderId,
    this.topicId,
    this.levelId,
    this.skillId,
    this.currentStatusName,
    this.id,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        startDate: json['startDate'] as String?,
        endDate: json['endDate'] as String?,
        duration: json['duration'] as dynamic,
        realDuration: json['realDuration'] as dynamic,
        sessionTypeId: json['sessionTypeId'] as dynamic,
        cost: json['cost'] as dynamic,
        currentStatusId: json['currentStatusId'] as dynamic,
        productId: json['productId'] as dynamic,
        orderId: json['orderId'] as dynamic,
        topicId: json['topicId'] as dynamic,
        levelId: json['levelId'] as dynamic,
        skillId: json['skillId'] as dynamic,
        currentStatusName: json['currentStatusName'] as dynamic,
        id: json['id'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'startDate': startDate,
        'endDate': endDate,
        'duration': duration,
        'realDuration': realDuration,
        'sessionTypeId': sessionTypeId,
        'cost': cost,
        'currentStatusId': currentStatusId,
        'productId': productId,
        'orderId': orderId,
        'topicId': topicId,
        'levelId': levelId,
        'skillId': skillId,
        'currentStatusName': currentStatusName,
        'id': id,
      };
}
