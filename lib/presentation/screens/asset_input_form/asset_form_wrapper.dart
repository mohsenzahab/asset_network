import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../core/enums/asset_category.dart';
import 'forms/fixed_asset_from.dart';
import '../../../core/localization/localizations.dart';
import '../../../core/utils/colors.dart';
import '../../../domain/entities/asset/asset.dart';
import '../../../locator.dart';
import 'forms/current_asset_form.dart';

/// A screen that wrappers all types of forms. If [asset] is provided
/// acts as edit screen for provided asset.
class AssetFormScreen extends StatefulWidget {
  const AssetFormScreen({super.key, required this.category, this.onBackTap});
  final AssetCategory category;
  final VoidCallback? onBackTap;

  static MaterialPageRoute<Asset> route(AssetCategory category,
          {Asset? asset}) =>
      MaterialPageRoute(
        builder: (context) => AssetFormScreen(
          category: category,
        ),
      );

  @override
  State<AssetFormScreen> createState() => _AssetFormScreenState();
}

class _AssetFormScreenState extends State<AssetFormScreen> {
  @override
  Widget build(BuildContext context) {
    bool isCurrent = _checkAssetType(widget.category);
    final l = sl<ILocalizations>();
    final c = sl<IColors>();

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: _getInputAppBar(context, l, c),
      body: KeyboardDismissOnTap(
        // dismissOnCapturedTaps: true,
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(
                top: 16.0, right: 8.0, left: 8.0, bottom: 100.0),
            child: isCurrent
                ? CurrentAssetForm(
                    assetType: widget.category,
                  )
                : FixedAssetForm(
                    assetType: widget.category,
                  )),
      ),
    );
  }

  AppBar _getInputAppBar(BuildContext context, ILocalizations l, IColors c) {
    return AppBar(
      title: Text(l('title_add_asset')),
    );
  }

  bool _checkAssetType(AssetCategory category) {
    switch (category) {
      case AssetCategory.stock:
      case AssetCategory.formalCurrency:
      case AssetCategory.digitalCurrency:
      case AssetCategory.gold:
        return true;
      case AssetCategory.residentialHouse:
      case AssetCategory.property:
      case AssetCategory.garden:
      case AssetCategory.car:
      case AssetCategory.other:
        return false;
    }
  }
}
