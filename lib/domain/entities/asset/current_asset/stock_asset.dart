import 'current_asset.dart';

class StockAsset extends CurrentAsset {
  StockAsset({
    required super.title,
    super.id,
    super.purchasePrice,
    super.salePrice,
    super.purchaseDate,
    super.saleDate,
    required super.amount,
    required super.personality,
  });
}
