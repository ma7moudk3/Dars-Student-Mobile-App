import 'address.dart';

class AddressResult {
  Address? address;
  String? userName;
  String? countryName;
  String? governorateName;
  String? localityName;

  AddressResult({
    this.address,
    this.userName,
    this.countryName,
    this.governorateName,
    this.localityName,
  });

  factory AddressResult.fromJson(Map<String, dynamic> json) => AddressResult(
        address: json['address'] == null
            ? null
            : Address.fromJson(json['address'] as Map<String, dynamic>),
        userName: json['userName'] as String?,
        countryName: json['countryName'] as String?,
        governorateName: json['governorateName'] as String?,
        localityName: json['localityName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'address': address?.toJson(),
        'userName': userName,
        'countryName': countryName,
        'governorateName': governorateName,
        'localityName': localityName,
      };
}
