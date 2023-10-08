// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// class CacheHelper {
//   static late SharedPreferences sharedPreferences;
//
//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   static Future<bool> putBoolean({
//     required String key,
//     required bool value,
//   }) async {
//     return await sharedPreferences.setBool(key, value);
//   }
//
//   static dynamic getData({
//     required String key,
//   }) {
//     return sharedPreferences.get(key);
//   }
//
//   static dynamic reload() {
//     return sharedPreferences.reload();
//   }
//
//   static Future<bool> saveData(String key, dynamic value) async {
//     if (value is String) return await sharedPreferences.setString(key, value);
//     if (value is int) return await sharedPreferences.setInt(key, value);
//     if (value is bool) return await sharedPreferences.setBool(key, value);
//
//     return await sharedPreferences.setDouble(key, value);
//   }
//
//   static Future<bool> removeData({
//     required String key,
//   }) async {
//     return await sharedPreferences.remove(key);
//   }
//
//   static Future<bool> clear() async {
//     return await sharedPreferences.clear();
//   }
//
//   static Future saveMap(String key, Map<String, dynamic> jsonMap) async {
//     return await sharedPreferences.setString(key, json.encode(jsonMap));
//   }
//
//   static Future<Map<String, dynamic>?> getMap<T>(String key) async {
//     String? value = sharedPreferences.getString(key);
//     if (value == null) return null;
//     return json.decode(value);
//   }
//
//   static Future deleteMap(String key) async {
//     return await sharedPreferences.remove(key);
//   }
// }
