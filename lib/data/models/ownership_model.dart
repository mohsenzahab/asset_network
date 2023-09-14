import '../../domain/entities/asset/ownership.dart';

import '../../config/values/api_keys.dart';

class AssetOwnershipModel extends AssetOwnership {
  AssetOwnershipModel.fromEntity(AssetOwnership entity)
      : super(entity.id, entity.title);
  AssetOwnershipModel.fromJson(Map<String, dynamic> map)
      : super(map[keyId], map[keyName]);

  Map<String, dynamic> toJson() => {keyId: id, keyName: title};
}
