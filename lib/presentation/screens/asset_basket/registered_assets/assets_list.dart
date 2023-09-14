import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_date_picker/intl_date_picker.dart';
import '../../../../core/utils/formatter.dart';
import '../../asset_info_screen/asset_info_screen.dart';
import '../../../../../config/values/other.dart';
import '../../../../../core/localization/localizations.dart';
import '../../../../../locator.dart';
import '../../../app/bloc/app_bloc.dart';
import '../../../blocs/asset_basket/asset_cubit.dart';

class AssetsList extends StatefulWidget {
  AssetsList({super.key});

  @override
  State<AssetsList> createState() => _AssetsListState();
}

class _AssetsListState extends State<AssetsList> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _scrollableScrollARound();
  }

  void _scrollableScrollARound() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: kAssetListScrollDuration,
          curve: Curves.easeIn);
      await Future.delayed(kAssetListScrollDuration * 0.2);
      await scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: kAssetListScrollDuration,
          curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    final cubit = BlocProvider.of<AssetCubit>(context);
    final appData = BlocProvider.of<AppBloc>(context).state;
    return Scrollbar(
      controller: scrollController,
      thickness: 1,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 12,
          border: const TableBorder(
            horizontalInside: BorderSide(
                color: Colors.black, strokeAlign: StrokeAlign.center, width: 1),
          ),
          columns: [
            // todo: use this formula
            // _name.length > 7 ? _name.substring(0, 7)+'...' : _name,
            DataColumn(
                label: Text(
              l('date'),
            )),
            DataColumn(
                label: Text(
              l('type'),
            )),
            DataColumn(
                label: Text(
              l('name'),
            )),
            DataColumn(
                numeric: true,
                label: Text(
                  l('count'),
                )),
            DataColumn(
                numeric: true,
                label: Text(
                  l('purchase_price',
                      ['(${l(appData.mainPreferredCurrency.name)})']),
                )),
            DataColumn(
                numeric: true,
                label: Text(
                  l('current_price',
                      ['(${l(appData.mainPreferredCurrency.name)})']),
                )),
            const DataColumn(
                numeric: true,
                label: Text(
                  '',
                )),
          ],
          rows: cubit.state.assets
              .map((asset) => DataRow(cells: [
                    DataCell(Text(
                        asset.purchaseDate != null || asset.saleDate != null
                            ? IntlDateUtils.formatDate(
                                context,
                                asset.purchaseDate ?? asset.saleDate!,
                                appData.calendar)
                            : 'null')),
                    DataCell(Text(l(asset.type.textId))),
                    DataCell(Text(asset.title)),
                    DataCell(
                        Text(Formatter.formateNumber(context, asset.amount))),
                    DataCell(Text(asset.purchasePrice != null
                        ? Formatter.formateNumber(context, asset.purchasePrice!)
                        : '-')),
                    DataCell(Text(asset.currentPrice != null
                        ? Formatter.formateNumber(context, asset.currentPrice!)
                        : '-')),
                    DataCell(
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push<bool>(AssetInfoScreen.route(asset: asset))
                                .then((value) => debugPrint('sdlfjl $value'));
                          },
                          child: const Icon(Icons.info)),
                    ),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}

class CenterText extends StatelessWidget {
  const CenterText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
    );
  }
}
