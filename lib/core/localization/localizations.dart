import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ILocalizations {
  Map<String, String>? _localizedValues;

  Future<ILocalizations> load(Locale locale) async {
    String lang = locale.languageCode;
    String jsonContent = await rootBundle.loadString("assets/lang/$lang.json");
    final List l = json.decode(jsonContent);
    _localizedValues = {};
    for (final map in l) {
      String name = map['name'];
      String value = map['key'];
      _localizedValues![name] = value;
    }
    return this;
  }

  String call(String name, [List<String>? args]) {
    String tr = _localizedValues![name] ?? name;
    if (args != null) {
      for (final char in args) {
        tr = tr.replaceFirst('?', _localizedValues![char] ?? char);
      }
    }
    return tr;
  }
}
