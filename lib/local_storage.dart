import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _userIdKey = 'userId';
  static const String _userNameKey = 'userName';

  // Simpan data user
  static Future<void> saveUser(String userId, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userNameKey, userName);
  }

  // Ambil data user
  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(_userIdKey);
    final userName = prefs.getString(_userNameKey);
    return {
      'userId': userId,
      'userName': userName,
    };
  }

  // Hapus data user
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_userNameKey);
  }
}
