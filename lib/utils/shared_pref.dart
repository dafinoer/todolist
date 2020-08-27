import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static final SharePref sharePref = SharePref._private();

  SharedPreferences _preferences;

  SharePref._private();

  factory SharePref.singleton() {
    return sharePref;
  }

  void build() async{
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setToken(String token) async {
    await _preferences.setString('token', token);
  }

  String getValueSharePref(String key) {
    return _preferences.getString(key);
  }

  Future<void> setEmail(String email) async {
    await _preferences.setString('email', email);
  }

  String getValueEmail() {
    return _preferences.getString('email');
    
  }

}
