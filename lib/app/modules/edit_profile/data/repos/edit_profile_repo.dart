import 'dart:io';

abstract class EditProfileRepo {
  Future<int> updateProfile({
    String? firstName,
    String? surname, // last name
    String? email,
    String? phoneNumber,
    int? gender,
    int? paymentMethodId,
    required int id,
  });

  Future updateProfilePicture({
    required File image,
  });

  Future updateProfilePicture2({
    required String fileToken,
  });
}
