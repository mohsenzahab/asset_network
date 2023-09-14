import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/enums/personality.dart';
import '../../../core/enums/register_type.dart';
import '../../../domain/entities/asset/ownership.dart';
import '../../../domain/entities/location/city.dart';
import '../../../domain/entities/location/district.dart';
import '../../../domain/entities/location/province.dart';
import '../../../domain/usecases/fixed_asset_form/save_fixed_asset.dart';
import '../../../../core/bloc/state.dart';
import '../../../../core/enums/asset_category.dart';
import '../../../../domain/entities/asset/fixed_asset/fixed_asset.dart';
import '../../../../domain/entities/asset/fixed_asset/garden.dart';
import '../../../../domain/entities/asset/fixed_asset/property.dart';
import '../../../../domain/entities/asset/fixed_asset/residential_house.dart';
part 'fixed_asset_form_state.dart';
part 'fixed_asset_form_data.dart';

class FixedAssetFormCubit extends Cubit<FixedAssetFormState> {
  FixedAssetFormCubit(
    this.saveFixedAsset, {
    required this.assetType,
  })  : formKey = GlobalKey<FormState>(),
        super(FixedAssetFormState(BlocStatus.empty));

  final GlobalKey<FormState> formKey;
  final AssetCategory assetType;
  final SaveFixedAsset saveFixedAsset;
  RegisterType? registerType;

  FixedAssetFormData get data => state.data;

  void saveTitle(String? newValue) => data.title = newValue;

  bool? savePersonality(Personality selectedItem) {
    if (selectedItem == Personality.juridical) {
      emit(state.copyWith(BlocStatus.ready,
          message: 'message_under_developing_feature'));
      return false;
    }
    state.data.personality = selectedItem;
    return true;
  }

  void savePurchasePrice(int? newValue) {
    if (registerType == RegisterType.purchase) {
      state.data.purchasePrice = newValue;
    }
  }

  void saveSalePrice(int? newValue) {
    if (registerType == RegisterType.sale) {
      data.salePrice = newValue;
    } else if (registerType == RegisterType.sellOrder) {
      data.currentPrice = newValue;
    }
  }

  void saveCurrentPrice(int? newValue) {
    if (registerType == RegisterType.sellOrder) {
      data.currentPrice = newValue;
    }
  }

  void savePurchaseDate(DateTime? date) {
    // if (registerType == RegisterType.purchase) {
    data.purchaseDate = date;
    // }
  }

  void saveSaleDate(DateTime? date) {
    // if (registerType == RegisterType.sale) {
    data.saleDate = date;
    // }
  }

  void saveAssetOwnership(AssetOwnership? p1) {
    data.ownership = p1;
  }

  void saveProvince(Province? p1) {
    data.province = p1;
  }

  void saveCity(City? p1) {
    data.city = p1;
  }

  void saveDistrict(District? p1) {
    data.district = p1;
  }

  void saveMainStreet(String? newValue) {
    data.mainStreet = newValue;
  }

  void saveBystreet(String? newValue) {
    data.bystreet = newValue;
  }

  void saveAlley(String? newValue) {
    data.alley = newValue;
  }

  void savePlaque(String? newValue) {
    data.plaque = newValue;
  }

  void saveFloor(int? newValue) {
    data.floor = newValue;
  }

  void saveUnit(int? newValue) {
    data.unit = newValue;
  }

  final generalFacilities = {
    'elevator': false,
    'balcony': false,
    'telephone': false,
  };
  void saveGeneralFacilities(Map<String, bool> items) {
    // todo: not implemented.
  }

  bool? saveParking(String selectedItem) {
    // todo: not implemented
  }

  bool? saveWater(String selectedItem) {
    // todo: not implemented
  }

  bool? saveGas(String selectedItem) {
    // todo: not implemented
  }

  void saveMoreDetails(String? newValue) {
    data.moreDetails = newValue;
  }

  void registerSale() {
    registerType = RegisterType.sale;
    _registerData();
  }

  void registerPurchase() {
    registerType = RegisterType.purchase;
    _registerData();
  }

  void registerSellOrder() {
    registerType = RegisterType.sellOrder;
    _registerData();
  }

  void _registerData() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    FixedAsset? asset = _createAsset();
    if (asset == null) return;
    final result = await saveFixedAsset(SaveFixedAssetParams(asset, assetType));
    result.fold((l) {
      emit(state.copyWith(BlocStatus.failure,
          message: 'message_register_failure'));
    }, (r) {
      emit(state.copyWith(BlocStatus.success,
          asset: r, message: 'message_register_success'));
    });
  }

  FixedAsset? _createAsset() {
    switch (assetType) {
      case AssetCategory.residentialHouse:
        return ResidentialHouse(
            title: data.title!,
            purchaseDate: data.purchaseDate,
            amount: 0, // todo: this was suppose to be area size
            personality: data.personality,
            ownership: data.ownership!,
            salePrice: data.salePrice,
            saleDate: data.saleDate,
            purchasePrice: data.purchasePrice,
            currentPrice: data.currentPrice,
            province: data.province!,
            city: data.city!,
            district: data.district!,
            mainStreet: data.mainStreet!,
            bystreet: data.bystreet!,
            alley: data.alley!,
            plaque: data.plaque!,
            floor: data.floor!,
            unit: data.unit!,
            moreDetails: data.moreDetails);
      case AssetCategory.property:
        return Property(
            title: data.title!,
            purchaseDate: data.purchaseDate,
            amount: 0, // todo: this was suppose to be area size
            personality: data.personality,
            ownership: data.ownership!,
            salePrice: data.salePrice,
            saleDate: data.saleDate,
            purchasePrice: data.purchasePrice,
            currentPrice: data.currentPrice,
            province: data.province!,
            city: data.city!,
            district: data.district!,
            mainStreet: data.mainStreet!,
            bystreet: data.bystreet!,
            alley: data.alley!,
            plaque: data.plaque!,
            floor: data.floor!,
            unit: data.unit!,
            moreDetails: data.moreDetails);
      case AssetCategory.garden:
        return Garden(
            title: data.title!,
            purchaseDate: data.purchaseDate,
            amount: 0, // todo: this was suppose to be area size
            personality: data.personality,
            ownership: data.ownership!,
            salePrice: data.salePrice,
            saleDate: data.saleDate,
            purchasePrice: data.purchasePrice,
            currentPrice: data.currentPrice,
            province: data.province!,
            city: data.city!,
            district: data.district!,
            mainStreet: data.mainStreet!,
            bystreet: data.bystreet!,
            alley: data.alley!,
            plaque: data.plaque!,
            floor: data.floor!,
            unit: data.unit!,
            moreDetails: data.moreDetails);
      default:
        return null;
    }
  }
}
