import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/values/styles.dart';
import '../../../../core/enums/asset_category.dart';
import '../../../../core/enums/register_type.dart';
import '../../../../core/utils/messenger.dart';
import '../../../../core/utils/validator.dart';
import '../../../../domain/entities/asset/ownership.dart';
import '../../../blocs/fixed_asset_form_cubit/fixed_asset_form_cubit.dart';
import '../../../widgets/form/custom_form_fields/multiline_text_form_field.dart';
import '../../../widgets/info/multiline_text.dart';
import '../../../../config/values/layout.dart';
import '../../../../core/bloc/state.dart';
import '../../../../core/enums/personality.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../core/utils/colors.dart';
import '../../../../domain/entities/asset/asset.dart';
import '../../../../domain/entities/location/location.dart';
import '../../../../locator.dart';
import '../../../app/bloc/app_bloc.dart';
import '../../../widgets/form/custom_form_fields/number_form_field.dart';
import '../../../widgets/form/form.dart';
import '../../../widgets/form_section.dart';

/// Fixed assets like house, property, car etc;
class FixedAssetForm extends StatelessWidget {
  const FixedAssetForm({super.key, required this.assetType});
  final AssetCategory assetType;

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    final suggestions = <AssetOwnership>[
      AssetOwnership(1, 'me'),
      AssetOwnership(2, 'spouse'),
      AssetOwnership(3, 'son'),
      AssetOwnership(4, 'doughter'),
      AssetOwnership(5, 'father'),
    ];

