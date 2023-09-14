import '../../../core/enums/personality.dart';

import '../../../config/values/api_keys.dart';
import '../../../domain/entities/asset/asset.dart';

abstract class AssetModel extends Asset {
  AssetModel.fromJson(Map<String, dynamic> map)
      : super(
            title: map[keyTitle],
            amount: map[keyAmount],
            personality: Personality.values[map[keyPersonalityId]],
            id: map[keyId],
            currentPrice: map[keyCurrentPrice],
            purchaseDate: DateTime.parse(map[keyPurchaseDate]),
            purchasePrice: map[keyPurchasePrice]);
  Map<String, dynamic> toJson();
}
