class StockBasketHistory {
  int? id;
  int? balance;
  double? dailyProfit;
  String? insertTime;
  int? totalValue;
  int? totalValueCHF;
  int? totalValueUSD;

  StockBasketHistory(
      {this.id,
      this.balance,
      this.dailyProfit,
      this.insertTime,
      this.totalValue,
      this.totalValueCHF,
      this.totalValueUSD});
}
