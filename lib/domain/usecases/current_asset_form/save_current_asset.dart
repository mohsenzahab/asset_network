import '../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/basket_repository.dart';

import '../../../core/enums/asset_category.dart';
import '../../entities/asset/current_asset/current_asset.dart';

class SaveCurrentAsset extends UseCase<CurrentAsset, SaveCurrentAssetParams> {
  SaveCurrentAsset(this.basketRepository);
  final BasketRepository basketRepository;

  @override
  Future<Either<Failure, CurrentAsset>> call(SaveCurrentAssetParams params) {
    return basketRepository.saveNewCurrentAsset(params);
  }
}

class SaveCurrentAssetParams {
  final CurrentAsset asset;
  final AssetCategory type;

  SaveCurrentAssetParams(this.asset, this.type);
}
