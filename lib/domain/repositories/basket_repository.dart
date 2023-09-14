import 'package:dartz/dartz.dart';
import '../entities/asset/asset.dart';
import '../entities/asset/current_asset/current_asset.dart';
import '../usecases/baskets/asset_basket/edit_current_asset.dart';
import '../usecases/baskets/asset_basket/edit_fixed_asset.dart';
import '../usecases/baskets/create_basket.dart';
import '../usecases/current_asset_form/save_current_asset.dart';
import '../usecases/fixed_asset_form/save_fixed_asset.dart';
import '../usecases/search_stock.dart';

import '../../core/error/failures.dart';
import '../entities/asset/fixed_asset/fixed_asset.dart';
import '../entities/stock/cgs/stock.dart';
import '../usecases/baskets/asset_basket/delete_asset.dart';

abstract class BasketRepository {
  Future<Either<Failure, bool>> createBasket(BasketParams params);
  Future<Either<Failure, bool>> deleteAsset(DeleteAssetParams params);
  Future<Either<Failure, List<Stock>>> searchStock(SearchStockParams params);

  Future<Either<Failure, FixedAsset>> saveNewFixedAsset(
      SaveFixedAssetParams params);

  Future<Either<Failure, CurrentAsset>> saveNewCurrentAsset(
      SaveCurrentAssetParams params);

  Future<Either<Failure, List<Asset>>> getLocalAssets();

  Future<Either<Failure, bool>> editFixedAsset(EditFixedAssetParams params);

  Future<Either<Failure, bool>> editCurrentAsset(EditCurrentAssetParams params);
}
