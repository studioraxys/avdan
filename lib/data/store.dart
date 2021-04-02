import 'dart:async' show Future;
import 'dart:convert';
import 'package:avdan/data/chapter.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> loadChapters() async {
  var text = await rootBundle.loadString('assets/chapters.json');
  List<dynamic> array = json.decode(text);
  chapters = List<Chapter>.from(
      array.map((x) => Chapter.fromJson(x as Map<String, dynamic>)));
}

late List<Chapter> chapters = [];
