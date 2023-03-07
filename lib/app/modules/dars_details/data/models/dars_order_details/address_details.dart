class AddressDetails {
  String? nameL;
  String? nameF;
  String? name;
  bool? isDefault;
  String? address1;
  dynamic lat;
  dynamic long;
  int? userId;
  int? countryId;
  int? governorateId;
  int? localityId;
  int? id;

  AddressDetails({
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

  factory AddressDetails.fromJson(Map<String, dynamic> json) {
    return AddressDetails(
      nameL: json['nameL'] as String?,
      nameF: json['nameF'] as String?,
      name: json['name'] as String?,
      isDefault: json['isDefault'] as bool?,
      address1: json['address1'] as String?,
      lat: json['lat'] as dynamic,
      long: json['long'] as dynamic,
      userId: json['userId'] as int?,
      countryId: json['countryId'] as int?,
      governorateId: json['governorateId'] as int?,
      localityId: json['localityId'] as int?,
      id: json['id'] as int?,
    );
  }

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
