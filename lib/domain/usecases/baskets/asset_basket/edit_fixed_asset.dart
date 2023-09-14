import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../entities/asset/fixed_asset/fixed_asset.dart';
import '../../../repositories/basket_repository.dart';

class EditFixedAssetUsecase extends UseCase<bool, EditFixedAssetParams> {
  EditFixedAssetUsecase(this.basketRepository);
  final BasketRepository basketRepository;

  @override
  Future<Either<Failure, bool>> call(EditFixedAssetParams params) =>
      basketRepository.editFixedAsset(params);
}

class EditFixedAssetParams {
  EditFixedAssetParams(this.asset);
  final FixedAsset asset;
}
