import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/values/layout.dart';
import '../../../core/utils/messenger.dart';
import '../../widgets/default_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/bloc/state.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../locator.dart';
import '../../blocs/asset_basket/asset_cubit.dart';
import 'asset_basket_info.dart';

class AssetBasketBody extends StatelessWidget {
  const AssetBasketBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    return BlocListener<AssetCubit, AssetState>(
      listener: (context, state) {
        if (state.message != null) {
          _handleNewStateMessage(context, l, state);
        }
      },
      child: DefaultContainer(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: kPaddingButtonShowInfo,
            child: ElevatedButton(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(kPaddingButtonShowInfo)),
                onPressed: () => _showBasketInfo(context),
                child: Text(
                  l('btn_show_basket_info'),
                )),
          ),
          SfCartesianChart(
            legend: Legend(),
          )
        ]),
      ),
    );
  }

  void _showBasketInfo(BuildContext context) {
    final screen = MaterialPageRoute(builder: (ctx) => const AssetBasketInfo());
    Navigator.push(context, screen);
  }

  void _handleNewStateMessage(
      BuildContext context, ILocalizations l, AssetState state) {
    final messenger = Messenger(context, l);
    switch (state.status) {
      case BlocStatus.success:
        messenger.showSnackBarSuccess(state.message);
        break;
      case BlocStatus.failure:
        messenger.showSnackBarFailure(state.message);
        break;
      default:
    }
  }
}
