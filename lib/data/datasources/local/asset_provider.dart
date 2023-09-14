// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sabad_darai/config/values/db_values.dart';
import 'package:sabad_darai/core/utils/common.dart';
import 'package:sabad_darai/data/models/asset/current_asset/stock_asset_model.dart';
import 'package:sabad_darai/data/models/asset/fixed_asset/fixed_asset.dart';
import 'package:sabad_darai/domain/entities/asset/fixed_asset/fixed_asset.dart';
import 'package:sabad_darai/domain/entities/asset/fixed_asset/property.dart';
import 'package:sabad_darai/domain/entities/asset/ownership.dart';
import 'package:sabad_darai/domain/usecases/baskets/asset_basket/delete_asset.dart';
import 'package:sabad_darai/domain/usecases/baskets/asset_basket/edit_fixed_asset.dart';
import 'package:sabad_darai/domain/usecases/fixed_asset_form/save_fixed_asset.dart';
import 'package:sqflite/sqflite.dart';

import '../../../config/values/api_keys.dart';
import '../../../core/enums/asset_category.dart';
import '../../../domain/entities/asset/asset.dart';
import '../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../../domain/entities/location/location.dart';
import '../../../domain/usecases/baskets/asset_basket/edit_current_asset.dart';
import '../../../domain/usecases/current_asset_form/save_current_asset.dart';
import '../../models/asset/current_asset/current_asset_model.dart';
import '../../models/asset/current_asset/digital_currency_asset_model.dart';
import '../../models/asset/current_asset/formal_currency_asset_model.dart';
import '../../models/asset/current_asset/gold_asset_model.dart';
import '../../models/asset/fixed_asset/garden_asset_model.dart';
import '../../models/asset/fixed_asset/property_asset_model.dart';
import '../../models/asset/fixed_asset/residential_house_asset_model.dart';
import '../../models/location/city_model.dart';
import '../../models/location/district_model.dart';
import '../../models/location/province_model.dart';
import '../../models/ownership_model.dart';
import 'services/database.dart';

abstract class AssetProvider {
  Future<List<Asset>> getAssets();
  Future<FixedAsset> saveFixedAsset(SaveFixedAssetParams params);
  Future<CurrentAsset> saveCurrentAsset(SaveCurrentAssetParams params);
}

class AssetLocalProviderImpl extends AssetProvider {
  AssetLocalProviderImpl(DB database) : _db = database;

  final DB _db;
  Database get db => _db.database;

  @override
  Future<List<Asset>> getAssets() async {
    final b = db.batch();
    b.query(tableProvince);
    b.query(tableCity);
    b.query(tableDistrict);
    b.query(tableAssetOwnership);
    b.query(tableResidentialHouseAsset);
    b.query(tablePropertyAsset);
    b.query(tableGardenAsset);
    b.query(tableStockAsset);
    b.query(tableGoldAsset);
    b.query(tableFormalCurrencyAsset);
    b.query(tableDigitalCurrencyAsset);
    // b.query(tableCarAsset);
    // b.query(tableOtherAsset);
    return await b.commit().then((value) {
      List<Asset> assets = [];

      final Map<String, Province> provinces = {};
      final Map<String, City> cities = {};
      final Map<String, District> districts = {};
      final Map<String, AssetOwnership> ownerships = {};
      final results = value.cast<List<Map<String, dynamic>>>();
      for (Map<String, dynamic> map in results[0]) {
        provinces[map[keyId].toString()] = (ProvinceModel.fromJson(map));
      }
      for (Map<String, dynamic> map in results[1]) {
        cities[map[keyId].toString()] = (CityModel.fromJson(map));
      }
      for (Map<String, dynamic> map in results[2]) {
        districts[map[keyId].toString()] = (DistrictModel.fromJson(map));
      }
      for (Map<String, dynamic> map in results[3]) {
        ownerships[map[keyId].toString()] = (AssetOwnershipModel.fromJson(map));
      }
      for (Map<String, dynamic> map in results[4]) {
        assets.add(ResidentialHouseAssetModel.fromJson(
            map, ownerships, provinces, cities, districts));
      }
      for (Map<String, dynamic> map in results[5]) {
        assets.add(PropertyAssetModel.fromJson(
            map, ownerships, provinces, cities, districts));
      }
      for (Map<String, dynamic> map in results[6]) {
        assets.add(GardenAssetModel.fromJson(
            map, ownerships, provinces, cities, districts));
      }
      for (Map<String, dynamic> map in results[7]) {
        assets.add(StockAssetModel.fromJson(map));
      }
      for (Map<String, dynamic> map in results[8]) {
        assets.add(GoldAssetModel.fromJson(map));
      }
      for (Map<String, dynamic> map in results[9]) {
        assets.add(FormalCurrencyAssetModel.fromJson(map));
      }
      for (Map<String, dynamic> map in results[10]) {
        assets.add(DigitalCurrencyAssetModel.fromJson(map));
      }
      // for (Map<String, dynamic> map in results[9]) {
      //   assets.add(CarAssetModel.fromJson(map));
      // }
      // for (Map<String, dynamic> map in results[10]) {
      //   assets.add(OtherAssetModel.fromJson(map));
      // }
      return assets;
    });
  }

