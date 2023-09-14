import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/values/layout.dart';
import '../../widgets/info/multiline_text.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../core/utils/formatter.dart';
import '../../../../domain/entities/asset/fixed_asset/property.dart';
import '../../../../locator.dart';
import '../../app/bloc/app_bloc.dart';
import '../../widgets/info/info_vertical.dart';

class FixedAssetInfoBody extends StatelessWidget {
  const FixedAssetInfoBody({super.key, required this.asset});

  final Property asset;

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    final appData = BlocProvider.of<AppBloc>(context).state;
    final currencyName = '(${l(appData.mainPreferredCurrency.name)})';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GridView.count(
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
            if (asset.currentPrice != null)
              InfoVertical(
                  title: l('current_price', [currencyName]),
                  value: asset.currentPrice != null
                      ? Formatter.formateNumber(context, asset.currentPrice!)
                      : '-'),
            if (asset.purchasePrice != null)
              InfoVertical(
                  title: l('purchase_price', [currencyName]),
                  value:
                      Formatter.formateNumber(context, asset.purchasePrice!)),
            if (asset.purchaseDate != null)
              InfoVertical(
                  title: l('purchase_date'),
                  value: Formatter.formatDateTime(context, asset.purchaseDate!,
                      calendar: appData.calendar)),
            if (asset.saleDate != null)
              InfoVertical(
                  title: l('sale_date'),
                  value: Formatter.formatDateTime(context, asset.saleDate!,
                      calendar: appData.calendar)),
            InfoVertical(
                title: l('personality'), value: l(asset.personality.name)),
            InfoVertical(
                title: l('ownership'), value: l(asset.ownership.title)),
            InfoVertical(title: l('province'), value: l(asset.province.name)),
            InfoVertical(title: l('city'), value: l(asset.city.name)),
            InfoVertical(title: l('district'), value: l(asset.district.name)),
            InfoVertical(title: l('main_street_name'), value: asset.mainStreet),
            InfoVertical(title: l('bystreet_name'), value: asset.bystreet),
            InfoVertical(title: l('alley'), value: asset.alley),
            InfoVertical(title: l('plaque'), value: asset.plaque),
            InfoVertical(
                title: l('floor'),
                value: Formatter.formateNumber(context, asset.floor)),
            InfoVertical(
                title: l('unit'),
                value: Formatter.formateNumber(context, asset.unit)),
          ],
        ),
        kSpaceVertical8,
        if (asset.moreDetails != null)
          MultilineTextInfo(asset.moreDetails!, title: l('more_details')),
      ],
    );
  }
}
