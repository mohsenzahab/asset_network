import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/state.dart';
import '../../../../core/enums/asset_category.dart';
import '../../../../core/utils/validator.dart';
import '../../../../domain/entities/asset/current_asset/current_asset.dart';
import '../../../blocs/current_asset_form_cubit.dart/current_asset_form_cubit.dart';
import '../../../widgets/form_section.dart';
import '../../../../config/values/layout.dart';
import '../../../../core/enums/personality.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/messenger.dart';
import '../../../../domain/entities/asset/asset.dart';
import '../../../../domain/entities/stock/cgs/stock.dart';
import '../../../../locator.dart';
import '../../../app/bloc/app_bloc.dart';
import '../../../widgets/form/custom_form_fields/number_form_field.dart';
import '../../../widgets/form/form.dart';

/// A form to add [CurrentAsset] type.
class CurrentAssetForm extends StatelessWidget {
  const CurrentAssetForm({super.key, required this.assetType});

  final AssetCategory assetType;
  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    final c = sl<IColors>();
    final appData = BlocProvider.of<AppBloc>(context).state;

    List<Widget> getDetailForm(
        CurrentAssetFormCubit cubit, CurrentAssetFormState state) {
      final data = state.formValues;
      return [
        kSpaceVertical16,
        ChoiceChips<Personality>(
          title: l('personality'),
          initialValue: data.personality,
          choices: const [Personality.private, Personality.juridical],
          asString: (personality) => l(personality.name),
          onSelected: cubit.onPersonalitySelected,
        ),
        kSpaceVertical16,
        Row(
          children: [
            Expanded(
              child: NumberFormField(
                  label: l('count'),
                  initialValue: data.count,
                  validator: (count) => Validator.requiredNumericValidate(
                      count, 'validate_count'),
                  onSaved: cubit.setCount),
            ),
            kSpaceHorizontal16,
            Expanded(
                child: NumberFormField(
              label: l('each_stock_price',
                  ['(${l(appData.mainPreferredCurrency.name)})']),
              initialValue: data.price,
              hint: l(
                'price',
                ['(${l(appData.mainPreferredCurrency.name)})'],
              ),
              validator: (str) =>
                  Validator.requiredNumericValidate(str, 'validate_price'),
              onSaved: cubit.setPrice,
            )),
          ],
        ),
        kSpaceHorizontal32,
        DatePickerFormField(
          title: l('purchase_date'),
          initialValue: data.date,
          calendar: appData.calendar,
          onChanged: cubit.setDate,
          validator: (value) {
            if (value == null) {
              return l('validate_date');
            }
            return null;
          },
        ),
        kSpaceVertical32,
        if (state.asset == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: cubit.registerPurchase,
                  child: Text(l('purchase'))),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: cubit.registerSale,
                  child: Text(l('sale'))),
            ],
          )
      ];
    }

    return BlocProvider<CurrentAssetFormCubit>(
      create: (_) {
        return CurrentAssetFormCubit(sl(), sl(), sl(), assetType: assetType);
      },
      lazy: true,
      child: BlocConsumer<CurrentAssetFormCubit, CurrentAssetFormState>(
        listener: (context, state) {
          if (state.status == BlocStatus.failure) {
            Messenger(context, l)
                .showSnackBarFailure(state.message ?? 'Somethings wrong');
          } else if (state.message != null &&
              state.message!.isNotEmpty &&
              state.status == BlocStatus.ready) {
            Messenger(context, l).showSnackBarInfo(l(state.message!));
          } else if (state.status == BlocStatus.success) {
            Navigator.pop<Asset>(context, state.asset);
          }
        },
        buildWhen: (previous, current) {
          return previous.formValues != current.formValues ||
              previous.selectedStock != current.selectedStock;
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<CurrentAssetFormCubit>(context);

          return Form(
            key: cubit.formKey,
            onWillPop: () async {
              // cubit.close();
              return true;
            },
            child: Column(
              children: [
                Text(
                  l('des_current_asset_form'),
                  style: TextStyle(color: c('textColorGray')),
                ),
                FormSection(
                  children: [
                    SuggestionTextField<Stock>(
                        label: l('stock_name'),
                        itemAsString: (stock) => stock.name,
                        itemSubtitle: (stock) => stock.name,
                        itemIconUrl: cubit.getProfileImageUrl,
                        onSelected: cubit.onStockSelected,
                        onChanged: cubit.onStockChanged,
                        getSuggestions: cubit.searchStock),
                    if (state.status != BlocStatus.empty)
                      ...getDetailForm(cubit, state)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
