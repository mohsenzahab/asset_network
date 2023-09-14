import 'dart:async';
import 'package:path/path.dart';
import '../../../../config/values/api_keys.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../config/values/db_values.dart';

class DB {
  DB._();
  Database? _database;
  static DB? _db;

  static Future<DB> get db async {
    String path = join(await getDatabasesPath(), "moneytoo_main.db");
    if (_db == null) {
      _db = DB._();
      _db!._database =
          await openDatabase(path, version: 1, onCreate: _db!._onCreate);
    }
    return _db!;
  }

  Database get database => _database!;

  FutureOr<void> _onCreate(Database db, int version) async {
    const createPropertyTable =
        """CREATE TABLE IF NOT EXISTS $tablePropertyAsset ($keyId INTEGER PRIMARY KEY,$keyAmount INTEGER, $keyTitle TEXT NOT NULL,$keyPersonalityId INTEGER NOT NULL,$keyOwnershipId INTEGER NOT NULL, $keyPurchasePrice TEXT,$keySalePrice TEXT,$keyPurchaseDate TEXT,$keyCurrentPrice TEXT,$keySaleDate TEXT,$keyProvinceId INTEGER,$keyCityId INTEGER,$keyDistrictId INTEGER,$keyMainStreet TEXT,$keyBystreet TEXT,$keyAlley TEXT ,$keyPlaque TEXT,$keyFloor INTEGER,$keyUnit INTEGER,$keyMoreDetails TEXT);""";
    const createResidentialHouse =
        """CREATE TABLE IF NOT EXISTS $tableResidentialHouseAsset ($keyId INTEGER PRIMARY KEY,$keyAmount INTEGER, $keyTitle TEXT NOT NULL,$keyPersonalityId INTEGER NOT NULL,$keyOwnershipId INTEGER NOT NULL,$keyPurchasePrice INTEGER,$keyCurrentPrice INTEGER,$keySalePrice INTEGER,$keyPurchaseDate TEXT,$keySaleDate TEXT,$keyProvinceId INTEGER,$keyCityId INTEGER,$keyDistrictId INTEGER,$keyMainStreet TEXT,$keyBystreet TEXT,$keyAlley TEXT ,$keyPlaque TEXT,$keyFloor INTEGER,$keyUnit INTEGER,$keyMoreDetails TEXT);""";
    const createGardenTable =
        """CREATE TABLE IF NOT EXISTS $tableGardenAsset($keyId INTEGER PRIMARY KEY,$keyAmount INTEGER, $keyTitle TEXT NOT NULL,$keyPersonalityId INTEGER NOT NULL,$keyOwnershipId INTEGER NOT NULL,$keySalePrice INTEGER,$keyPurchasePrice INTEGER,$keyCurrentPrice INTEGER,$keyPurchaseDate TEXT,$keySaleDate TEXT,$keyProvinceId INTEGER,$keyCityId INTEGER,$keyDistrictId INTEGER,$keyMainStreet TEXT,$keyBystreet TEXT,$keyAlley TEXT ,$keyPlaque TEXT,$keyFloor INTEGER,$keyUnit INTEGER,$keyMoreDetails TEXT);""";
    const createStockTable =
        """CREATE TABLE IF NOT EXISTS $tableStockAsset($keyId INTEGER PRIMARY KEY,$keyAmount INTEGER, $keyName TEXT NOT NULL,$keyPersonalityId INTEGER NOT NULL, $keyPurchasePrice INTEGER,$keyPurchaseDate TEXT);""";
    const createGoldTable =
        """CREATE TABLE IF NOT EXISTS $tableGoldAsset($keyId INTEGER PRIMARY KEY,$keyAmount INTEGER, $keyName TEXT NOT NULL,$keyPersonalityId INTEGER NOT NULL,$keyPurchasePrice INTEGER,$keyPurchaseDate TEXT);""";
    const createFormalCurrencyTable =
        """CREATE TABLE IF NOT EXISTS $tableFormalCurrencyAsset($keyId INTEGER PRIMARY KEY,$keyAmount INTEGER, $keyName TEXT NOT NULL,$keyPersonalityId INTEGER NOT NULL,$keyPurchasePrice INTEGER,$keyPurchaseDate TEXT);""";
    const createDigitalCurrencyTable =
        """CREATE TABLE IF NOT EXISTS $tableDigitalCurrencyAsset($keyId INTEGER PRIMARY KEY,$keyAmount INTEGER, $keyName TEXT NOT NULL,$keyPersonalityId INTEGER NOT NULL,$keyPurchasePrice INTEGER,$keyPurchaseDate TEXT);""";
    const createAssetOwnershipTable =
        """CREATE TABLE IF NOT EXISTS $tableAssetOwnership($keyId INTEGER PRIMARY KEY,$keyName TEXT NOT NULL);""";
    const createProvinceTable =
        """CREATE TABLE IF NOT EXISTS $tableProvince($keyId INTEGER PRIMARY KEY,$keyName TEXT NOT NULL);""";
    const createCityTable =
        """CREATE TABLE IF NOT EXISTS $tableCity($keyId INTEGER PRIMARY KEY,$keyName TEXT NOT NULL);""";
    const createDistrictTable =
        """CREATE TABLE IF NOT EXISTS $tableDistrict($keyId INTEGER PRIMARY KEY,$keyName TEXT NOT NULL);""";

    await db.execute(createPropertyTable);
    await db.execute(createResidentialHouse);
    await db.execute(createGardenTable);
    await db.execute(createStockTable);
    await db.execute(createGoldTable);
    await db.execute(createDigitalCurrencyTable);
    await db.execute(createFormalCurrencyTable);
    await db.execute(createAssetOwnershipTable);
    await db.execute(createProvinceTable);
    await db.execute(createCityTable);
    await db.execute(createDistrictTable);
    // await db.execute("""
// $createPropertyTable\n
// $createResidentialHouse\n
// $createGardenTable\n
// $createStockTable\n
// $createGoldTable\n
// $createDigitalCurrencyTable\n
// $createFormalCurrencyTable\n
// $createAssetOwnershipTable\n
// $createProvinceTable\n
// $createCityTable\n
// $createDistrictTable
//             """);
  }
}
