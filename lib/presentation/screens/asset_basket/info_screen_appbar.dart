import 'package:flutter/material.dart';
import 'package:sabad_darai/locator.dart';

import '../../../../core/localization/localizations.dart';
import 'asset_edit_screen.dart';

class InfoAppBar extends StatelessWidget {
  const InfoAppBar({super.key, required this.basketName});
  final String basketName;

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();

    return AppBar(
      title: Text(basketName),
      actions: [
        TextButton(
            onPressed: () => Navigator.push(context, BasketEditScreen.route()),
            child: Text(l('btn_manage_basket')))
        // IconButton(
        //     onPressed: () => _showMoreOptions(context),
        //     icon: const Icon(Icons.more_vert))
      ],
    );
  }

  // _showMoreOptions(BuildContext context) {
  //   final l = sl<ILocalizations>();
  //   showIBottomSheet(context: context, children: [
  //     kSpaceVertical8,
  //     TextButton(
  //         onPressed: () {
  //           Navigator.pushReplacement(context, BasketEditScreen.route());
  //         },
  //         child: Text(l('btn_edit'))),
  //   ]);
  // }
}
