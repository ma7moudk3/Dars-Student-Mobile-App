import 'address.dart';

class AddressDetails {
	Address? address;
	String? userName;
	String? countryName;
	String? governorateName;
	String? localityName;

	AddressDetails({
		this.address, 
		this.userName, 
		this.countryName, 
		this.governorateName, 
		this.localityName, 
	});

	factory AddressDetails.fromJson(Map<String, dynamic> json) {
		return AddressDetails(
			address: json['address'] == null
						? null
						: Address.fromJson(json['address'] as Map<String, dynamic>),
			userName: json['userName'] as String?,
			countryName: json['countryName'] as String?,
			governorateName: json['governorateName'] as String?,
			localityName: json['localityName'] as String?,
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
