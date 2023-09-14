import '../../../../domain/entities/asset/fixed_asset/residential_house.dart';
import '../../../../domain/entities/asset/ownership.dart';
import '../../../../config/values/api_keys.dart';
import '../../../../core/enums/personality.dart';
import '../../../../core/utils/formatter.dart';
import '../../../../domain/entities/location/location.dart';
import 'property_asset_model.dart';

class ResidentialHouseAssetModel extends ResidentialHouse
    implements PropertyAssetModel {
  ResidentialHouseAssetModel.fromEntity(
    ResidentialHouse entity,
  ) : super(
          title: entity.title,
          amount: entity.amount,
          id: entity.id,
          currentPrice: entity.currentPrice,
          ownership: entity.ownership,
          personality: entity.personality,
          saleDate: entity.saleDate,
          purchaseDate: entity.purchaseDate,
          salePrice: entity.salePrice,
          purchasePrice: entity.purchasePrice,
          province: entity.province,
          city: entity.city,
          district: entity.district,
          alley: entity.alley,
          bystreet: entity.bystreet,
          floor: entity.floor,
          plaque: entity.plaque,
          mainStreet: entity.mainStreet,
          unit: entity.unit,
          moreDetails: entity.moreDetails,
        );
  ResidentialHouseAssetModel.fromJson(
    Map<String, dynamic> map,
    Map<String, AssetOwnership> ownershipMap,
    Map<String, Province> provinceMap,
    Map<String, City> cityMap,
    Map<String, District> districtMap,
  ) : super(
            title: map[keyTitle],
            amount: map[keyAmount],
            id: map[keyId],
            currentPrice: map[keyCurrentPrice],
            ownership: ownershipMap[map[keyOwnershipId].toString()]!,
            personality: Personality.fromJson(map),
            saleDate: Formatter.parseDate(map[keySaleDate]),
            purchaseDate: Formatter.parseDate(map[keyPurchaseDate]),
            salePrice: map[keySalePrice],
            purchasePrice: map[keyPurchasePrice],
            province: provinceMap[map[keyProvinceId].toString()]!,
            city: cityMap[map[keyCityId].toString()]!,
            district: districtMap[map[keyDistrictId].toString()]!,
            alley: map[keyAlley],
            bystreet: map[keyBystreet],
            floor: map[keyFloor],
            plaque: map[keyPlaque],
            mainStreet: map[keyMainStreet],
            unit: map[keyUnit],
            moreDetails: map[keyMoreDetails]);

  @override
  Map<String, dynamic> toJson() => {
        keyTitle: title,
        keyId: id,
        keyAmount: amount,
        keyCurrentPrice: currentPrice,
        keyPurchasePrice: purchasePrice,
        keyPurchaseDate: purchaseDate?.toIso8601String(),
        keySaleDate: saleDate?.toIso8601String(),
        keySalePrice: salePrice,
        keyPersonalityId: personality.index,
        keyOwnershipId: ownership.id,
        keyProvinceId: province.id,
        keyCityId: city.id,
        keyDistrictId: district.id,
        keyAlley: alley,
        keyMainStreet: mainStreet,
        keyBystreet: bystreet,
        keyPlaque: plaque,
        keyFloor: floor,
        keyUnit: unit,
        keyMoreDetails: moreDetails,
      };
}
