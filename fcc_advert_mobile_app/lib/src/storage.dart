import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _tokenKey = "auth_token";
  static const String _userKey = "user_profile";

  static final LocalStorageService _instance = LocalStorageService._internal();

  SharedPreferences? _prefs;

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  /// Initializes SharedPreferences (should be called during app startup)
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    await _prefs?.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    return _prefs?.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await _prefs?.remove(_tokenKey);
  }

  Future<void> setProfile(Map<String, dynamic> data) async {
    final jsonString = jsonEncode(data);
    await _prefs?.setString(_userKey, jsonString);
  }


  Future<Map<String, dynamic>?> getProfile() async {
    final jsonString = _prefs?.getString(_userKey);
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  Future<void> clearProfile() async {
    await _prefs?.remove(_userKey);
  }
}

// Singleton instance
final localStorageService = LocalStorageService();
