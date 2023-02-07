import 'requester.dart';

class Result {
  Requester? requester;
  String? name;
  String? surname;
  String? userName;
  String? emailAddress;
  String? paymentMethodName;
  String? phoneNumber;
  List<dynamic>? addresses;

  Result({
    this.requester,
    this.name,
    this.surname,
    this.userName,
    this.emailAddress,
    this.paymentMethodName,
    this.phoneNumber,
    this.addresses,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        requester: json['requester'] == null
            ? null
            : Requester.fromJson(json['requester'] as Map<String, dynamic>),
        name: json['name'] as String?,
        surname: json['surname'] as String?,
        userName: json['userName'] as String?,
        emailAddress: json['emailAddress'] as String?,
        paymentMethodName: json['paymentMethodName'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        addresses: json['addresses'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'requester': requester?.toJson(),
        'name': name,
        'surname': surname,
        'userName': userName,
        'emailAddress': emailAddress,
        'paymentMethodName': paymentMethodName,
        'phoneNumber': phoneNumber,
        'addresses': addresses,
      };
}
