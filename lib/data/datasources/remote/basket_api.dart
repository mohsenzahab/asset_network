import '../../../core/error/error_handler.dart';
import '../../../core/utils/api_data.dart';
import '../../../core/utils/common.dart';
import 'services/dio_client.dart';
import '../../../domain/usecases/baskets/create_basket.dart';

import '../../../config/values/api_keys.dart';
import '../../../domain/entities/stock/cgs/stock.dart';
import '../../../domain/usecases/search_stock.dart';
import '../../models/stock/stock_model.dart';

abstract class BasketProvider {
  Future<bool> createBasket(BasketParams params);
  Future getUserBalance(String userProfileId);
  Future<List<Stock>> searchStock(SearchStockParams params);
  Future getBaskets(String userProfileId);
  Future addItemToPrivateBasket(String namadId, String orderPrice, int count);
  Future setBasketItemPrice(String basketId, String currentPrice);
}

class BasketProviderImpl extends BasketProvider {
  BasketProviderImpl(this.apiData);
  final ApiData apiData;

  @override
  Future addItemToPrivateBasket(String namadId, String orderPrice, int count) {
    // TODO: implement addItemToPrivateBasket
    throw UnimplementedError();
  }

  @override
  Future<bool> createBasket(BasketParams params) async {
    final response = await handleServerRequest(() async {
      return DioClient(apiData)
          .post('users/users_create_basket', body: params.toJson());
    });
    return response.data![keyIsDone];
  }

  @override
  Future getBaskets(String userProfileId) {
    // TODO: implement getBaskets
    throw UnimplementedError();
  }

  @override
  Future getUserBalance(String userProfileId) {
    // TODO: implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<List<Stock>> searchStock(SearchStockParams params) async {
    log.d('api search');
    final response = await handleServerRequest(() async {
      return DioClient(apiData)
          .post('users/users_search_stock', body: params.toJson());
    });
    final List results = response.data![keyInformation];
    List<Stock> stocks = [];
    for (final map in results) {
      stocks.add(StockModel.fromJson(map));
    }
    return stocks;
  }

  @override
  Future setBasketItemPrice(String basketId, String currentPrice) {
    // TODO: implement setBasketItemPrice
    throw UnimplementedError();
  }
}
