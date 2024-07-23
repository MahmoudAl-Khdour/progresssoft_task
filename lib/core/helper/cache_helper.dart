import 'package:shared_preferences/shared_preferences.dart';

///  Cache Helper for caching data
class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future<bool> setData({
    required String key,
    required value,
  }) async {
    switch (value.runtimeType) {
      case const (String):
        return await sharedPreferences.setString(key, value);
      case const (bool):
        return await sharedPreferences.setBool(key, value);
      case const (int):
        return await sharedPreferences.setInt(key, value);
      case const (double):
        return await sharedPreferences.setDouble(key, value);
    }
    return await sharedPreferences.setStringList(key, value);
  }

  static dynamic getData({required String key}) => sharedPreferences.get(key);

  static dynamic getListData({required String key}) =>
      sharedPreferences.getStringList(key);

  static Future<bool> removeData({required String key}) async =>
      await sharedPreferences.remove(key);

  static Future<bool> clear() async => await sharedPreferences.clear();
}
