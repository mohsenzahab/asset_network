import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/usecases/baskets/asset_basket/edit_fixed_asset.dart';
import '../../../../core/bloc/state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/entities/asset/asset.dart';
import '../../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../../../domain/entities/asset/fixed_asset/fixed_asset.dart';
import '../../../../domain/entities/stock/stock_basket.dart';
import '../../../../domain/entities/stock/stock_basket_info.dart';
import '../../../../domain/usecases/baskets/asset_basket/delete_asset.dart';
import '../../../../domain/usecases/baskets/asset_basket/edit_current_asset.dart';
import '../../../../domain/usecases/baskets/asset_basket/get_local_assets.dart';
import '../../../../domain/usecases/baskets/create_basket.dart';
part 'asset_state.dart';

/// Controls the ui logic related to asset basket
class AssetCubit extends Cubit<AssetState> {
  final CreateBasket _createBasketUsecase;
  final GetLocalAssets getLocalAssets;
  final DeleteAssetUsecase deleteAssetUsecase;

  AssetCubit(
      this._createBasketUsecase, this.getLocalAssets, this.deleteAssetUsecase)
      : super(const AssetState(BlocStatus.empty)) {
    emit(state.copyWith(BlocStatus.loading));
    getLocalAssets(NoParams()).then((result) => result.fold(
        (l) => emit(state.copyWith(BlocStatus.failure,
            message: 'message_local_failure')),
        (r) => emit(state.copyWith(BlocStatus.ready, assets: r))));
    _fetchBasket().then((basket) {
      emit(state.copyWith(BlocStatus.success, stockBasket: basket));
    });
  }

  /// Create a new basket. If there is an error, emits failure status
  Future<void> createBasket(BasketParams params) async {
    emit(state.copyWith(BlocStatus.loading));
    _createBasketUsecase(params).then((result) => {
          result.fold(
            _handleCreateBasketFailure,
            _handleCreateBasketResult,
          )
        });
  }

  void _handleCreateBasketResult(result) async {
    // if basket created successfully and is_done is true.
    if (result) {
      // Get created from data base
      final basket = await _fetchBasket();
      emit(state.copyWith(BlocStatus.success,
          message: 'message_create_basket_success', stockBasket: basket));
      // this could not happen but it is checked to make sure.
    } else {
      emit(
          state.copyWith(BlocStatus.failure, message: 'message_unknown_error'));
    }
  }

  void _handleCreateBasketFailure(error) {
    // when any of error types happens
    emit(state.copyWith(BlocStatus.failure,
        message: 'message_create_basket_fail'));
  }

  /// Fetch asset basket from api
  Future<StockBasket> _fetchBasket() async {
    // fake data
    return await Future.delayed(
        const Duration(milliseconds: 500),
        () => StockBasket(
              info: StockBasketInfo(
                name: 'test basket',
              ),
            ));
  }

  void addAsset(Asset asset) {
    // state.assets.add(asset);

    emit(state.copyWith(BlocStatus.success,
        message: 'message_create_asset_success',
        assets: [...state.assets, asset]));
  }

  Future<bool> deleteAsset(Asset asset) {
    return deleteAssetUsecase(DeleteAssetParams(asset, asset.type))
        .then((result) => result.fold((l) {
              emit(state.copyWith(BlocStatus.failure,
                  message: 'message_delete_asset_fail'));
              return false;
            }, (r) {
              if (r) {
                emit(state.copyWith(BlocStatus.success,
                    message: 'message_delete_asset_success',
                    assets: state.assets.toList()..remove(asset)));
              } else {
                emit(state.copyWith(BlocStatus.failure,
                    message: 'message_delete_asset_fail'));
              }
              return r;
            }));
  }

  void updateAsset(Asset asset) {
    final newList = state.assets.toList();
    debugPrint(asset.runtimeType.toString());
    debugPrint(asset.id.toString());
    debugPrint(newList[2].runtimeType.toString());
    final index = newList.indexWhere(
        (element) => element.id == asset.id && asset.type == element.type);
    newList.replaceRange(index, index + 1, [asset]);

    emit(state.copyWith(
      BlocStatus.success,
      message: 'message_edit_asset_success',
      assets: newList,
    ));
  }
}
