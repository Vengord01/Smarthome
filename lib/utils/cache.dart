import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  late SharedPreferences cache;
  Cache._privateConstructor();

  static final Cache instance = Cache._privateConstructor();

  Future<void> init() async {
    cache = await SharedPreferences.getInstance();
    return;
  }

  void saveToCache(String key, String value) async {
    log("Saved to cache");
    cache.setString(key, value);
    return;
  }

  String getFromCache(String key) {
    String value = cache.getString(key) ?? '';
    return value;
  }

  void clearCache() {
    cache.clear();
    return;
  }
}
