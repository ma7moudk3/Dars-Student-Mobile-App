import 'dart:io';

abstract class EditProfileRepo {
  Future<int> updateProfile({
    String? firstName,
    String? surname, // last name
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
    int? gender,
    int? paymentMethodId,
    required int id,
  });

  Future<String?> updateProfilePicture({
    required File image,
    bool isForStudent = false,
    String? fileName,
  });

  Future updateProfilePicture2({
    required String fileToken,
  });
}
