class AssetBasketInfo {
  int? iD;
  String name;
  int? totalValue;
  String? createTime;
  String? lastEvaluationTime;
  bool? isShareable;
  int? itemCount;
  String? expirationDate;

  AssetBasketInfo(
      {this.iD,
      // todo: remove default value if name required
      this.name = '',
      this.totalValue,
      this.createTime,
      this.lastEvaluationTime,
      this.isShareable,
      this.itemCount,
      this.expirationDate});
}
