import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:manga_reader_app/data/constants.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';
import 'package:manga_reader_app/data/services/database_service.dart';
import 'package:manga_reader_app/di/locator.dart';
import 'package:manga_reader_app/view/routes/navigation.dart';
import 'package:manga_reader_app/view_models/chapter_view_model.dart';
import 'package:manga_reader_app/view_models/detail_view_model.dart';
import 'package:manga_reader_app/view_models/home_view_model.dart';
import 'package:manga_reader_app/view_models/library_view_model.dart';
import 'package:manga_reader_app/view_models/search_view_model.dart';
import 'package:manga_reader_app/view_models/settings_view_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      final result = await DatabaseService.instance.exportDatabase();
      if (result) {
        print("work manager working");
        // await showNotification(
        //   'Backup Complete',
        //   'Successfully downloaded backup file',
        // );
        await showNotification(
          'Backup Complete',
          'Successfully downloaded backup file',
        );
        return Future.value(result);
      } else {
        return Future.value(result);
      }
    } catch (e) {
      return Future.value(false);
    }
  });
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings settings = InitializationSettings(
    android: androidSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(settings);
}

Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'backup_channel',
    'Backup Notifications',
    channelDescription: 'Notifications for background backups',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(0, title, body, platformDetails);
}

Future<void> checkFirstTimeBackup() async {
  if (backupStarted.value.isEmpty) {
    await Workmanager().cancelByUniqueName("exportData");
    await Workmanager().registerPeriodicTask(
      "exportData",
      "exportData",
      frequency: Duration(days: 7),
    );
    backupStarted.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              HomeViewModel(repository: locator<MangadexRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailViewModel(
            mangaRepository: locator<MangadexRepository>(),
            dataRepository: locator<DataRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ChapterViewModel(repository: locator<MangadexRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              LibraryViewModel(dataRepository: locator<DataRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              SearchViewModel(repository: locator<MangadexRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              SettingsViewModel(dataRepository: locator<DataRepository>()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initThemeMode();
    _checkStoragePermission();
    _checkNotificationPermission();
    initNotifications();
    checkFirstTimeBackup();
    super.initState();
  }

  Future<void> _checkStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
  }

  Future<void> _checkNotificationPermission() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  void initThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? theme = prefs.getBool(Constants.themeModeKey);
    isDarkModeNotifier.value = theme ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Manga Reader App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
            ),
          ),
          home: Navigation(),
        );
      },
    );
  }
}
