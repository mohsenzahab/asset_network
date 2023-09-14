import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../widgets/info/info_vertical.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../core/utils/formatter.dart';
import '../../../../locator.dart';
import '../../app/bloc/app_bloc.dart';

class CurrentAssetInfoBody extends StatelessWidget {
  const CurrentAssetInfoBody({super.key, required this.asset});

  final CurrentAsset asset;

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    final appData = BlocProvider.of<AppBloc>(context).state;
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      shrinkWrap: true,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        InfoVertical(title: l('word_title'), value: asset.title),
        InfoVertical(
            title: l('count'),
            value: Formatter.formateNumber(context, asset.amount)),
        InfoVertical(
            title: l('current_price',
                ['(${l(appData.mainPreferredCurrency.name)})']),
            value: asset.currentPrice != null
                ? Formatter.formateNumber(context, asset.currentPrice!)
                : '0'),
        InfoVertical(
            title: l('purchase_price',
                ['(${l(appData.mainPreferredCurrency.name)})']),
            value: Formatter.formateNumber(
                context, asset.purchasePrice ?? 200000)),
        InfoVertical(
            title: l('purchase_date'),
            value: Formatter.formatDateTime(context, asset.purchaseDate!,
                calendar: appData.calendar)),
      ],
    );
  }
}
