import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final String degreeNameKey = "degree_name";

  static void saveDegreeName(String key, String degreeName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, degreeName);
  }

  static void resetSharedPreferences(List<String> keys) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    for(String key in keys)
      sharedPreferences.remove(key);
  }
}