    return BlocProvider<FixedAssetFormCubit>(
      create: (_) => FixedAssetFormCubit(sl(), assetType: assetType),
      // lazy: true,
      child: BlocConsumer<FixedAssetFormCubit, FixedAssetFormState>(
        listener: (context, state) {
          switch (state.status) {
            case BlocStatus.success:
              if (state.asset != null) {
                // Messenger(context, l).showSnackBarSuccess(state.message!);
                Navigator.pop<Asset>(context, state.asset);
              }
              break;
            case BlocStatus.ready:
              if (state.message != null) {
                Messenger(context, l).showSnackBarInfo(state.message);
              }
              break;
            case BlocStatus.failure:
              Messenger(context, l).showSnackBarFailure(state.message);
              break;

            default:
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<FixedAssetFormCubit>(context);
          final appData = BlocProvider.of<AppBloc>(context).state;

          final c = sl<IColors>();
          final data = state.data;
          // todo: on validate scroll to errors
          return Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MultilineTextInfo(
                  l('noteAssetForm'),
                  color: c('textColorGray'),
                ),
                FormSection(
                  alignment: CrossAxisAlignment.start,
                  children: [
                    MTextFormField(
                        initialValue: data.title,
                        label: l('title_asset_registration'),
                        onSaved: cubit.saveTitle,
                        validator: (value) => Validator.requiredValidate(
                            value, l('validate_title'))),
                    kSpaceVertical16,
                    ChoiceChips<Personality>(
                      title: l('personality'),
                      initialValue: data.personality,
                      choices: const [
                        Personality.private,
                        Personality.juridical,
                      ],
                      asString: (personality) => l(personality.name),
                      onSelected: cubit.savePersonality,
                    ),
                    kSpaceVertical16,
                    Row(
                      children: [
                        Expanded(
                          child: NumberFormField(
                            label: l('purchase_price',
                                ['(${l(appData.mainPreferredCurrency.name)})']),
                            initialValue: data.purchasePrice,
                            onSaved: cubit.savePurchasePrice,
                            validator: (value) {
                              if (cubit.registerType == RegisterType.purchase) {
                                return Validator.requiredNumericValidate(
                                    value, l('validate_purchase_price'));
                              }
                              return null;
                            },
                          ),
                        ),
                        kSpaceHorizontal16,
                        Expanded(
                          child: NumberFormField(
                            label: l('sale_price',
                                ['(${l(appData.mainPreferredCurrency.name)})']),
                            initialValue: data.salePrice,
                            onSaved: cubit.saveSalePrice,
                            validator: (value) {
                              final type = cubit.registerType;
                              debugPrint(type?.name);
                              if (type == RegisterType.sale ||
                                  type == RegisterType.sellOrder) {
                                return Validator.requiredNumericValidate(
                                    value, l('validate_sale_price'));
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    kSpaceVertical16,
                    DatePickerFormField(
                      title: l('purchase_date'),
                      calendar: appData.calendar,
                      initialValue: data.purchaseDate,
                      onChanged: cubit.savePurchaseDate,
                    ),
                    DatePickerFormField(
                      title: l('sale_date'),
                      calendar: appData.calendar,
                      initialValue: data.saleDate,
                      onChanged: cubit.saveSaleDate,
                    ),
                    kSpaceVertical16,
                    SuggestionTextField<AssetOwnership>(
                        label: l('ownership'),
                        initialValue: data.ownership,
                        itemAsString: ((item) => item.title),
                        onSelected: cubit.saveAssetOwnership,
                        validator: (value) => Validator.requiredValidate(
                            value?.title, l('validate_ownership')),
                        getSuggestions: (query) async {
                          return suggestions;
                        }),
                  ],
                ),
                // kSpaceVertical16,
                Text(l('location'), style: kStyleInputTitle),
                const Divider(thickness: 2),
                FormSection(children: [
                  Row(
                    children: [
                      Expanded(
                        child: SuggestionTextField<Province>(
                            label: l('province'),
                            initialValue: data.province,
                            itemAsString: ((item) => item.name),
                            onSelected: cubit.saveProvince,
                            validator: (value) => Validator.requiredValidate(
                                value?.name, l('validate_province')),
                            getSuggestions: (query) async {
                              return [
                                Province(1, 'Tehran'),
                                Province(2, 'Fars'),
                                Province(3, 'West Azarbayjan'),
                                Province(4, 'Ilam'),
                              ];
                            }),
                      ),
                      kSpaceHorizontal16,
                      Expanded(
                        child: SuggestionTextField<City>(
                            label: l('city'),
                            initialValue: data.city,
                            itemAsString: ((item) => item.name),
                            onSelected: cubit.saveCity,
                            validator: (value) => Validator.requiredValidate(
                                value?.name, l('validate_city')),
                            getSuggestions: (query) async {
                              return [
                                City(1, 'Tehran'),
                                City(2, 'Shiraz'),
                                City(3, 'Tabriz'),
                                City(4, 'Urmia'),
                              ];
                            }),
                      )
                    ],
                  ),
                  kSpaceVertical16,
                  Row(
                    children: [
                      Expanded(
                        child: SuggestionTextField<District>(
                            label: l('district'),
                            // showSearch: true,
                            initialValue: data.district,
                            itemAsString: ((item) => item.name),
                            onSelected: cubit.saveDistrict,
                            validator: (value) => Validator.requiredValidate(
                                value?.name, l('validate_district')),
                            getSuggestions: (query) async {
                              return [
                                District(1, 'Azadi'),
                                District(2, 'Saat'),
                                District(3, 'Kahrizak'),
                                District(4, 'IslamAbad'),
                              ];
                            }),
                      ),
                      kSpaceHorizontal16,
                      Expanded(
                          child: MTextFormField(
                        label: l('main_street_name'),
                        initialValue: data.mainStreet,
                        keyboardType: TextInputType.streetAddress,
                        onSaved: cubit.saveMainStreet,
                        validator: (value) => Validator.requiredValidate(
                            value, l('validate_street')),
                      )),
                    ],
                  ),
                  kSpaceVertical16,
                  Row(
                    children: [
                      Expanded(
                        child: MTextFormField(
                          label: l('bystreet_name'),
                          initialValue: data.bystreet,
                          keyboardType: TextInputType.streetAddress,
                          onSaved: cubit.saveBystreet,
                          validator: (value) => Validator.requiredValidate(
                              value, l('validate_bystreet')),
                        ),
                      ),
                      kSpaceHorizontal16,
                      Expanded(
                          child: MTextFormField(
                              label: l('alley'),
                              initialValue: data.alley,
                              keyboardType: TextInputType.streetAddress,
                              onSaved: cubit.saveAlley,
                              validator: (value) => Validator.requiredValidate(
                                  value, l('validate_alley')))),
                    ],
                  ),
                  kSpaceVertical16,
                  Row(
                    children: [
                      Expanded(
                        child: MTextFormField(
                            label: l('plaque'),
                            initialValue: data.plaque,
                            onSaved: cubit.savePlaque,
                            validator: (value) => Validator.requiredValidate(
                                value, l('validate_plaque'))),
                      ),
                      kSpaceHorizontal16,
                      Expanded(
                          child: NumberFormField(
                              label: l('floor'),
                              initialValue: data.floor,
                              onSaved: cubit.saveFloor,
                              validator: (value) =>
                                  Validator.requiredNumericValidate(
                                      value, l('validate_floor')))),
                      kSpaceHorizontal16,
                      Expanded(
                          child: NumberFormField(
                        label: l('unit'),
                        initialValue: data.unit,
                        onSaved: cubit.saveUnit,
                        validator: (value) => Validator.requiredNumericValidate(
                            value, l('validate_unit')),
                      )),
                    ],
                  ),
                ]),
                Text(l('condition'), style: kStyleInputTitle),
                const Divider(thickness: 2),
                FormSection(
                  alignment: CrossAxisAlignment.stretch,
                  children: [
                    FilterChips<String>(
                        title: l('general_facilities'),
                        options: cubit.generalFacilities,
                        asString: (str) => l(str),
                        onChanged: cubit.saveGeneralFacilities),
                    kSpaceVertical16,
                    ChoiceChips<String>(
                        title: l('parking'),
                        initialValue: 'have_not',
                        choices: ['have_not', '1', '2', '3'],
                        onSelected: cubit.saveParking,
                        asString: (str) {
                          if (int.tryParse(str.trim()) != null) {
                            return MaterialLocalizations.of(context)
                                .formatDecimal(int.parse(str));
                          }
                          return l(str);
                        }),
                    kSpaceVertical16,
                    ChoiceChips<String>(
                        title: l('water'),
                        initialValue: l('have_not'),
                        choices: [l('have_not'), l('separate_meter')],
                        onSelected: cubit.saveWater,
                        asString: (str) => str),
                    ChoiceChips<String>(
                        title: l('gas'),
                        initialValue: l('have_not'),
                        onSelected: cubit.saveGas,
                        choices: [l('have_not'), l('separate_meter')],
                        asString: (str) => str),
                    kSpaceVertical16,
                    MultilineTextFormField(
                        label: l('more_details'),
                        onSaved: cubit.saveMoreDetails),
                  ],
                ),
                Text(l('unit_inside_facilities'), style: kStyleInputTitle),
                const Divider(thickness: 2),
                kSpaceVertical32,
                kSpaceVertical32,

                Text(l('nearby_facilities_and_access'),
                    style: kStyleInputTitle),
                const Divider(thickness: 2),
                kSpaceVertical32,
                kSpaceVertical32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionChip(
                      label: Text(l('i_bought')),
                      backgroundColor: Colors.green,
                      onPressed: cubit.registerPurchase,
                    ),
                    ActionChip(
                      label: Text(l('i_sold')),
                      backgroundColor: Colors.red,
                      onPressed: cubit.registerSale,
                    ),
                    ActionChip(
                      label: Text(l('i_want_to_sell')),
                      backgroundColor: Colors.orange,
                      onPressed: cubit.registerSellOrder,
                    ),
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
