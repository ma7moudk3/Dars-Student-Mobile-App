class Order {
  dynamic targetGenderId;
  dynamic currentStatusId;
  String? notes;
  dynamic rate;
  dynamic rateNotes;
  dynamic predictionCost;
  dynamic actualCost;
  dynamic totalPayments;
  DateTime? preferredStartDate;
  DateTime? preferredEndDate;
  dynamic sessionTypeId;
  dynamic productId;
  dynamic providerId;
  dynamic requesterId;
  dynamic paymentMethodId;
  dynamic currencyId;
  dynamic preferredproviderId;
  dynamic preferredproviderIsReject;
  dynamic preferredproviderRejectDate;
  dynamic preferredproviderRejectNotes;
  dynamic preferredprovider;
  dynamic addressId;
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
    this.preferredproviderIsReject,
    this.preferredproviderRejectDate,
    this.preferredproviderRejectNotes,
    this.preferredprovider,
    this.addressId,
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
        preferredStartDate: json['preferredStartDate'] == null
            ? null
            : DateTime.parse(json['preferredStartDate'] as String),
        preferredEndDate: json['preferredEndDate'] == null
            ? null
            : DateTime.parse(json['preferredEndDate'] as String),
        sessionTypeId: json['sessionTypeId'] as dynamic,
        productId: json['productId'] as dynamic,
        providerId: json['providerId'] as dynamic,
        requesterId: json['requesterId'] as dynamic,
        paymentMethodId: json['paymentMethodId'] as dynamic,
        currencyId: json['currencyId'] as dynamic,
        preferredproviderId: json['preferredproviderId'] as dynamic,
        preferredproviderIsReject: json['preferredproviderIsReject'] as dynamic,
        preferredproviderRejectDate:
            json['preferredproviderRejectDate'] as dynamic,
        preferredproviderRejectNotes:
            json['preferredproviderRejectNotes'] as dynamic,
        preferredprovider: json['preferredprovider'] as dynamic,
        addressId: json['addressId'] as dynamic,
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
        'preferredStartDate': preferredStartDate?.toIso8601String(),
        'preferredEndDate': preferredEndDate?.toIso8601String(),
        'sessionTypeId': sessionTypeId,
        'productId': productId,
        'providerId': providerId,
        'requesterId': requesterId,
        'paymentMethodId': paymentMethodId,
        'currencyId': currencyId,
        'preferredproviderId': preferredproviderId,
        'preferredproviderIsReject': preferredproviderIsReject,
        'preferredproviderRejectDate': preferredproviderRejectDate,
        'preferredproviderRejectNotes': preferredproviderRejectNotes,
        'preferredprovider': preferredprovider,
        'addressId': addressId,
        'duration': duration,
        'id': id,
      };
}
