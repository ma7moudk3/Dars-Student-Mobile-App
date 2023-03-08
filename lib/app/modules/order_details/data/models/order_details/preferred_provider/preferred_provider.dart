import 'address_details.dart';

class PreferredProvider {
	int? id;
	int? userId;
	String? name;
	String? emailAddress;
	String? phoneNumber;
	String? levelTopic;
	dynamic country;
	dynamic governorate;
	int? rate;
	String? skills;
	AddressDetails? addressDetails;

	PreferredProvider({
		this.id, 
		this.userId, 
		this.name, 
		this.emailAddress, 
		this.phoneNumber, 
		this.levelTopic, 
		this.country, 
		this.governorate, 
		this.rate, 
		this.skills, 
		this.addressDetails, 
	});

	factory PreferredProvider.fromJson(Map<String, dynamic> json) {
		return PreferredProvider(
			id: json['id'] as int?,
			userId: json['userId'] as int?,
			name: json['name'] as String?,
			emailAddress: json['emailAddress'] as String?,
			phoneNumber: json['phoneNumber'] as String?,
			levelTopic: json['levelTopic'] as String?,
			country: json['country'] as dynamic,
			governorate: json['governorate'] as dynamic,
			rate: json['rate'] as int?,
			skills: json['skills'] as String?,
			addressDetails: json['addressDetails'] == null
						? null
						: AddressDetails.fromJson(json['addressDetails'] as Map<String, dynamic>),
		);
	}



	Map<String, dynamic> toJson() => {
				'id': id,
				'userId': userId,
				'name': name,
				'emailAddress': emailAddress,
				'phoneNumber': phoneNumber,
				'levelTopic': levelTopic,
				'country': country,
				'governorate': governorate,
				'rate': rate,
				'skills': skills,
				'addressDetails': addressDetails?.toJson(),
			};
}
