import 'package:flutter/widgets.dart';

class Constants {
  static const String themeModeKey = "isDarkKey";

  //Navigation Chapter Bar
  static const Color darkThemedNavBar = Color(0xFF1C2222);
  static const Color lightThemedNavBar = Color(0xFFECEEf4);
}

ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);
ValueNotifier<String> backupStarted = ValueNotifier("");
