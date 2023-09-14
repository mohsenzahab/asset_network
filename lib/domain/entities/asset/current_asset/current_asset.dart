import '../asset.dart';

/// Assets like stock, gold etc.
abstract class CurrentAsset extends Asset {
  CurrentAsset({
    required super.title,
    super.purchasePrice,
    super.salePrice,
    super.purchaseDate,
    super.saleDate,
    required super.amount,
    required super.personality,
    super.id,
  });
}
