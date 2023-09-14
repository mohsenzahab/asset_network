import '../../../config/values/api_keys.dart';
import '../../../domain/entities/location/district.dart';

class DistrictModel extends District {
  DistrictModel.fromEntity(District entity) : super(entity.id, entity.name);
  DistrictModel.fromJson(Map<String, dynamic> map)
      : super(map[keyId], map[keyName]);
  Map<String, dynamic> toJson() => {
        keyId: id,
        keyName: name,
      };
}
