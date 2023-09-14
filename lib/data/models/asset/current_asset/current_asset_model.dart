import '../asset_model.dart';
import 'digital_currency_asset_model.dart';
import '../../../../domain/entities/asset/current_asset/gold_asset.dart';
import '../../../../config/values/api_keys.dart';
import '../../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../../../domain/entities/asset/current_asset/stock_asset.dart';
import 'formal_currency_asset_model.dart';
import 'gold_asset_model.dart';
import 'stock_asset_model.dart';

abstract class CurrentAssetModel extends CurrentAsset implements AssetModel {
  // CurrentAssetModel(
  //     {required super.title,
  //     required super.purchaseDate,
  //     required super.amount,
  //     required super.personality,
  //     required super.purchasePrice,
  //     required super.currentPrice});

  factory CurrentAssetModel.fromEntity(CurrentAsset entity) {
    if (entity is StockAsset) {
      return StockAssetModel.fromEntity(entity);
    }
    if (entity is GoldAsset) {
      return GoldAssetModel.fromEntity(entity);
    }
    if (entity is DigitalCurrencyAssetModel) {
      return DigitalCurrencyAssetModel.fromEntity(entity);
    }
    if (entity is FormalCurrencyAssetModel) {
      return FormalCurrencyAssetModel.fromEntity(entity);
    }
    return entity as CurrentAssetModel;
  }
  // CurrentAssetModel.fromJson(Map<String, dynamic> map)
  //     : super(
  //           title: map[keyName],
  //           amount: map[keyAmount],
  //           id: map[keyId],
  //           currentPrice: map[keyCurrentPrice],
  //           personality: Personality.values[map[keyPersonality]],
  //           purchaseDate: DateTime.parse(map[keyPurchaseDate]),
  //           purchasePrice: map[keyPurchasePrice]);

  @override
  Map<String, dynamic> toJson() => {
        keyName: title,
        keyId: id,
        keyAmount: amount,
        keyCurrentPrice: currentPrice,
        keyPurchasePrice: purchasePrice,
        keyPurchaseDate: purchaseDate,
        keyPersonalityId: personality,
      };
}
