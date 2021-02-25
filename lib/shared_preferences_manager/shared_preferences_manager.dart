import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final String degreeNameKey = "degree_name";

  static Future<String> getDegreeName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(degreeNameKey);
  }

  static Future<bool> isPresentDegreeName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(degreeNameKey);
  }

  static void saveDegreeName(String degreeName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(degreeNameKey, degreeName);
  }

  static void resetSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
