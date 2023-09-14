import '../../../core/enums/asset_category.dart';
import '../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/basket_repository.dart';

import '../../entities/asset/fixed_asset/fixed_asset.dart';

class SaveFixedAsset extends UseCase<FixedAsset, SaveFixedAssetParams> {
  final BasketRepository basketRepository;

  SaveFixedAsset(this.basketRepository);
  @override
  Future<Either<Failure, FixedAsset>> call(params) =>
      basketRepository.saveNewFixedAsset(params);
}

class SaveFixedAssetParams {
  SaveFixedAssetParams(this.asset, this.assetType);
  final FixedAsset asset;
  final AssetCategory assetType;
}
