// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:sabad_darai/domain/entities/asset/current_asset/gold_asset.dart';
import 'package:sabad_darai/domain/entities/asset/current_asset/stock_asset.dart';
import 'package:sabad_darai/domain/entities/asset/fixed_asset/property.dart';

import '../../../core/enums/asset_category.dart';
import '../../../core/enums/personality.dart';
import 'current_asset/digital_currency.dart';
import 'current_asset/formal_currency.dart';
import 'fixed_asset/garden.dart';
import 'fixed_asset/residential_house.dart';

abstract class Asset extends Equatable {
  Asset({
    this.id,
    required this.amount,
    required this.title,
    required this.personality,
    this.purchasePrice,
    this.salePrice,
    this.saleDate,
    this.currentPrice,
    this.purchaseDate,
    this.moreDetails,
  });
  int? id;
  final String title;
  final int amount;
  final int? purchasePrice;
  final int? salePrice;
  final int? currentPrice;
  final DateTime? purchaseDate;
  final DateTime? saleDate;
  final Personality personality;
  final String? moreDetails;

  @override
  List<Object?> get props => [
        id,
        amount,
        purchasePrice,
        currentPrice,
        salePrice,
        purchaseDate,
        saleDate
      ];

  @override
  String toString() {
    return 'Asset->id:$id,title:$title';
  }

  AssetCategory get type {
    if (this is ResidentialHouse) return AssetCategory.residentialHouse;
    if (this is Property) return AssetCategory.property;
    if (this is Garden) return AssetCategory.garden;
    if (this is StockAsset) return AssetCategory.stock;
    if (this is FormalCurrency) return AssetCategory.formalCurrency;
    if (this is DigitalCurrency) return AssetCategory.digitalCurrency;
    if (this is GoldAsset) return AssetCategory.gold;
    return AssetCategory.other;
  }
}
