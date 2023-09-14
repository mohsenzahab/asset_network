import '../../../domain/entities/stock/stock_basket_info.dart';

class StockBasketInfoModel extends StockBasketInfo {
  StockBasketInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
    totalValue = json['total_value'];
    createTime = json['create_time'];
    lastEvaluationTime = json['last_evaluation_time'];
    isShareable = json['is_shareable'];
    itemCount = json['item_count'];
    expirationDate = json['expiration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Name'] = name;
    data['total_value'] = totalValue;
    data['create_time'] = createTime;
    data['last_evaluation_time'] = lastEvaluationTime;
    data['is_shareable'] = isShareable;
    data['item_count'] = itemCount;
    data['expiration_date'] = expirationDate;
    return data;
  }
}
