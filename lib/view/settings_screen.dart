import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  String _backupFrequency = 'Every month';

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.message.isNotEmpty) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(viewModel.message),
                backgroundColor: Colors.blue,
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(5),
              ),
            );

            viewModel.clearMessage();
          });
        }
        return Column(
          children: [
            ListTile(
              title: Text(
                "Themes",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
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
            Divider(),
            ListTile(
              title: Text(
                "Backup & Restore",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text("Download Library"),
              onTap: () {
                viewModel.exportDatabase();
              },
              leading: Icon(Icons.download),
            ),
            ListTile(
              title: Text("Restore Library"),
              onTap: () {
                viewModel.importDatabase();
              },
              leading: Icon(Icons.upload_file),
            ),
            ListTile(
              title: Text("Backup Frequency"),
              trailing: DropdownButton<String>(
                value: _backupFrequency,
                items: const [
                  DropdownMenuItem(
                    value: "Every month",
                    child: Text("Every month"),
                  ),
                  DropdownMenuItem(
                    value: "Every week",
                    child: Text("Every week"),
                  ),
                  DropdownMenuItem(
                    value: "Every day",
                    child: Text("Every day"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _backupFrequency = value!;
                  });
                },
              ),
              leading: Icon(Icons.schedule),
            ),
          ],
        );
      },
    );
  }
}
