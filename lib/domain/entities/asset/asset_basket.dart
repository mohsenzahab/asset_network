import 'asset_basket_his.dart';
import 'asset_basket_info.dart';

class AssetBasket {
  AssetBasketInfo info;
  double? oneWeekProfit;
  double? oneMonthProfit;
  double? threeMonthsProfit;
  int? totalValueUSD;
  int? totalValueCHF;
  int? totalValue;
  List<AssetBasketHistory> history;

  AssetBasket(
      {required this.info,
      this.oneWeekProfit,
      this.oneMonthProfit,
      this.threeMonthsProfit,
      this.totalValueUSD,
      this.totalValueCHF,
      this.totalValue,
      this.history = const []});
}
