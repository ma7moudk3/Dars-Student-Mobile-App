import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper._() {
    init();
  }

  static final CacheHelper _instance = CacheHelper._();

  static CacheHelper get instance => _instance;

  late SharedPreferences _sharedPreferences;

  Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future setAccessToken(String token) async {
    await _sharedPreferences.setString('access_token', token);
  }

  String getAccessToken() {
    return _sharedPreferences.getString('access_token') ?? '';
  }

  Future setIsEmailAndPhoneConfirmed(bool isConfirmed) async {
    await _sharedPreferences.setBool('confirmed', isConfirmed);
  }

  bool getIsEmailAndPhoneConfirmed() {
    return _sharedPreferences.getBool('confirmed') ?? false;
  }

  Future setRefreshToken(String token) async {
    await _sharedPreferences.setString('refresh_token', token);
  }

  String getRefreshToken() {
    return _sharedPreferences.getString('refresh_token') ?? '';
  }

  Future setFcmToken(String token) async {
    await _sharedPreferences.setString('fcm_token', token);
  }

  String getFcmToken() {
    return _sharedPreferences.getString('fcm_token') ?? '';
  }

  Future setFirstTimeOpenedApp(bool firstTime) async {
    await _sharedPreferences.setBool('first_time', firstTime);
  }

  bool getFirstTimeOpenedApp() {
    return _sharedPreferences.getBool('first_time') ?? true;
  }

  Future setBaseLink(String link) async {
    await _sharedPreferences.setString('base_link', link);
  }

  String getBaseLink() {
    return _sharedPreferences.getString('base_link') ?? 'https://wm.hudoor.net';
  }

  Future setAppKey(String appKey) async {
    await _sharedPreferences.setString('app_key', appKey);
  }

  String getAppKey() {
    return _sharedPreferences.getString('app_key') ?? '';
  }

  Future setUserId(int id) async {
    await _sharedPreferences.setInt('userId', id);
  }

  int getUserId() {
    return _sharedPreferences.getInt('userId') ?? -1;
  }

  Future setEmployeeObject(String employee) async {
    await _sharedPreferences.setString('employee_object', employee);
  }

  String getEmployeeObject() {
    return _sharedPreferences.getString('employee_object') ?? "";
  }

  Future setLangCode(String langCode) async {
    await _sharedPreferences.setString('langCode', langCode);
  }

  String getLangCode() {
    return _sharedPreferences.getString('langCode') ?? "ar";
  }

  Future setUserDisplayName(String userDisplayName) async {
    await _sharedPreferences.setString('userDisplayName', userDisplayName);
  }

  String getuserDisplayName() {
    return _sharedPreferences.getString('userDisplayName') ?? '';
  }

  Future setUserMobileNo(String email) async {
    await _sharedPreferences.setString('mobile', email);
  }

  String getUserMobileNo() {
    return _sharedPreferences.getString('mobile') ?? '';
  }

  Future setUserImage(String image) async {
    await _sharedPreferences.setString('user_img', image);
  }

  String getUserImage() {
    return _sharedPreferences.getString('user_img') ?? '';
  }

  Future setAvatarLink(String avatar) async {
    await _sharedPreferences.setString('avatar', avatar);
  }

  String getAvatarLink() {
    return _sharedPreferences.getString('avatar') ??
        "https://secure.gravatar.com/avatar/?s=96&d=mm&r=g";
  }

  Future setAuthed(bool authed) async {
    await _sharedPreferences.setBool('authed', authed);
  }

  bool authenticated() {
    return _sharedPreferences.getBool('authed') ?? false;
  }

  Future setIsFirstTime(bool authed) async {
    await _sharedPreferences.setBool('isFirstTime', authed);
  }

  bool isFirstTime() {
    return _sharedPreferences.getBool('isFirstTime') ?? true;
  }

  Future setIsAcceptAuthPermission(bool auth) async {
    await _sharedPreferences.setBool('accept_auth', auth);
  }

  bool getIsAcceptAuthPermission() {
    return _sharedPreferences.getBool('accept_auth') ?? false;
  }

  Future setIs24HourFormat(bool format) async {
    await _sharedPreferences.setBool('format_24', format);
  }

  bool getIs24HourFormat() {
    return _sharedPreferences.getBool('format_24') ?? false;
  }

  Future setLoginAuthed(bool authed) async {
    await _sharedPreferences.setBool('login_authed', authed);
  }

  bool loginAuthenticated() {
    return _sharedPreferences.getBool('login_authed') ?? false;
  }
}
