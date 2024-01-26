import 'package:shared_preferences/shared_preferences.dart';

class DataBase {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void saveString(String data, String key) async {
    SharedPreferences preferences = await _prefs;
    preferences.setString(key, data);
  }

  Future<String?> retrieveString(String key) async {
    SharedPreferences preferences = await _prefs;
    return preferences.getString(key);
  }

  Future<void> deleteToken() async {
    SharedPreferences preferences = await _prefs;
    await preferences.remove('token');
  }
}