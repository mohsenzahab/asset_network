import 'package:flutter/material.dart';
import '../../../../../config/values/layout.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../locator.dart';
import 'asset_basket_body.dart';
import 'summery_bar.dart';

class AssetBasketTabContent extends StatelessWidget {
  const AssetBasketTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Padding(
            padding: kPaddingContent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummeryBar(
                  title: l('total_basket_assets_val'),
                  e1: SummeryElement(name: l('toman'), value: 0),
                  e2: SummeryElement(name: l('frank'), value: 0),
                  e3: SummeryElement(name: l('dollar'), value: 0),
                ),
                const AssetBasketBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
