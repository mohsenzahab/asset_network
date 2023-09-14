import 'current_asset.dart';

class DigitalCurrency extends CurrentAsset {
  DigitalCurrency({
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
