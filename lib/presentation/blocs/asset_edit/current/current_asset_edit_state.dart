part of 'current_asset_edit_cubit.dart';

class CurrentAssetEditState extends BlocState {
  const CurrentAssetEditState(super.status, {super.message});
  @override
  List<Object?> get props => [status, message];

  /// returns a new [CurrentAssetEditState] with this states data but
  /// replaced with provided values
  @override
  CurrentAssetEditState copyWith(BlocStatus status,
          {String? message,
          int? errCode,
          StockBasket? stockBasket,
          Asset? asset}) =>
      CurrentAssetEditState(status, message: message);
}
