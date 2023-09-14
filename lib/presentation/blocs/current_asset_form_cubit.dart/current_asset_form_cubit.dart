import 'dart:async';

import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../core/enums/personality.dart';
import '../../../core/utils/api_data.dart';
import '../../../core/utils/common.dart';
import '../../../domain/entities/asset/current_asset/stock_asset.dart';
import '../../../domain/usecases/current_asset_form/save_current_asset.dart';
import '../../../domain/usecases/search_stock.dart';
import '../../../../core/bloc/state.dart';
import '../../../../core/enums/asset_category.dart';
import '../../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../../../domain/entities/asset/current_asset/digital_currency.dart';
import '../../../../domain/entities/asset/current_asset/formal_currency.dart';
import '../../../../domain/entities/asset/current_asset/gold_asset.dart';
import '../../../../domain/entities/stock/cgs/stock.dart';

part 'current_asset_form_state.dart';
part 'current_asset_form_data.dart';

class CurrentAssetFormCubit extends Cubit<CurrentAssetFormState> {
  CurrentAssetFormCubit(
      this.saveCurrentAsset, this.searchStockUsecase, this.apiData,
      {required this.assetType})
      : formKey = GlobalKey<FormState>(),
        super(CurrentAssetFormState(BlocStatus.empty));

  final GlobalKey<FormState> formKey;
  final SearchStock searchStockUsecase;
  final SaveCurrentAsset saveCurrentAsset;
  final ApiData apiData;
  final AssetCategory assetType;

  /// For search string grater than 2 chars, requests a query from api
  /// and returns a list of stocks. If there is already a search, will
  /// cancel it.
  Future<List<Stock>> searchStock(String searchStr) async {
    // if (searchStr.length < 2) return [];
    // final stockSearchFuture =
    //     searchStockUsecase(SearchStockParams(searchStr)).then((value) {
    //   final result = value.fold<List<Stock>>((l) {
    //     emit(state.copyWith(BlocStatus.failure, message: l.message));
    //     emit(state.copyWith(
    //       BlocStatus.ready,
    //     ));
    //     return [];
    //   }, (r) {
    //     return r;
    //   });
    //   state.stockSearchResult!.add(result);
    // });
    // // emit(state.copyWith(BlocStatus.ready, stockSearchResult: result));
    // return state.stockSearchResult!. stream.last;
    if (state.stockSearchResult != null) {
      state.stockSearchResult!.cancel();
    }
    if (searchStr.length < 2) return [];
    final stockSearchFuture = searchStockUsecase(SearchStockParams(searchStr));
    final result =
        CancelableOperation.fromFuture(stockSearchFuture, onCancel: (() {
      log.d('future canceled');
    })).then<List<Stock>>((value) {
      return value.fold<List<Stock>>((l) {
        emit(state.copyWith(BlocStatus.failure, message: l.message));
        emit(state.copyWith(
          BlocStatus.ready,
        ));
        return [];
      }, (r) {
        return r;
      });
    });
    emit(state.copyWith(BlocStatus.ready, stockSearchResult: result));
    return result.value;
    // if (state.stockSearchResult != null) {
    //   state.stockSearchResult!.cancel();
    // }
    // if (searchStr.length < 2) return [];
    // final stockSearchStream =
    //     searchStockUsecase(SearchStockParams(searchStr)).asStream();

    // final result = stockSearchStream.listen((value) {});
    // emit(state.copyWith(BlocStatus.ready, stockSearchResult: result));

    // return stockSearchStream.first.then((value) {
    //   return value.fold<List<Stock>>((l) {
    //     emit(state.copyWith(BlocStatus.failure, message: l.message));
    //     emit(state.copyWith(
    //       BlocStatus.ready,
    //     ));
    //     return [];
    //   }, (r) {
    //     return r;
    //   });
    // });
  }

  /// Saves the selected stock and refreshes the state.
  void onStockSelected(Stock? selectedItem) {
    emit(state.copyWith(BlocStatus.ready, selectedStock: selectedItem));
  }

  /// Parses and saves the string value as count
  void setCount(int? count) {
    state.formValues.count = count;
  }

  /// Parses and saves the string value as price
  void setPrice(int? price) => state.formValues.count = price;

  /// Removes the selected stock after changing search text if any stock
  /// is selected;
  void onStockChanged(String? value) {
    if (value != state.selectedStock?.name) {
      log.d('stock changed');
      emit(state.copyWith(BlocStatus.empty).clearStock());
    }
  }

  /// Checks if the personality is selectable or not.
  /// returns false if not.
  bool? onPersonalitySelected(Personality selectedItem) {
    if (selectedItem == Personality.juridical) {
      emit(state.copyWith(BlocStatus.ready,
          selectedStock: state.selectedStock,
          message: 'message_under_developing_feature'));
      // emit(state.copyWith(BlocStatus.ready, message: null));
      return false;
    }
    state.formValues.personality = selectedItem;
    return true;
  }

  void registerPurchase() {
    // todo: not fully implemented
    saveData();
  }

  void registerSale() {
    // todo: not fully implemented
    saveData();
  }

  void saveData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final asset = _createAsset();
      if (asset == null) return;
      saveCurrentAsset(SaveCurrentAssetParams(asset, assetType)).then(
          (result) => result.fold(
              (l) => emit(state.copyWith(BlocStatus.failure,
                  message: 'message_register_failure')),
              (r) => emit(state.copyWith(BlocStatus.success,
                  asset: r, message: 'message_register_success'))));
    }
  }

  String? getProfileImageUrl(Stock stock) => stock.profileImageT == null
      ? null
      : apiData.getStockProfileImageUrl(stock.profileImageT!);

  void setDate(DateTime? date) => state.formValues.date = date;

  CurrentAsset? _createAsset() {
    switch (assetType) {
      case AssetCategory.stock:
        return StockAsset(
            title: state.selectedStock!.name,
            purchaseDate: state.formValues.date!,
            amount: state.formValues.count!,
            personality: state.formValues.personality,
            purchasePrice: state.formValues.price);
      case AssetCategory.gold:
        return GoldAsset(
            title: state.selectedStock!.name,
            purchaseDate: state.formValues.date!,
            amount: state.formValues.count!,
            personality: state.formValues.personality,
            purchasePrice: state.formValues.price);
      case AssetCategory.formalCurrency:
        return FormalCurrency(
            title: state.selectedStock!.name,
            purchaseDate: state.formValues.date!,
            amount: state.formValues.count!,
            personality: state.formValues.personality,
            purchasePrice: state.formValues.price);
      case AssetCategory.digitalCurrency:
        return DigitalCurrency(
            title: state.selectedStock!.name,
            purchaseDate: state.formValues.date!,
            amount: state.formValues.count!,
            personality: state.formValues.personality,
            purchasePrice: state.formValues.price);
      default:
    }
    return null;
  }
}
