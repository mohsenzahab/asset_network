// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sabad_darai/config/values/api_keys.dart';
import 'package:sabad_darai/core/error/failures.dart';
import 'package:sabad_darai/core/usecase/usecase.dart';
import 'package:sabad_darai/domain/repositories/basket_repository.dart';

import '../../../core/enums/basket_type.dart';

class CreateBasket extends UseCase<bool, BasketParams> {
  CreateBasket(this.basketRepository);
  final BasketRepository basketRepository;

  @override
  Future<Either<Failure, bool>> call(BasketParams params) =>
      basketRepository.createBasket(params);
}

class BasketParams {
  BasketParams({
    required this.type,
    required this.basketBalance,
    required this.name,
  });
  final BasketType type;
  final int basketBalance;
  final String name;

  Map<String, dynamic> toJson() => {
        keyName: name,
        keyBasketBalance: basketBalance.toString(),
        keyTypeId: type.id.toString()
      };
}
