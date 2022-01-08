import 'package:graduation_grade/shared_preferences_manager/shared_preferences_manager.dart';
import 'package:test/test.dart';

void main() {
  final String degreeName = "bioinformatics";
  test('Shared Preferences Manager Test', () async {
    expect(SharedPreferencesManager.degreeNameKey, "degree_name");

    // Clear SharedPreferences just for security that is empty.
    await SharedPreferencesManager.resetSharedPreferences();
    expect(await SharedPreferencesManager.isPresentDegreeName(), false);

    // Save degree name and check if present.
    await SharedPreferencesManager.saveDegreeName(degreeName);
    expect(await SharedPreferencesManager.isPresentDegreeName(), true);
    expect(await SharedPreferencesManager.getDegreeName(), degreeName);

    // Clear shared preferences and check if is empty.
    await SharedPreferencesManager.resetSharedPreferences();
    expect(await SharedPreferencesManager.isPresentDegreeName(), false);
  });
}
