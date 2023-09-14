part of 'fixed_asset_form_cubit.dart';

class FixedAssetFormState extends BlocState {
  FixedAssetFormState(
    super.status, {
    super.message,
    this.asset,
    FixedAssetFormData? data,
    // TextEditingController? ownershipText,
    // TextEditingController? provinceController,
    // TextEditingController? cityController,
    // TextEditingController? districtController,
  }) : data = data ?? FixedAssetFormData.empty()
  //  : ownershipController = ownershipText ?? TextEditingController(),
  //       provinceController = provinceController ?? TextEditingController(),
  //       cityController = cityController ?? TextEditingController(),
  //       districtController = districtController ?? TextEditingController()
  ;

  // final TextEditingController ownershipController;
  // final TextEditingController provinceController;
  // final TextEditingController cityController;
  // final TextEditingController districtController;
  final FixedAssetFormData data;
  final FixedAsset? asset;

  @override
  List<Object?> get props => [status, message];

  @override
  FixedAssetFormState copyWith(
    BlocStatus status, {
    String? message,
    FixedAssetFormData? data,
    FixedAsset? asset,
  }) =>
      FixedAssetFormState(status,
          message: message, data: data ?? this.data, asset: asset
          // ownershipText: ownershipController,
          // provinceController: provinceController,
          // cityController: cityController,
          // districtController: districtController,
          );
}
