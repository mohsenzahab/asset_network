import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/bloc/state.dart';
import '../../../../core/error/failures.dart';
import '../../../../domain/entities/asset/asset.dart';
import '../../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../../../domain/entities/stock/stock_basket.dart';
import '../../../../domain/usecases/baskets/asset_basket/edit_current_asset.dart';
part 'current_asset_edit_state.dart';

/// Controls the ui logic related to asset basket
class CurrentAssetEditCubit extends Cubit<CurrentAssetEditState> {
  final EditCurrentAssetUsecase editCurrentAsset;

  CurrentAssetEditCubit(this.editCurrentAsset)
      : super(const CurrentAssetEditState(BlocStatus.ready));

  Future<bool> updateCurrentAsset(CurrentAsset asset) {
    return editCurrentAsset(EditCurrentAssetParams(asset))
        .then((result) => _handleOnEditResult(result, asset));
  }

  FutureOr<bool> _handleOnEditResult(
      Either<Failure, bool> result, Asset asset) {
    return result.fold((l) {
      emit(state.copyWith(BlocStatus.failure,
          message: 'message_edit_asset_fail'));
      emit(state.copyWith(
        BlocStatus.ready,
      ));
      return false;
    }, (r) {
      if (!r) {
        emit(state.copyWith(BlocStatus.failure,
            message: 'message_edit_asset_fail'));
        emit(state.copyWith(
          BlocStatus.ready,
        ));
      }
      return r;
    });
  }
}
