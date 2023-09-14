// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'current_asset_form_cubit.dart';

class CurrentAssetFormValues extends Equatable {
  CurrentAssetFormValues(
      {this.count,
      this.price,
      this.personality = Personality.private,
      this.date});
  CurrentAssetFormValues.fromAsset(CurrentAsset asset)
      : personality = asset.personality,
        count = asset.amount,
        // todo: make all price fields integers
        price = asset.purchasePrice,
        date = asset.purchaseDate;

  int? count;
  int? price;
  Personality personality;
  DateTime? date;

  @override
  List<Object?> get props => [count, price, personality, date];
}
