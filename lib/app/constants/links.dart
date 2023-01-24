class Links {
  static const String baseLink = 'https://rajrestaurantksa.com';
  static const String login = '/api/user/login';
  static const String register = '/api/user/register';
  static const String confirmOtp = '/api/user/confirmRegister';
  static const String resetPasswordStep1 = '/api/password/phoneNumber';
  static const String resetPasswordStep2 = '/api/password/code/check';
  static const String resetPasswordStep3 = '/api/password/reset';
  static const String getCategories = '/api/allCategories';
  static const String getBestSellProduct = '/api/products/bestSeller';
  static const String getMainProducts = '/api/products/main';
  static const String getOtherProducts = '/api/products/otherProducts';
  static const String searchOnProduct = '/api/products/search';
  static const String getCategoryProducts = '/api/category/show';
  static const String getAllAddresses = '/api/user/showAddress';
  static const String addAddress = '/api/user/addAddress';
  static const String updateAddress = '/api/user/updateAddress';
  static const String createOrder = '/api/user/order/addOrder';
  static const String deleteAddress = '/api/user/deleteAddress';
  static const String setDefaultAddress = '/api/user/setDefaultAddress';
  static const String getMyOrders = '/api/user/order/myOrder';
  static const String getContactUsData = '/api/contact/show';
  static const String addComplaintOrSuggestion =
      '/api/ComplaintSuggestion/store';
  static const String changePassword = '/api/user/changePassword';
  static const String deleteAccount = '/api/user/deleteAccount';
  static const String updateProfile = '/api/user/update';
  static const String setFCMToken = '/api/user/FCM_Token';
  static const String getUser = '/api/getUser';
}
