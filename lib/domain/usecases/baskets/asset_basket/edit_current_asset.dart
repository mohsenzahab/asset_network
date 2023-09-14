import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../repositories/basket_repository.dart';
import '../../../entities/asset/current_asset/current_asset.dart';

class EditCurrentAssetUsecase extends UseCase<bool, EditCurrentAssetParams> {
  EditCurrentAssetUsecase(this.basketRepository);
  final BasketRepository basketRepository;

  @override
  Future<Either<Failure, bool>> call(EditCurrentAssetParams params) =>
      basketRepository.editCurrentAsset(params);
}

class EditCurrentAssetParams {
  EditCurrentAssetParams(this.asset);
  final CurrentAsset asset;
}
