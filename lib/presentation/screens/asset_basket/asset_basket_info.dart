import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/enums/asset_category.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../core/utils/common.dart';
import '../../../../domain/entities/asset/asset.dart';
import '../../../../locator.dart';
import '../../blocs/asset_basket/asset_cubit.dart';
import '../../widgets/bottom_sheet.dart';
import '../asset_input_form/asset_form_wrapper.dart';
import '../asset_input_form/category_grid.dart';
import 'info_screen_appbar.dart';
import 'registered_assets/assets_list.dart';
import 'summery_bar.dart';

class AssetBasketInfo extends StatelessWidget {
  const AssetBasketInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final basket = BlocProvider.of<AssetCubit>(context);
    final l = sl<ILocalizations>();
    final stockBasket = basket.state.stockBasket!;

    log.d('asset info basket built');

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: InfoAppBar(
            basketName: stockBasket.info.name,
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          SummeryBar(
            title: l('total_basket_assets_val'),
            // TODO:clean code: fix types
            e1: SummeryElement(
                name: l('toman'),
                value: stockBasket.totalValueCHF?.toDouble() ?? 0),
            e2: SummeryElement(
                name: l('frank'),
                value: stockBasket.totalValue?.toDouble() ?? 0),
            e3: SummeryElement(
                name: l('dollar'),
                value: stockBasket.totalValueUSD?.toDouble() ?? 0),
          ),
          BlocBuilder<AssetCubit, AssetState>(
            buildWhen: (previous, current) => current.assets != previous.assets,
            builder: (_, __) => basket.state.assets.isNotEmpty
                ? AssetsList()
                : const SizedBox.shrink(),
          ),
          ElevatedButton(
              onPressed: () {
                _showTransactionsSheet(context);
              },
              child: Text(l('btn_register_assets'))),
          SfCartesianChart(
            legend: Legend(),
          )
        ]),
      ),
    );
  }

  void _showTransactionsSheet(BuildContext context) {
    showIBottomSheet(
        context: context,
        child: CategoryGrid(onCategoryTap: (category) {
          _openAssetForm(context, category);
        }));
  }

  _openAssetForm(BuildContext context, AssetCategory category) {
    Navigator.of(context)
        .pushReplacement<Asset, Object>(AssetFormScreen.route(category))
        .then((result) {
      if (result != null) {
        BlocProvider.of<AssetCubit>(context).addAsset(result);
      }
    });
  }
}
