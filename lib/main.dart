import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/constants.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';
import 'package:manga_reader_app/di/locator.dart';
import 'package:manga_reader_app/navigation.dart';
import 'package:manga_reader_app/view_models/chapter_view_model.dart';
import 'package:manga_reader_app/view_models/detail_view_model.dart';
import 'package:manga_reader_app/view_models/home_view_model.dart';
import 'package:manga_reader_app/view_models/library_view_model.dart';
import 'package:manga_reader_app/view_models/search_view_model.dart';
import 'package:manga_reader_app/view_models/settings_view_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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
    super.initState();
  }

  Future<void> _checkStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
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
