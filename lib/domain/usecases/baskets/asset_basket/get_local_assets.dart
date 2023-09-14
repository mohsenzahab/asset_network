import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../entities/asset/asset.dart';
import '../../../repositories/basket_repository.dart';

class GetLocalAssets extends UseCase<List<Asset>, NoParams> {
  final BasketRepository basketRepository;

  GetLocalAssets(this.basketRepository);
  @override
  Future<Either<Failure, List<Asset>>> call(NoParams params) =>
      basketRepository.getLocalAssets();
}
