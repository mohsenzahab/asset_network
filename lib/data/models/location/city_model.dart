import '../../../config/values/api_keys.dart';
import '../../../domain/entities/location/city.dart';

class CityModel extends City {
  CityModel.fromEntity(City entity) : super(entity.id, entity.name);
  CityModel.fromJson(Map<String, dynamic> map)
      : super(map[keyId], map[keyName]);
  Map<String, dynamic> toJson() => {
        keyId: id,
        keyName: name,
      };
}
