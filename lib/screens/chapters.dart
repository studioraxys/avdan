import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'chapter_grid.dart';

class ChaptersScreen extends StatelessWidget {
  ChaptersScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: chapters.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              for (var chapter in chapters)
                Tab(
                  text: capitalize(chapter.translations['english'] ?? ''),
                ),
            ],
          ),
          title: Text(
            capitalize(targetLanguage),
          ),
        ),
        body: TabBarView(
          children: [
            for (var chapter in chapters)
              ChapterGrid(
                chapter: chapter,
              ),
          ],
        ),
      ),
    );
  }
}
