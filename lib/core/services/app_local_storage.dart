// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class AppLocalStorage {
//   static Future saveString(String key, String value) async {
//     const storage = FlutterSecureStorage();
//
//     await storage.write(key: key, value: value);
//   }
//
//   static Future<String?> getString(String key) async {
//     const storage = FlutterSecureStorage();
//     return await storage.read(key: key);
//   }
//
//   static Future saveMap(String key, Map<String, dynamic> jsonMap) async {
//     const storage = FlutterSecureStorage();
//     return await storage.write(key: key, value: json.encode(jsonMap));
//   }
//
//   static Future deleteMap(String key) async {
//     const storage = FlutterSecureStorage();
//     await storage.delete(key: key);
//   }
//
//   static Future<Map<String, dynamic>?> getMap<T>(String key) async {
//     const storage = FlutterSecureStorage();
//     String? value = await storage.read(key: key);
//     if (value == null) return null;
//     return json.decode(value);
//   }
//
//   static Future<bool?> getBool(String key) async {
//     const storage = FlutterSecureStorage();
//     return await storage.read(key: key) == '0' ? false : true;
//   }
//
//   static Future saveBool(String key, bool value) async {
//     const storage = FlutterSecureStorage();
//     await storage.write(key: key, value: value ? '1' : '0');
//   }
// }
