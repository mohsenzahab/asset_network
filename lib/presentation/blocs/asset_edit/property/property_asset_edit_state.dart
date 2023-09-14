part of 'property_asset_edit_cubit.dart';

class PropertyAssetEditState extends BlocState {
  const PropertyAssetEditState(super.status, {super.message});
  @override
  List<Object?> get props => [status, message];

  /// returns a new [PropertyAssetEditState] with this states data but
  /// replaced with provided values
  @override
  PropertyAssetEditState copyWith(BlocStatus status,
          {String? message,
          int? errCode,
          StockBasket? stockBasket,
          Asset? asset}) =>
      PropertyAssetEditState(status, message: message);
}
