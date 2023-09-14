import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabad_darai/presentation/screens/asset_edit_screen/asset_edit_screen.dart';
import '../../../core/utils/messenger.dart';
import '../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../blocs/asset_basket/asset_cubit.dart';
import 'current_asset_info_body.dart';
import 'fixed_asset_info_body.dart';
import '../../../core/localization/localizations.dart';
import '../../../domain/entities/asset/asset.dart';
import '../../../domain/entities/asset/fixed_asset/property.dart';
import '../../../locator.dart';
import '../../../core/utils/dialog.dart';

class AssetInfoScreen extends StatefulWidget {
  const AssetInfoScreen({super.key, required this.asset});

  final Asset asset;

  static MaterialPageRoute<bool> route({required Asset asset}) =>
      MaterialPageRoute<bool>(builder: (_) => AssetInfoScreen(asset: asset));

  @override
  State<AssetInfoScreen> createState() => _AssetInfoScreenState();
}

class _AssetInfoScreenState extends State<AssetInfoScreen> {
  late Asset asset;

  @override
  void initState() {
    asset = widget.asset;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    final assetCubit = BlocProvider.of<AssetCubit>(context);
    Widget body;
    if (asset is CurrentAsset) {
      body = CurrentAssetInfoBody(asset: asset as CurrentAsset);
    } else if (asset is Property) {
      body = FixedAssetInfoBody(asset: asset as Property);
    } else {
      body = Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${l('title_asset_info')} ${l(asset.type.textId)}'),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                if (value == 'delete') {
                  _handleAssetDelete(context, assetCubit);
                } else if (value == 'edit') {
                  _handleAssetEdit(context, assetCubit, l);
                }
              },
              itemBuilder: (_) => [
                    PopupMenuItem(value: 'edit', child: Text(l('btn_edit'))),
                    PopupMenuItem(
                        value: 'delete', child: Text(l('btn_delete'))),
                  ]),
        ],
      ),
      body: BlocListener<AssetCubit, AssetState>(
        listener: (context, state) {
          return;
        },
        child: SingleChildScrollView(
          child: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(16),
              child: body),
        ),
      ),
    );
  }

  Future<void> _handleAssetDelete(
      BuildContext context, AssetCubit assetCubit) async {
    showDeleteDialog(context: context, description: 'des_on_asset_delete')
        .then((value) async {
      if (value == true) {
        return await assetCubit.deleteAsset(asset);
      }
      return false;
    }).then((result) {
      if (result) {
        Navigator.pop(context, result);
      }
    });
  }

  void _handleAssetEdit(
      BuildContext context, AssetCubit assetCubit, ILocalizations l) {
    Navigator.push(context, AssetEditScreen.route(asset: asset))
        .then((updatedAsset) {
      if (updatedAsset != null) {
        Messenger(context, l).showSnackBarSuccess('message_edit_asset_success');
        assetCubit.updateAsset(updatedAsset);
        setState(() {
          asset = updatedAsset;
        });
      }
    });
  }
}
