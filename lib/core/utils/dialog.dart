import 'package:flutter/material.dart';

import '../../config/values/styles.dart';
import '../../locator.dart';
import '../localization/localizations.dart';
import 'colors.dart';

Future<T?> showAlertDialog<T>(
    {required BuildContext context, List<Widget> children = const []}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      );
    },
  );
}

Future<bool?> showDeleteDialog({
  required BuildContext context,
  String title = 'title_delete_confirm',
  required String description,
  List<String>? descriptionArgs,
}) {
  final l = sl<ILocalizations>();
  final c = sl<IColors>();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: Text(l(title), style: kStyleDialogTitle),
        content: Text(l(description, descriptionArgs),
            style: TextStyle(color: c('textColorGray'))),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(c('errorColor'))),
              onPressed: () => Navigator.pop(context, true),
              child: Text(l('btn_delete'))),
          OutlinedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l('btn_cancel'))),
        ],
      );
    },
  );
}
