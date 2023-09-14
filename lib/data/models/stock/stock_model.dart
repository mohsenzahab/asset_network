import '../../../config/values/api_keys.dart';
import '../../../core/utils/parsers.dart';

import '../../../domain/entities/stock/cgs/stock.dart';

class StockModel extends Stock {
  StockModel(
      {super.id,
      super.typeId,
      super.username,
      required super.name,
      required super.lastname,
      super.profileImageT,
      super.maxValue,
      super.minValue,
      super.namadStatus,
      required super.lastPrice});

  StockModel.fromJson(Map<String, dynamic> json)
      : super(
            id: json[keyId],
            typeId: json[keyTypeId],
            username: json[keyUsername],
            name: json[keyName],
            lastname: json[keyLastname],
            profileImageT: json[keyProfileImageT],
            maxValue: doubleParseString(json[keyMaxValue])?.toInt(),
            minValue: doubleParseString(json[keyMinValue])?.toInt(),
            namadStatus: json[keyNamadStatus],
            lastPrice: doubleParseString(json[keyLastPrice])?.toInt());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[keyId] = id;
    data[keyTypeId] = typeId;
    data[keyUsername] = username;
    data[keyName] = name;
    data[keyLastname] = lastname;
    data[keyProfileImageT] = profileImageT;
    data[keyMaxValue] = maxValue;
    data[keyMaxValue] = minValue;
    data[keyNamadStatus] = namadStatus;
    data[keyLastPrice] = lastPrice;
    return data;
  }
}
