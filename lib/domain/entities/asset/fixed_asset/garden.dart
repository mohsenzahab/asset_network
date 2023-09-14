import 'property.dart';

class Garden extends Property {
  Garden({
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
    required super.province,
    required super.city,
    required super.district,
    required super.mainStreet,
    required super.bystreet,
    required super.alley,
    required super.plaque,
    required super.floor,
    required super.unit,
    super.moreDetails,
  });
}
