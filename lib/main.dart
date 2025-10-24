import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';
import 'package:manga_reader_app/di/locator.dart';
import 'package:manga_reader_app/navigation.dart';
import 'package:manga_reader_app/view_models/chapter_view_model.dart';
import 'package:manga_reader_app/view_models/detail_view_model.dart';
import 'package:manga_reader_app/view_models/home_view_model.dart';
import 'package:manga_reader_app/view_models/library_view_model.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: Navigation(),
    );
  }
}
