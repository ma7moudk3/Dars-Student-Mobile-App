class Links {
  static const String baseLink = 'https://api.hessaedu.com/';
  static const String register = 'api/services/app/Account/Register';
  static const String login = 'api/TokenAuth/Authenticate';
  static const String logout = 'api/TokenAuth/LogOut';
  static const String getCurrentUserInfo =
      'api/services/app/Session/GetCurrentUserInfo';
  static const String externalAuthenticate =
      'api/TokenAuth/ExternalAuthenticate';
  static const String getCurrentUserProfileInfo =
      'api/services/app/Requesters/GetRequesterForEdit';
  static const String generateOTPCode =
      'api/services/app/VerificationCodes/GenerateCode';
  static const String verifyOTPCodeEmail =
      'api/services/app/Profile/ActivateEmail';
  static const String verifyOTPCodeMobile =
      'api/services/app/Profile/ActivateMobile';
  static const String sendResetPasswordCode =
      "api/services/app/Account/SendPasswordResetCode";
  static const String profileImageById = "Profile/GetUserProfilePictureByUser";
  static const String userProfileImage =
      "api/services/app/Profile/GetProfilePicture";
  static const String updateProfileData =
      "api/services/app/Requesters/CreateOrEdit";
  static const String updateProfilePicture = "Profile/UploadProfilePicture";
  static const String updateProfilePicture2 =
      "api/services/app/Profile/UpdateProfilePicture";
  static const String sendFCMToken = "api/services/app/Account/UpdateFcmToken";
  static const String getMyOrders =
      "api/services/app/Orders/GetMyOrderForRequester";
  static const String getAllHessaTeachers =
      "api/services/app/Providers/GetSearchForProviders";
  static const String getHessaTeacher =
      "api/services/app/Providers/GetProviderDetailsForRequester";
  static const String changePassword =
      "api/services/app/Profile/ChangePassword";
  static const String addTeacherToFavorite =
      "api/services/app/PreferredProviders/CreateOrEdit";
  static const String removeTeacherFromFavorite =
      "api/services/app/PreferredProviders/DeletePreferredProvider";
  static const String preferredTeachers = // favoriteTeachers
      "api/services/app/PreferredProviders/GetAllForRequester";
  static const String staticPage = // 3 -> policy, 4 -> terms
      "api/services/app/ContentManagements/GetContentManagementForView";
  static const String contactUs = "api/services/app/Tickets/CreateOrEdit";
  static const String urgencyTypesForDropDown =
      "api/services/app/Tickets/GetAllUrgencyForTableDropdown";
  static const String countriesForDropDown =
      "api/services/app/Governorates/GetAllCountryForTableDropdown";
  static const String governoratesForDropDown =
      "api/services/app/Providers/GetGovernorateByCountryId";
  static const String localitiesForDropDown =
      "api/services/app/Providers/GetAllLocalityByGovernorateId";
  static const String skillsForDropDown =
      "api/services/app/OrderSkills/GetAllSkillForLookupTable";
  static const String classesForDropDown =
      "api/services/app/Topics/GetAllLevelForLookupTable";
  static const String studentRelationsForDropDown =
      "api/services/app/RequesterStudents/GetAllRequesterStudentRelationForTableDropdown";
  static const String schoolTypesForDropDown =
      "api/services/app/RequesterStudents/GetAllSchoolTypeForTableDropdown";
  static const String
      addNewStudent = // dependent >> student relation >> son, daughter, ...
      "api/services/app/RequesterStudents/CreateOrEdit";
  static const String getAllMyStudents =
      "api/services/app/RequesterStudents/GetStudentsByRequester";
  static const String topicsForDropDown =
      "api/services/app/Sessions/GetAllTopicForTableDropdown";
  static const String addOrEditAddress =
      "api/services/app/Requesters/RequesterAddressCreateOrEdit";
  static const String allMyAddresses =
      "api/services/app/Requesters/GetRequesterAddressForEdit";
  static const String deleteAddress = "api/services/app/Addresses/Delete";
}
