import 'package:flutter/material.dart';

import '../../../../config/values/layout.dart';
import '../../../../config/values/styles.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/common.dart';
import '../../../../core/utils/dialog.dart';
import '../../../../locator.dart';

class StockEditScreen extends StatelessWidget {
  const StockEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    final c = sl<IColors>();
    return Scaffold(
      appBar: AppBar(
          title: Text(l('btn_edit_stock_basket')),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: kSizeIcon,
              )),
          actions: [
            IconButton(
                color: c('iconDone'),
                onPressed: () {},
                icon: const Icon(
                  Icons.done,
                  size: kSizeIcon,
                ))
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 50.0, right: 24, left: 16, bottom: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l('title_stock_basket'), style: TextStyle(fontSize: 16)),
              const TextField(),
              kSpaceVertical16,
              Text(
                l('des_stock_basket_rename'),
                style: TextStyle(
                  color: c('textColorGray'),
                ),
              )
            ]),
          ),
          const Divider(thickness: 1.5),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 24, left: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextButton(
                onPressed: () {
                  _showDeleteCautionDialog(context, c, l);
                },
                child: Text(
                  l('btn_delete_stock_basket'),
                  style: TextStyle(color: c('errorColor'), fontSize: 18),
                ),
              ),
              Text(
                l('des_stock_basket_delete'),
                style: TextStyle(
                  color: c('textColorGray'),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _showDeleteCautionDialog(
      BuildContext context, IColors c, ILocalizations l) {
    showAlertDialog<bool>(context: context, children: [
      Text(l('title_delete_confirm'), style: kStyleDialogTitle),
      kSpaceVertical8,
      Text(l('des_on_stock_basket_delete', ['تست']),
          style: TextStyle(color: c('textColorGray'))),
      kSpaceVertical16,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(c('errorColor'))),
              onPressed: () => Navigator.pop(context, true),
              child: Text(l('btn_delete'))),
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l('btn_cancel'))),
        ],
      )
    ]).then((result) {
      bool deleteBasket = result ?? false;
      if (deleteBasket) {
        log.d('Basket deleted');
// TODO: delete basket
      }
    });
  }
}
