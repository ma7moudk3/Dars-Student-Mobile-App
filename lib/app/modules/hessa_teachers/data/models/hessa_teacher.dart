class HessaTeacher {
  int? id;
  int? userId;
  String? name;
  String? emailAddress;
  String? phoneNumber;
  String? levelTopic;
  String? country;
  String? governorate;
  double? rate;
  String? skills;
  dynamic address;

  HessaTeacher({
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
    this.address,
  });

  factory HessaTeacher.fromJson(Map<String, dynamic> json) => HessaTeacher(
        id: json['id'] as int?,
        userId: json['userId'] as int?,
        name: json['name'] as String?,
        emailAddress: json['emailAddress'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        levelTopic: json['levelTopic'] as String?,
        country: json['country'] as String?,
        governorate: json['governorate'] as String?,
        rate: (json['rate'] as num?)?.toDouble(),
        skills: json['skills'] as String?,
        address: json['address'] as dynamic,
      );

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
        'address': address,
      };
}
