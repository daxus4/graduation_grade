import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Class that manage the language switching for this application.
class AppLocalizations {
  /// Current system [Locale], used to retrieve current system language.
  final Locale locale;

  /// Map that contain the strings in current system language.
  Map<String, String> _localizedStrings;

  /// [LocalizationsDelegate] for this class.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationDelegate();

  /// Constructor that require current system [Locale].
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// Load the localized strings that have to be used in the language indicated
  /// in [locale].
  Future<bool> load() async {
    // Load file with translation
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Create map with strings that are the translations
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  /// Return the [String] that contain the desired translation for the passed
  /// argument.
  String translate(String key) => _localizedStrings[key];
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'it'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
