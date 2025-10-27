import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/constants.dart';
import 'package:manga_reader_app/view_models/settings_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, viewModel, child) {
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
            ListTile(
              title: Text("Export File"),
              onTap: () {
                viewModel.exportDatabase();

                String text = (viewModel.save)
                    ? "File saved successfully"
                    : "File not saved. You might not have a library or there was an error.";

                final snackBar = SnackBar(
                  content: Text(text),
                  backgroundColor: Colors.blue,
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(5),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              leading: Icon(Icons.download),
            ),
          ],
        );
      },
    );
  }
}
