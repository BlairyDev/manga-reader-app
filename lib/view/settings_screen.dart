import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:manga_reader_app/data/constants.dart';
import 'package:manga_reader_app/view_models/settings_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _backupFrequency = 'Every week';

  Duration backupFrequency = Duration(days: 7);

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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Backup Frequency"),
                  Text(
                    "Backup started: ${backupStarted.value}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: DropdownButton<String>(
                value: _backupFrequency,
                items: const [
                  DropdownMenuItem(
                    value: "Every week",
                    child: Text("Every week"),
                  ),
                  DropdownMenuItem(
                    value: "Every month",
                    child: Text("Every month"),
                  ),
                  DropdownMenuItem(
                    value: "Every day",
                    child: Text("Every day"),
                  ),
                ],
                onChanged: (value) async {
                  await Workmanager().cancelByUniqueName("exportData");
                  setState(() {
                    _backupFrequency = value!;
                    backupStarted.value = DateFormat(
                      'yyyy-MM-dd',
                    ).format(DateTime.now());
                  });

                  switch (_backupFrequency) {
                    case "Every week":
                      backupFrequency = Duration(minutes: 15);
                      break;
                    case "Every month":
                      backupFrequency = Duration(days: 30);
                      break;
                    case "Every day":
                      backupFrequency = Duration(days: 1);
                      break;
                  }

                  await Workmanager().registerPeriodicTask(
                    "exportData",
                    "exportData",
                    frequency: backupFrequency,
                  );
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
