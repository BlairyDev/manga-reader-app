import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).loadMangaSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          List<MangaData>? mangas = viewModel.mangas;
          int? mangasCount = mangas.length;

          return Center(
            child: ListView.builder(
              itemCount: mangasCount,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      mangas[index].attributes!.title!.en.toString(),
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
