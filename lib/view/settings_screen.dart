import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: Text("Dark Mode"),
          value: isDarkModeNotifier.value,
          onChanged: (bool value) async {
            setState(() {
              isDarkModeNotifier.value = value;
            });
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setBool(Constants.themeModeKey, value);
          },
          secondary: Icon(Icons.dark_mode),
        ),
      ],
    );
  }
}
