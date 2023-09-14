import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/asset/asset.dart';
import '../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../../domain/entities/asset/fixed_asset/property.dart';
import '../../../locator.dart';
import '../../blocs/asset_edit/current/current_asset_edit_cubit.dart';
import '../../blocs/asset_edit/property/property_asset_edit_cubit.dart';
import 'current_asset_edit_screen.dart';
import 'property_asset_edit_screen.dart';

class AssetEditScreen extends StatelessWidget {
  const AssetEditScreen({super.key, required this.asset});
  final Asset asset;

  static MaterialPageRoute<Asset> route({required Asset asset}) =>
      MaterialPageRoute<Asset>(builder: (_) => AssetEditScreen(asset: asset));

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (asset is CurrentAsset) {
      body = CurrentAssetEditScreen(asset: asset as CurrentAsset);
    } else if (asset is Property) {
      body = PropertyAssetEditScreen(asset: asset as Property);
    } else {
      body = Container();
    }
    return MultiBlocProvider(providers: [
      BlocProvider<CurrentAssetEditCubit>(
        create: (context) => CurrentAssetEditCubit(sl()),
      ),
      BlocProvider<PropertyAssetEditCubit>(
        create: (context) => PropertyAssetEditCubit(sl()),
      ),
    ], child: body);
  }
}

// class _EditScreenWrapper extends StatelessWidget {
//   const _EditScreenWrapper({
//     Key? key,
//     required this.asset,
//   }) : super(key: key);

//   final Asset asset;

//   @override
//   Widget build(BuildContext context) {
//     final l = sl<ILocalizations>();
//     final c = sl<IColors>();
//     final editCubit = BlocProvider.of<AssetEditScreenCubit>(context);
//     // final assetCubit = BlocProvider.of<AssetCubit>(context);
//     Widget body;
//     if (asset is CurrentAsset) {
//       body = CurrentAssetEditScreen(asset: asset as CurrentAsset);
//     }
//     // else if (asset is Property) {
//     //   body = FixedAssetInfoBody(asset: asset as Property);
//     // }
//     else {
//       body = Container();
//     }
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('${l('title_asset_info')} ${l(asset.type.textId)}'),
//           leading: IconButton(
//               onPressed: () => Navigator.pop(context),
//               icon: const Icon(
//                 Icons.close,
//                 size: kSizeIcon,
//               )),
//           actions: [
//             IconButton(
//                 color: c('iconDone'),
//                 onPressed: editCubit.saveChanges,
//                 icon: const Icon(
//                   Icons.done,
//                   size: kSizeIcon,
//                 ))
//           ]),
//       body: BlocConsumer<AssetEditScreenCubit, AssetEditScreenState>(
//         listener: (context, state) {
//           return;
//         },
//         builder: (context, state) => SingleChildScrollView(
//           child: Container(
//               alignment: Alignment.centerRight,
//               margin: const EdgeInsets.all(16),
//               child: body),
//         ),
//       ),
//     );
//   }
// }
