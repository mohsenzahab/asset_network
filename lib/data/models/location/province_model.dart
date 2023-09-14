import '../../../config/values/api_keys.dart';
import '../../../domain/entities/location/province.dart';

class ProvinceModel extends Province {
  ProvinceModel.fromEntity(Province entity) : super(entity.id, entity.name);
  ProvinceModel.fromJson(Map<String, dynamic> map)
      : super(map[keyId], map[keyName]);
  Map<String, dynamic> toJson() => {
        keyId: id,
        keyName: name,
      };
}
