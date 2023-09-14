import 'stock_basket_his.dart';
import 'stock_basket_info.dart';

class StockBasket {
  StockBasketInfo info;
  double? oneWeekProfit;
  double? oneMonthProfit;
  double? threeMonthsProfit;
  int? totalValueUSD;
  int? totalValueCHF;
  int? totalValue;
  List<StockBasketHistory> history;

  StockBasket(
      {required this.info,
      this.oneWeekProfit,
      this.oneMonthProfit,
      this.threeMonthsProfit,
      this.totalValueUSD,
      this.totalValueCHF,
      this.totalValue,
      this.history = const []});
}
