import 'package:equatable/equatable.dart';
import '../../../config/values/api_keys.dart';

/// The ownership of the asset. If its my self, my spouse etc.(Fetched form server)
class AssetOwnership extends Equatable {
  const AssetOwnership(this.id, this.title);
  final int id;
  final String title;

  @override
  List<Object> get props => [id, title];
}
