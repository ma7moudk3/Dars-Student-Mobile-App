import 'address.dart';

class ProviderAddress {
  Address? address;
  String? userName;
  dynamic countryName;
  dynamic governorateName;
  dynamic localityName;

  ProviderAddress({
    this.address,
    this.userName,
    this.countryName,
    this.governorateName,
    this.localityName,
  });

  factory ProviderAddress.fromJson(Map<String, dynamic> json) {
    return ProviderAddress(
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      userName: json['userName'] as String?,
      countryName: json['countryName'] as dynamic,
      governorateName: json['governorateName'] as dynamic,
      localityName: json['localityName'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address?.toJson(),
        'userName': userName,
        'countryName': countryName,
        'governorateName': governorateName,
        'localityName': localityName,
      };
}
