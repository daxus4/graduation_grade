import 'package:graduation_grade/exception/not_present_degree_name_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class contain the methods to save and load data to [SharedPreferences].
class SharedPreferencesManager {
  /// Key for degree name.
  static final String degreeNameKey = "degree_name";

  /// Return a [String] which contains the degree name.
  ///
  /// Throws [NotPresentDegreeNameException] if there is not a degree name
  /// saved.
  static Future<String> getDegreeName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey(degreeNameKey))
      throw NotPresentDegreeNameException();
    return sharedPreferences.get(degreeNameKey);
  }

  /// Return if there is a degree name saved.
  static Future<bool> isPresentDegreeName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(degreeNameKey);
  }

  /// Save the degree name in a [SharedPreferences] instance.
  static Future<void> saveDegreeName(String degreeName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(degreeNameKey, degreeName);
  }

  /// Clear the [SharedPreferences] instance.
  static Future<void> resetSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
