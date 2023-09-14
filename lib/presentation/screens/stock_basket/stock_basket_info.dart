import 'package:flutter/material.dart';
import 'package:sabad_darai/presentation/screens/stock_basket/stock_edit_screen.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../locator.dart';
import '../asset_basket/summery_bar.dart';
import 'stock_basket_history.dart';

class StockBasketInfoWidget extends StatelessWidget {
  const StockBasketInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();

    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          debugPrint('refresh');
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummeryBar(
                  e1: SummeryElement(name: l('total_assets'), value: 10000),
                  e2: SummeryElement(name: l('basket_value'), value: 0),
                  e3: SummeryElement(name: l('purchasing_power'), value: 10000),
                ),
                const Placeholder(
                  fallbackHeight: 300,
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
                  child: ElevatedButton(
                      onPressed: () {}, child: Text(l('btn_transaction'))),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      TextButton.icon(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StockBasketHistoryWidget())),
                          icon: const Icon(Icons.history),
                          label: Text(l('stock_basket_history'))),
                      TextButton.icon(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StockEditScreen())),
                          icon: const Icon(Icons.settings),
                          label: Text(l('stock_basket_management'))),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
