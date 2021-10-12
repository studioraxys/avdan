import 'package:avdan/data/chapter.dart';
import 'package:recase/recase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'language.dart';

class Translation {
  Translation(this._map);

  final Map<String, String> _map;
  Chapter? chapter;

  Iterable<String> get keys => _map.keys;
  Iterable<String> get values => _map.values;

  String? get(String? key) => _map[key];
  String get id => get('english')!;

  factory Translation.fromJson(dynamic json) {
    return Translation(
      Map.castFrom<String, dynamic, String, String>(
        json as Map<String, dynamic>,
      ),
    );
  }

  String text(
    Language language, [
    bool alt = false,
  ]) {
    var text = get(language.name.id) ?? '';
    if (alt) text = get(language.alt) ?? text;
    return text.headerCase;
  }

  ImageProvider image() {
    final url = [
      'assets',
      'images',
      if (chapter != null) chapter!.id,
      '$id.png',
    ].join('/');
    return AssetImage(url);
  }
}
