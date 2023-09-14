import '../../location/location.dart';
import 'fixed_asset.dart';

class Property extends FixedAsset {
  final Province province;
  final City city;
  final District district;
  final String mainStreet;
  final String bystreet;
  final String alley;
  final String plaque;
  final int floor;
  final int unit;

  Property({
    required super.title,
    super.id,
    required super.amount,
    required super.personality,
    required super.ownership,
    super.purchasePrice,
    super.currentPrice,
    super.salePrice,
    super.purchaseDate,
    super.saleDate,
    required this.province,
    required this.city,
    required this.district,
    required this.mainStreet,
    required this.bystreet,
    required this.alley,
    required this.plaque,
    required this.floor,
    required this.unit,
    super.moreDetails,
  });
}
