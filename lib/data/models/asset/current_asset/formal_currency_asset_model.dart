import '../../../../core/enums/personality.dart';

import '../../../../config/values/api_keys.dart';
import '../../../../core/utils/formatter.dart';
import '../../../../domain/entities/asset/current_asset/formal_currency.dart';
import 'current_asset_model.dart';

class FormalCurrencyAssetModel extends FormalCurrency
    implements CurrentAssetModel {
  FormalCurrencyAssetModel.fromEntity(FormalCurrency entity)
      : super(
            title: entity.title,
            id: entity.id,
            amount: entity.amount,
            personality: entity.personality,
            purchasePrice: entity.purchasePrice,
            purchaseDate: entity.purchaseDate);
  FormalCurrencyAssetModel.fromJson(Map<String, dynamic> map)
      : super(
            title: map[keyTitle],
            id: map[keyId],
            amount: map[keyAmount],
            personality: Personality.fromJson(map),
            purchasePrice: map[keyPurchasePrice],
            purchaseDate: Formatter.parseDate(map[keyPurchaseDate]));

  @override
  Map<String, dynamic> toJson() => {
        keyName: title,
        keyId: id,
        keyAmount: amount,
        keyCurrentPrice: currentPrice,
        keyPersonalityId: personality.index,
        keyPurchasePrice: purchasePrice,
        keyPurchaseDate: purchaseDate?.toIso8601String()
      };
}
