import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_style/core/values/constants.dart';

class StorageServices {
  static late final SharedPreferences _pref;

  static final StorageServices _instance = StorageServices._internal();

  factory StorageServices() {
    return _instance;
  }

  StorageServices._internal();

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
    GetIt.I.registerLazySingleton<SharedPreferences>(() => _pref);
  }

  static Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  static Future<bool> setObject(String key, dynamic value) async {
    return await _pref.setString(key, json.encode(value));
  }

  static Future<dynamic> getObject(String key) async {
    if (_pref.getString(key) == null) return null;
    return json.decode(_pref.getString(key)!);
  }

  static String? getString(String key) {
    return _pref.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  static bool getDeviceOnboardingOpen() {
    return _pref.getBool(AppConstants.STORAGE_SHOW_ONBOARDING) ?? true;
  }

  static bool getIsLoggedIn() {
    return _pref.getString(AppConstants.STORAGE_ACCESS_TOKEN) == null
        ? false
        : true;
  }

  static Future<bool> remove(String key) {
    return _pref.remove(key);
  }
}
