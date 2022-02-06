// Class where are stored all information of the design of the application
// that should be global
import 'package:flutter/material.dart';

/// Class that contains information about the design.
class DesignData {
  /// Setting for light theme.
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: "Arial",
  );

  static final secondaryColor = Colors.deepOrangeAccent;

  /// Setting for dark theme.
  static final darkTheme = ThemeData(
    primarySwatch: Colors.black,
  );
}
