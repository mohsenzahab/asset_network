import '../../../../data/models/asset/fixed_asset/fixed_asset.dart';

import '../../../../core/enums/personality.dart';
import '../asset.dart';
import '../ownership.dart';

/// Assets like home, car etc.
abstract class FixedAsset extends Asset {
  FixedAsset({
    required super.title,
    required super.amount,
    required super.personality,
    required this.ownership,
    super.id,
    super.purchaseDate,
    super.salePrice,
    super.saleDate,
    required super.purchasePrice,
    required super.currentPrice,
    super.moreDetails,
  });

  final AssetOwnership ownership;
}
