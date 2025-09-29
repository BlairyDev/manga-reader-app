import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';
import 'package:manga_reader_app/view_models/detail_view_model.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.description,
  });

  final String id;
  final String title;
  final String description;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    Provider.of<DetailViewModel>(
      context,
      listen: false,
    ).loadMangaChapters(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailViewModel>(
        builder: (context, viewModel, child) {
          Map<String, Volume> mangaVolumes = viewModel.mangaChapters;

          return viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Text(widget.title),
                    Text(widget.description),

                    Expanded(
                      child: ListView.builder(
                        itemCount: mangaVolumes.length,
                        itemBuilder: (context, index) {
                          Map<String, Chapter> chapters =
                              mangaVolumes[mangaVolumes.keys.elementAt(index)]!
                                  .chapters;

                          return ExpansionTile(
                            title: Text("Volume $index"),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: chapters.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      chapters[chapters.keys.elementAt(index)]!
                                          .chapter
                                          .toString(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
