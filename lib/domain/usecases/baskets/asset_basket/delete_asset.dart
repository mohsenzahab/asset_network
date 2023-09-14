import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../../core/enums/asset_category.dart';
import '../../../entities/asset/asset.dart';
import '../../../repositories/basket_repository.dart';

class DeleteAssetUsecase extends UseCase<bool, DeleteAssetParams> {
  DeleteAssetUsecase(this.basketRepository);
  final BasketRepository basketRepository;

  @override
  Future<Either<Failure, bool>> call(DeleteAssetParams params) {
    return basketRepository.deleteAsset(params);
  }
}

class DeleteAssetParams {
  DeleteAssetParams(this.asset, this.type);
  final Asset asset;
  final AssetCategory type;
}
