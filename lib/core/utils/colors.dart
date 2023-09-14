import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class IColors {
  Map<String, Color>? _colors;

  Future<IColors> load(ThemeMode mode) async {
    String theme = "light";
    if (mode == ThemeMode.dark) {
      theme = "dark";
    }
    String jsonContent =
        await rootBundle.loadString("assets/color/$theme.json");
    final l = json.decode(jsonContent);
    _colors = {};
    for (final map in l) {
      String name = map['name'];
      int value = _parseValue(map);
      _colors![name] = Color(value);
    }
    return this;
  }

  int _parseValue(map) =>
      int.parse('0x${(map['key'] as String).substring(1).padLeft(8, 'f')}');

  Color call(String name) => _colors![name]!;
}
