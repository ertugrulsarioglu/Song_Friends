import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  Future<bool> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(CacheManagerKey.TOKEN.toString(), token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CacheManagerKey.TOKEN.toString());
  }

  Future<bool> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(CacheManagerKey.TOKEN.toString());
  }
}

// ignore: constant_identifier_names
enum CacheManagerKey { TOKEN }
