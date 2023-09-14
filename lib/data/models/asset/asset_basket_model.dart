import '../../../domain/entities/stock/stock_basket.dart';
import '../../../domain/entities/stock/stock_basket_his.dart';
import 'asset_basket_his_model.dart';
import 'asset_basket_info_model.dart';

class AssetBasketModel extends StockBasket {
  AssetBasketModel({
    required super.info,
    super.oneWeekProfit,
    required double? oneMonthProfit,
    required double? threeMonthsProfit,
    required int? totalValueUSD,
    required int? totalValueCHF,
    required int? totalValue,
    required List<StockBasketHistory>? history,
  });

  AssetBasketModel.fromJson(Map<String, dynamic> json)
      : super(
            info: AssetBasketInfoModel.fromJson(json['info']),
            oneWeekProfit: json['one_week_profit'],
            oneMonthProfit: json['one_month_profit'],
            threeMonthsProfit: json['three_months_profit'],
            totalValueUSD: json['total_value_USD'],
            totalValueCHF: json['total_value_CHF'],
            totalValue: json['total_value'],
            history: json['history'] != null
                ? (json['history'] as List).fold<List<AssetBasketHistoryModel>>(
                    [], (v, de) => v..add(AssetBasketHistoryModel.fromJson(de)))
                : <StockBasketHistory>[]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['info'] = (info as AssetBasketInfoModel).toJson();
    data['one_week_profit'] = oneWeekProfit;
    data['one_month_profit'] = oneMonthProfit;
    data['three_months_profit'] = threeMonthsProfit;
    data['total_value_USD'] = totalValueUSD;
    data['total_value_CHF'] = totalValueCHF;
    data['total_value'] = totalValue;
    data['history'] = (history.cast<AssetBasketHistoryModel>())
        .map((v) => v.toJson())
        .toList();
    return data;
  }
}
