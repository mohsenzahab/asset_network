import '../../config/values/api_keys.dart';
import '../../core/enums/basket_type.dart';
import '../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';

import '../entities/stock/cgs/stock.dart';
import '../repositories/basket_repository.dart';

class SearchStock extends UseCase<List<Stock>, SearchStockParams> {
  final BasketRepository basketRepository;

  SearchStock(this.basketRepository);
  @override
  Future<Either<Failure, List<Stock>>> call(params) =>
      basketRepository.searchStock(params);
}

class SearchStockParams {
  SearchStockParams(this.searchStr);
  final String searchStr;

  Map<String, dynamic> toJson() => {
        keyTypeId: BasketType.stock.id,
        keySearchStr: searchStr,
      };
}
