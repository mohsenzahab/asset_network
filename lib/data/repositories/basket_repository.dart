import '../../core/error/exception_handler.dart';
import '../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../datasources/local/asset_provider.dart';
import '../datasources/remote/basket_api.dart';
import '../../domain/entities/asset/asset.dart';
import '../../domain/entities/asset/current_asset/current_asset.dart';
import '../../domain/entities/asset/fixed_asset/fixed_asset.dart';
import '../../domain/entities/stock/cgs/stock.dart';
import '../../domain/repositories/basket_repository.dart';
import '../../domain/usecases/baskets/asset_basket/delete_asset.dart';
import '../../domain/usecases/baskets/asset_basket/edit_fixed_asset.dart';
import '../../domain/usecases/baskets/create_basket.dart';
import '../../domain/usecases/current_asset_form/save_current_asset.dart';
import '../../domain/usecases/fixed_asset_form/save_fixed_asset.dart';
import '../../domain/usecases/search_stock.dart';

import '../../domain/usecases/baskets/asset_basket/edit_current_asset.dart';

class BasketRepositoryImpl extends BasketRepository {
  BasketRepositoryImpl(this.basketProvider, this.assetLocalProvider);
  final BasketProviderImpl basketProvider;
  final AssetLocalProviderImpl assetLocalProvider;

  @override
  Future<Either<Failure, bool>> createBasket(BasketParams params) =>
      handleExceptionsAsync<bool>(
          () async => basketProvider.createBasket(params));

  @override
  Future<Either<Failure, List<Stock>>> searchStock(SearchStockParams params) =>
      handleExceptionsAsync<List<Stock>>(
        () => basketProvider.searchStock(params),
      );

  @override
  Future<Either<Failure, FixedAsset>> saveNewFixedAsset(
          SaveFixedAssetParams params) =>
      handleExceptionsAsync<FixedAsset>(
        () => assetLocalProvider.saveFixedAsset(params),
      );

  @override
  Future<Either<Failure, CurrentAsset>> saveNewCurrentAsset(
          SaveCurrentAssetParams params) =>
      handleExceptionsAsync<CurrentAsset>(
        () => assetLocalProvider.saveCurrentAsset(params),
      );

  @override
  Future<Either<Failure, List<Asset>>> getLocalAssets() =>
      handleExceptionsAsync<List<Asset>>(
        () => assetLocalProvider.getAssets(),
      );

  @override
  Future<Either<Failure, bool>> deleteAsset(DeleteAssetParams params) =>
      handleExceptionsAsync<bool>(
        () => assetLocalProvider.deleteAsset(params),
      );

  @override
  Future<Either<Failure, bool>> editFixedAsset(EditFixedAssetParams params) =>
      handleExceptionsAsync<bool>(
        () => assetLocalProvider.editFixedAsset(params),
      );
  @override
  Future<Either<Failure, bool>> editCurrentAsset(
          EditCurrentAssetParams params) =>
      handleExceptionsAsync<bool>(
        () => assetLocalProvider.editCurrentAsset(params),
      );
}
