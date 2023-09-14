import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabad_darai/domain/entities/asset/current_asset/digital_currency.dart';
import 'package:sabad_darai/domain/entities/asset/current_asset/formal_currency.dart';
import 'package:sabad_darai/domain/entities/asset/current_asset/gold_asset.dart';
import 'package:sabad_darai/domain/entities/asset/current_asset/stock_asset.dart';
import '../../../core/bloc/state.dart';
import '../../../core/enums/asset_category.dart';
import '../../../core/utils/validator.dart';
import '../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../app/bloc/app_bloc.dart';
import '../../blocs/asset_edit/current/current_asset_edit_cubit.dart';
import '../../blocs/current_asset_form_cubit.dart/current_asset_form_cubit.dart';
import '../../widgets/form/custom_form_fields/number_form_field.dart';
import '../../widgets/form/form.dart';
import '../../widgets/info/info_horizontal.dart';
import '../../../../config/values/layout.dart';
import '../../../../core/enums/personality.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/messenger.dart';
import '../../../../locator.dart';

class CurrentAssetEditScreen extends StatefulWidget {
  const CurrentAssetEditScreen({super.key, required this.asset});

  final CurrentAsset asset;

  @override
  State<CurrentAssetEditScreen> createState() => _CurrentAssetEditScreenState();
}

class _CurrentAssetEditScreenState extends State<CurrentAssetEditScreen> {
  late final GlobalKey<FormState> formKey;
  bool isChanged = false;

  int? count;
  int? price;
  Personality? personality;
  DateTime? date;

  CurrentAsset get asset => widget.asset;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    setInitialValues();
    super.initState();
  }

  void setInitialValues() {
    count = asset.amount;
    price = asset.purchasePrice;
    personality = asset.personality;
    date = asset.purchaseDate;
  }

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    final c = sl<IColors>();
    final appData = BlocProvider.of<AppBloc>(context).state;

    return Scaffold(
      appBar: AppBar(
          title:
              Text('${l('title_asset_info')} ${l(widget.asset.type.textId)}'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: kSizeIcon,
              )),
          actions: [
            IconButton(
                color: c('iconDone'),
                onPressed: () => saveChanges(context),
                icon: const Icon(
                  Icons.done,
                  size: kSizeIcon,
                ))
          ]),
      body: BlocListener<CurrentAssetFormCubit, CurrentAssetFormState>(
          listener: (context, state) {
            if (state.status == BlocStatus.failure) {
              Messenger(context, l)
                  .showSnackBarFailure(state.message ?? 'Somethings wrong');
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              onChanged: () => isChanged = true,
              onWillPop: () async {
                if (isChanged) {
                  //todo: show a message
                  // return false;
                }
                return true;
              },
              child: Column(
                children: [
                  InfoHorizontal(
                      title: l('stock_name'), value: widget.asset.title),
                  kSpaceVertical16,
                  ChoiceChips<Personality>(
                    title: l('personality'),
                    initialValue: widget.asset.personality,
                    choices: const [Personality.private, Personality.juridical],
                    asString: (personality) => l(personality.name),
                    onSelected: (selectedItem) {
                      if (selectedItem == Personality.juridical) return false;
                      personality = selectedItem;
                      return true;
                    },
                  ),
                  kSpaceVertical16,
                  Row(
                    children: [
                      Expanded(
                        child: NumberFormField(
                          label: l('count'),
                          initialValue: count,
                          validator: (count) =>
                              Validator.requiredNumericValidate(
                                  count, 'validate_count'),
                          onSaved: (newValue) => count = newValue,
                        ),
                      ),
                      kSpaceHorizontal16,
                      Expanded(
                          child: NumberFormField(
                        label: l('each_stock_price',
                            ['(${l(appData.mainPreferredCurrency.name)})']),
                        initialValue: price,
                        hint: l(
                          'price',
                          ['(${l(appData.mainPreferredCurrency.name)})'],
                        ),
                        validator: (str) => Validator.requiredNumericValidate(
                            str, 'validate_price'),
                        onSaved: (newValue) => price = newValue,
                      )),
                    ],
                  ),
                  kSpaceHorizontal32,
                  DatePickerFormField(
                    title: l('purchase_date'),
                    initialValue: date,
                    calendar: appData.calendar,
                    onChanged: (date) => this.date = date,
                    validator: (value) {
                      if (value == null) {
                        return l('validate_date');
                      }
                      return null;
                    },
                  ),
                  kSpaceVertical32,
                ],
              ),
            ),
          )),
    );
  }

  void saveChanges(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    late final CurrentAsset editedAsset;
    switch (asset.type) {
      case AssetCategory.stock:
        editedAsset = StockAsset(
            id: asset.id,
            title: asset.title,
            amount: count!,
            personality: personality!,
            purchasePrice: price,
            purchaseDate: date);
        break;
      case AssetCategory.gold:
        editedAsset = GoldAsset(
            id: asset.id,
            title: asset.title,
            amount: count!,
            personality: personality!,
            purchasePrice: price,
            purchaseDate: date);
        break;
      case AssetCategory.formalCurrency:
        editedAsset = FormalCurrency(
            id: asset.id,
            title: asset.title,
            amount: count!,
            personality: personality!,
            purchasePrice: price,
            purchaseDate: date);
        break;
      case AssetCategory.digitalCurrency:
        editedAsset = DigitalCurrency(
            id: asset.id,
            title: asset.title,
            amount: count!,
            personality: personality!,
            purchasePrice: price,
            purchaseDate: date);
        break;
      default:
    }
    final editCubit = BlocProvider.of<CurrentAssetEditCubit>(context);

    editCubit.updateCurrentAsset(editedAsset).then((isSuccess) {
      if (isSuccess) {
        Navigator.pop(context, editedAsset);
      }
    });
  }
}
