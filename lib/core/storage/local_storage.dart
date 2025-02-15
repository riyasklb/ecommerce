import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  Future<String?> getToken() {
    final prefs = SharedPreferences.getInstance();
    return prefs.then((prefs) => prefs.getString(tokenKey));
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}

final localStorageProvider = Provider<LocalStorage>((ref) {
  return LocalStorage();
});
