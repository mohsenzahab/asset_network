part of 'asset_cubit.dart';

class AssetState extends BlocState {
  const AssetState(super.status,
      {super.message, this.stockBasket, this.assets = const []});
  final StockBasket? stockBasket;
  final List<Asset> assets;

  @override
  List<Object?> get props => [status, message, stockBasket, assets];

  /// returns a new [AssetState] with this states data but
  /// replaced with provided values
  @override
  AssetState copyWith(BlocStatus status,
          {String? message,
          int? errCode,
          StockBasket? stockBasket,
          List<Asset>? assets}) =>
      AssetState(status,
          message: message,
          stockBasket: stockBasket ?? this.stockBasket,
          assets: assets ?? this.assets);
}
