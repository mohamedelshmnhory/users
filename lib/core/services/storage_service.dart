import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  Future<String?> getString(String key);
  Future<void> saveString(String key, String value);
  Future<bool?> getBool(String key);
  Future<void> saveBool(String key, bool value);
  Future<Map<String, dynamic>?> getMap(String key);
  Future<void> saveMap(String key, Map<String, dynamic> value);
  Future<void> deleteMap(String key);
}

class WebStorageService implements StorageService {
  late SharedPreferences _sharedPreferences;

  WebStorageService() {
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<String?> getString(String key) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _sharedPreferences.getBool(key);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  @override
  Future<Map<String, dynamic>?> getMap(String key) async {
    final jsonString = _sharedPreferences.getString(key);
    if (jsonString != null) {
      try {
        return Map<String, dynamic>.from(json.decode(jsonString));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    final jsonString = json.encode(value);
    await _sharedPreferences.setString(key, jsonString);
  }

  @override
  Future<void> deleteMap(String key) async {
    await _sharedPreferences.remove(key);
  }
}

class MobileStorageService implements StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> getString(String key) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<bool?> getBool(String key) async {
    String? stringValue = await _secureStorage.read(key: key);
    return stringValue != null ? stringValue.toLowerCase() == 'true' : null;
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<Map<String, dynamic>?> getMap(String key) async {
    String? jsonString = await _secureStorage.read(key: key);
    if (jsonString != null) {
      try {
        return Map<String, dynamic>.from(json.decode(jsonString));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    final jsonString = json.encode(value);
    await _secureStorage.write(key: key, value: jsonString);
  }

  @override
  Future<void> deleteMap(String key) async {
    await _secureStorage.delete(key: key);
  }
}

class StorageServiceFactory {
  static StorageService? _instance;

  static StorageService create() {
    _instance ??= kIsWeb ? MobileStorageService() : MobileStorageService();
    return _instance!;
  }
}
