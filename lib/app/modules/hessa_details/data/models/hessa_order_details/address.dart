import 'address_details.dart';

class Address {
  AddressDetails? addressDetails;
  dynamic userName;
  String? countryName;
  String? governorateName;
  String? localityName;

  Address({
    this.addressDetails,
    this.userName,
    this.countryName,
    this.governorateName,
    this.localityName,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressDetails: json['address'] == null
            ? null
            : AddressDetails.fromJson(json['address'] as Map<String, dynamic>),
        userName: json['userName'] as dynamic,
        countryName: json['countryName'] as String?,
        governorateName: json['governorateName'] as String?,
        localityName: json['localityName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'address': addressDetails?.toJson(),
        'userName': userName,
        'countryName': countryName,
        'governorateName': governorateName,
        'localityName': localityName,
      };
}
