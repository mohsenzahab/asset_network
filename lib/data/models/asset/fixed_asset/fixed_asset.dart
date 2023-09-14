import '../../../../domain/entities/asset/fixed_asset/fixed_asset.dart';

import '../../../../config/values/api_keys.dart';
import '../../../../core/enums/personality.dart';
import '../../../../core/utils/formatter.dart';
import '../../../../domain/entities/asset/fixed_asset/garden.dart';
import '../../../../domain/entities/asset/fixed_asset/property.dart';
import '../../../../domain/entities/asset/fixed_asset/residential_house.dart';
import '../../ownership_model.dart';
import '../asset_model.dart';
import 'garden_asset_model.dart';
import 'property_asset_model.dart';
import 'residential_house_asset_model.dart';

abstract class FixedAssetModel extends FixedAsset implements AssetModel {
  factory FixedAssetModel.fromEntity(FixedAsset entity) {
    if (entity is ResidentialHouse) {
      return ResidentialHouseAssetModel.fromEntity(entity);
    }
    if (entity is Garden) {
      return GardenAssetModel.fromEntity(entity);
    }
    if (entity is Property) {
      return PropertyAssetModel.fromEntity(entity);
    }
    return entity as FixedAssetModel;
  }
  FixedAssetModel.fromJson(Map<String, dynamic> map)
      : super(
            title: map[keyTitle],
            amount: map[keyAmount],
            id: map[keyId],
            currentPrice: map[keyCurrentPrice],
            ownership: AssetOwnershipModel.fromJson(map[keyOwnershipId]),
            personality: Personality.fromJson(map),
            saleDate: Formatter.parseDate(map[keySaleDate]),
            salePrice: map[keySalePrice],
            purchaseDate: Formatter.parseDate(map[keyPurchaseDate]),
            purchasePrice: map[keyPurchasePrice],
            moreDetails: map[keyMoreDetails]);

  @override
  Map<String, dynamic> toJson() => {
        keyTitle: title,
        keyId: id,
        keyAmount: amount,
        keyCurrentPrice: currentPrice,
        keyPurchasePrice: purchasePrice,
        keyPurchaseDate: purchaseDate,
        keySaleDate: saleDate,
        keySalePrice: salePrice,
        keyPersonalityId: personality.index,
        keyOwnershipId: ownership.id,
        keyMoreDetails: moreDetails,
      };
}
