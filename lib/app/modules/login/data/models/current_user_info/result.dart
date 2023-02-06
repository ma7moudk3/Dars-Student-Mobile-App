class Result {
  dynamic name;
  dynamic surname;
  dynamic userName;
  dynamic emailAddress;
  dynamic profilePictureId;
  bool? isProfileCompleted;
  bool? isExternalUser;
  bool? isEmailConfirmed;
  bool? isPhoneNumberConfirmed;
  dynamic roleType;
  int? id;

  Result({
    this.name,
    this.surname,
    this.userName,
    this.emailAddress,
    this.profilePictureId,
    this.isProfileCompleted,
    this.isExternalUser,
    this.isEmailConfirmed,
    this.isPhoneNumberConfirmed,
    this.roleType,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json['name'] as dynamic,
        surname: json['surname'] as dynamic,
        userName: json['userName'] as dynamic,
        emailAddress: json['emailAddress'] as dynamic,
        profilePictureId: json['profilePictureId'] as dynamic,
        isProfileCompleted: json['isProfileCompleted'] as bool?,
        isExternalUser: json['isExternalUser'] as bool?,
        isEmailConfirmed: json['isEmailConfirmed'] as bool?,
        isPhoneNumberConfirmed: json['isPhoneNumberConfirmed'] as bool?,
        roleType: json['roleType'] as dynamic,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'userName': userName,
        'emailAddress': emailAddress,
        'profilePictureId': profilePictureId,
        'isProfileCompleted': isProfileCompleted,
        'isExternalUser': isExternalUser,
        'isEmailConfirmed': isEmailConfirmed,
        'isPhoneNumberConfirmed': isPhoneNumberConfirmed,
        'roleType': roleType,
        'id': id,
      };
}
