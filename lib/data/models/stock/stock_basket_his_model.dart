import '../../../domain/entities/stock/stock_basket_his.dart';

class StockBasketHistoryModel extends StockBasketHistory {
  StockBasketHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    balance = json['balance'];
    dailyProfit = json['daily_profit'];
    insertTime = json['insert_time'];
    totalValue = json['total_value'];
    totalValueCHF = json['total_value_CHF'];
    totalValueUSD = json['total_value_USD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['balance'] = balance;
    data['daily_profit'] = dailyProfit;
    data['insert_time'] = insertTime;
    data['total_value'] = totalValue;
    data['total_value_CHF'] = totalValueCHF;
    data['total_value_USD'] = totalValueUSD;
    return data;
  }
}
