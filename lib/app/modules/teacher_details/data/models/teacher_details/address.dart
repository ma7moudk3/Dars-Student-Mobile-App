class Address {
  dynamic nameL;
  dynamic nameF;
  dynamic name;
  bool? isDefault;
  dynamic address1;
  dynamic lat;
  dynamic long;
  int? userId;
  dynamic countryId;
  dynamic governorateId;
  dynamic localityId;
  dynamic id;

  Address({
    this.nameL,
    this.nameF,
    this.name,
    this.isDefault,
    this.address1,
    this.lat,
    this.long,
    this.userId,
    this.countryId,
    this.governorateId,
    this.localityId,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        nameL: json['nameL'] as dynamic,
        nameF: json['nameF'] as dynamic,
        name: json['name'] as dynamic,
        isDefault: json['isDefault'] as bool?,
        address1: json['address1'] as dynamic,
        lat: json['lat'] as dynamic,
        long: json['long'] as dynamic,
        userId: json['userId'] as int?,
        countryId: json['countryId'] as dynamic,
        governorateId: json['governorateId'] as dynamic,
        localityId: json['localityId'] as dynamic,
        id: json['id'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'nameL': nameL,
        'nameF': nameF,
        'name': name,
        'isDefault': isDefault,
        'address1': address1,
        'lat': lat,
        'long': long,
        'userId': userId,
        'countryId': countryId,
        'governorateId': governorateId,
        'localityId': localityId,
        'id': id,
      };
}
