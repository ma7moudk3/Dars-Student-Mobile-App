class Requester {
  dynamic landingMumber;
  int? userId;
  int? paymentMethodId;
  int? gender;
  String? doB;
  String? emailAddress;
  String? phoneNumber;
  String? name;
  String? surname;
  dynamic timezone;
  int? id;

  Requester({
    this.landingMumber,
    this.userId,
    this.paymentMethodId,
    this.gender,
    this.doB,
    this.emailAddress,
    this.phoneNumber,
    this.name,
    this.surname,
    this.timezone,
    this.id,
  });

  factory Requester.fromJson(Map<String, dynamic> json) => Requester(
        landingMumber: json['landingMumber'] as dynamic,
        userId: json['userId'] as int?,
        paymentMethodId: json['paymentMethodId'] as int?,
        gender: json['gender'] as int?,
        doB: json['doB'] as String?,
        emailAddress: json['emailAddress'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        name: json['name'] as String?,
        surname: json['surname'] as String?,
        timezone: json['timezone'] as dynamic,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'landingMumber': landingMumber,
        'userId': userId,
        'paymentMethodId': paymentMethodId,
        'gender': gender,
        'doB': doB,
        'emailAddress': emailAddress,
        'phoneNumber': phoneNumber,
        'name': name,
        'surname': surname,
        'timezone': timezone,
        'id': id,
      };
}
