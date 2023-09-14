import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/values/layout.dart';
import '../../../config/values/styles.dart';
import '../../../locator.dart';
import '../../../core/utils/dialog.dart';

import '../../../../core/localization/localizations.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/common.dart';
import '../../blocs/asset_basket/asset_cubit.dart';

class BasketEditScreen extends StatelessWidget {
  const BasketEditScreen({super.key});

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const BasketEditScreen());

  @override
  Widget build(BuildContext context) {
    final basket = BlocProvider.of<AssetCubit>(context).state.stockBasket!;

    final l = sl<ILocalizations>();
    final c = sl<IColors>();
    return Scaffold(
      appBar: AppBar(
          title: Text(l('btn_edit_asset_basket')),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: kSizeIcon,
              )),
          actions: [
            IconButton(
                color: c('iconDone'),
                onPressed: () {
                  // todo: edit basket
                },
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
              Text(l('title_asset_basket'), style: TextStyle(fontSize: 16)),
              TextFormField(initialValue: basket.info.name),
            ]),
          ),
          const Divider(thickness: 1.5),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 24, left: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextButton(
                onPressed: () {
                  _showDeleteCautionDialog(context, c, l, basket.info.name);
                },
                child: Text(
                  l('btn_delete_asset_basket'),
                  style: TextStyle(color: c('errorColor'), fontSize: 18),
                ),
              ),
              Text(
                '   ${l('des_asset_basket_delete')}',
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
      BuildContext context, IColors c, ILocalizations l, String basketName) {
    showAlertDialog<bool>(context: context, children: [
      Text(l('title_delete_confirm'), style: kStyleDialogTitle),
      kSpaceVertical8,
      Text(l('des_on_asset_basket_delete', [basketName]),
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
