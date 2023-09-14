part of 'current_asset_form_cubit.dart';

class CurrentAssetFormState extends BlocState {
  CurrentAssetFormState(super.status,
      {super.message,
      this.asset,
      this.selectedStock,
      this.stockSearchResult,
      CurrentAssetFormValues? formValues})
      : formValues = formValues ?? CurrentAssetFormValues();

  @override
  List<Object?> get props => [status, message, selectedStock];
  final Stock? selectedStock;
  final CurrentAssetFormValues formValues;
  final CurrentAsset? asset;
  final CancelableOperation<List<Stock>>? stockSearchResult;

  @override
  CurrentAssetFormState copyWith(BlocStatus status,
          {String? message,
          Stock? selectedStock,
          CurrentAsset? asset,
          CurrentAssetFormValues? formValues,
          CancelableOperation<List<Stock>>? stockSearchResult}) =>
      CurrentAssetFormState(status,
          message: message,
          asset: asset,
          selectedStock: selectedStock ?? this.selectedStock,
          formValues: formValues ?? this.formValues,
          stockSearchResult: stockSearchResult);

  CurrentAssetFormState clearStock() => CurrentAssetFormState(status,
      formValues: formValues, message: message, selectedStock: null);

  /// Returns a new state with previous values and empty message;
  CurrentAssetFormState setReady() => CurrentAssetFormState(BlocStatus.ready,
      formValues: formValues, selectedStock: selectedStock);

  @override
  String toString() => '$status $message $selectedStock';
}
