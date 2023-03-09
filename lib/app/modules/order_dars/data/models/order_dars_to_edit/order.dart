class Order {
  dynamic targetGenderId;
  dynamic currentStatusId;
  String? notes;
  dynamic rate;
  dynamic rateNotes;
  dynamic predictionCost;
  dynamic actualCost;
  dynamic totalPayments;
  String? preferredStartDate;
  String? preferredEndDate;
  dynamic sessionTypeId;
  dynamic productId;
  dynamic providerId;
  dynamic requesterId;
  dynamic paymentMethodId;
  dynamic currencyId;
  dynamic preferredproviderId;
  dynamic addressId;
  List<dynamic>? orderStudentId;
  List<dynamic>? orderTopicOrSkillId;
  dynamic duration;
  dynamic id;

  Order({
    this.targetGenderId,
    this.currentStatusId,
    this.notes,
    this.rate,
    this.rateNotes,
    this.predictionCost,
    this.actualCost,
    this.totalPayments,
    this.preferredStartDate,
    this.preferredEndDate,
    this.sessionTypeId,
    this.productId,
    this.providerId,
    this.requesterId,
    this.paymentMethodId,
    this.currencyId,
    this.preferredproviderId,
    this.addressId,
    this.orderStudentId,
    this.orderTopicOrSkillId,
    this.duration,
    this.id,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        targetGenderId: json['targetGenderId'] as dynamic,
        currentStatusId: json['currentStatusId'] as dynamic,
        notes: json['notes'] as String?,
        rate: json['rate'] as dynamic,
        rateNotes: json['rateNotes'] as dynamic,
        predictionCost: json['predictionCost'] as dynamic,
        actualCost: json['actualCost'] as dynamic,
        totalPayments: json['totalPayments'] as dynamic,
        preferredStartDate: json['preferredStartDate'] as String?,
        preferredEndDate: json['preferredEndDate'] as String?,
        sessionTypeId: json['sessionTypeId'] as dynamic,
        productId: json['productId'] as dynamic,
        providerId: json['providerId'] as dynamic,
        requesterId: json['requesterId'] as dynamic,
        paymentMethodId: json['paymentMethodId'] as dynamic,
        currencyId: json['currencyId'] as dynamic,
        preferredproviderId: json['preferredproviderId'] as dynamic,
        addressId: json['addressId'] as dynamic,
        orderStudentId: json['orderStudentId'] as List<dynamic>?,
        orderTopicOrSkillId: json['orderTopicOrSkillId'] as List<dynamic>?,
        duration: json['duration'] as dynamic,
        id: json['id'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'targetGenderId': targetGenderId,
        'currentStatusId': currentStatusId,
        'notes': notes,
        'rate': rate,
        'rateNotes': rateNotes,
        'predictionCost': predictionCost,
        'actualCost': actualCost,
        'totalPayments': totalPayments,
        'preferredStartDate': preferredStartDate,
        'preferredEndDate': preferredEndDate,
        'sessionTypeId': sessionTypeId,
        'productId': productId,
        'providerId': providerId,
        'requesterId': requesterId,
        'paymentMethodId': paymentMethodId,
        'currencyId': currencyId,
        'preferredproviderId': preferredproviderId,
        'addressId': addressId,
        'orderStudentId': orderStudentId,
        'orderTopicOrSkillId': orderTopicOrSkillId,
        'duration': duration,
        'id': id,
      };
}
