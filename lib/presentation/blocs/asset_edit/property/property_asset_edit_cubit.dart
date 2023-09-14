import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:sabad_darai/domain/entities/asset/fixed_asset/property.dart';
import '../../../../core/bloc/state.dart';
import '../../../../core/enums/register_type.dart';
import '../../../../core/error/failures.dart';
import '../../../../domain/entities/asset/asset.dart';
import '../../../../domain/entities/asset/fixed_asset/fixed_asset.dart';
import '../../../../domain/entities/stock/stock_basket.dart';
import '../../../../domain/usecases/baskets/asset_basket/edit_fixed_asset.dart';
part 'property_asset_edit_state.dart';

/// Controls the ui logic related to asset basket
class PropertyAssetEditCubit extends Cubit<PropertyAssetEditState> {
  final EditFixedAssetUsecase editFixedAsset;

  PropertyAssetEditCubit(this.editFixedAsset)
      : super(const PropertyAssetEditState(BlocStatus.ready));

  RegisterType? registerType;

  Future<bool> updateFixedAsset(FixedAsset asset) {
    return editFixedAsset(EditFixedAssetParams(asset))
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