  @override
  Future<FixedAsset> saveFixedAsset(SaveFixedAssetParams params) async {
    final table = _getTableName(params.assetType);
    final assetModel = FixedAssetModel.fromEntity(params.asset);
    await insertOwnership(assetModel.ownership);
    if (assetModel is PropertyAssetModel) {
      await insertProvince(assetModel.province);
      await insertCity(assetModel.city);
      await insertDistrict(assetModel.district);
    }
    int id = await db.insert(table, assetModel.toJson());
    assetModel.id = id;
    return assetModel;
  }

  Future<void> insertOwnership(AssetOwnership ownership) async {
    db.insert(
        tableAssetOwnership, AssetOwnershipModel.fromEntity(ownership).toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertProvince(Province province) async {
    db.insert(tableProvince, ProvinceModel.fromEntity(province).toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertCity(City city) async {
    db.insert(tableCity, CityModel.fromEntity(city).toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertDistrict(District district) async {
    db.insert(tableDistrict, DistrictModel.fromEntity(district).toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<CurrentAsset> saveCurrentAsset(SaveCurrentAssetParams params) async {
    final table = _getTableName(params.type);
    final assetModel = CurrentAssetModel.fromEntity(params.asset);
    int id = await db.insert(table, assetModel.toJson());
    assetModel.id = id;
    return assetModel;
  }

  String _getTableName(AssetCategory type) {
    switch (type) {
      case AssetCategory.stock:
        return tableStockAsset;
      case AssetCategory.residentialHouse:
        return tableResidentialHouseAsset;
      case AssetCategory.property:
        return tablePropertyAsset;
      case AssetCategory.garden:
        return tableGardenAsset;
      case AssetCategory.gold:
        return tableGoldAsset;
      case AssetCategory.formalCurrency:
        return tableFormalCurrencyAsset;
      case AssetCategory.digitalCurrency:
        return tableDigitalCurrencyAsset;
      case AssetCategory.car:
        return tableCarAsset;
      case AssetCategory.other:
        return tableOtherAsset;
    }
  }

  Future<bool> deleteAsset(DeleteAssetParams params) async =>
      (await db.delete(_getTableName(params.type),
          where: '$keyId=?', whereArgs: [params.asset.id])) !=
      0;

  Future<bool> editFixedAsset(EditFixedAssetParams params) async {
    final assetModel = FixedAssetModel.fromEntity(params.asset);
    return (await db.update(
            _getTableName(params.asset.type), assetModel.toJson(),
            where: '$keyId=?', whereArgs: [params.asset.id])) !=
        0;
  }

  Future<bool> editCurrentAsset(EditCurrentAssetParams params) async =>
      (await db.update(_getTableName(params.asset.type),
          CurrentAssetModel.fromEntity(params.asset).toJson(),
          where: '$keyId=?', whereArgs: [params.asset.id])) !=
      0;
}
