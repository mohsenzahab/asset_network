part of 'fixed_asset_form_cubit.dart';

class FixedAssetFormData {
  FixedAssetFormData.empty();
  FixedAssetFormData.fromAsset(FixedAsset asset)
      : title = asset.title,
        purchasePrice = asset.purchasePrice,
        purchaseDate = asset.purchaseDate,
        salePrice = asset.salePrice,
        saleDate = asset.saleDate,
        personality = asset.personality,
        ownership = asset.ownership {
    if (asset is Property) {
      province = asset.province;
      city = asset.city;
      district = asset.district;
      mainStreet = asset.mainStreet;
      bystreet = asset.bystreet;
      alley = asset.alley;
      plaque = asset.plaque;
      floor = asset.floor;
      unit = asset.unit;
      moreDetails = asset.moreDetails;
    }
  }
  String? title;
  Personality personality = Personality.private;
  int? purchasePrice;
  int? currentPrice;
  int? salePrice;
  DateTime? purchaseDate;
  DateTime? saleDate;
  AssetOwnership? ownership;

  Province? province;

  City? city;

  District? district;

  String? mainStreet;

  String? bystreet;

  String? alley;

  String? plaque;

  int? floor;

  int? unit;

  String? moreDetails;
}
